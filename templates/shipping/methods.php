<?php
/**
 * Shipping Methods
 *
 * @author      CartOn Team
 * @package     WooCommerce/Templates
 * @version     1.0
 */

if ( ! defined( 'ABSPATH' ) ) exit; // Exit if accessed directly

global $woocommerce;

$available_methods = $woocommerce->shipping->get_available_shipping_methods();
$salt = '_' . rand(100000,999999);
?>

<!-- Shipping methods -->
<?php
if ( $available_methods ) {
	// Prepare text labels with price for each shipping method
    echo "<h3>" . __( 'Shipping method', 'woocommerce' ) . "</h3>";
	foreach ( $available_methods as $method ) {
        $changeable = 0;
        if( $method->label_extra ) $changeable = 1;

		if( $woocommerce->session->chosen_shipping_method == $method->id ) {
            
			if( ! isset($method->cost) )
				$method->full_label = $method->label . '<br/>' . $method->label_extra;
			elseif( $method->cost == 0 )
				$method->full_label = $method->label . ' - ' . __( 'Free!', 'woocommerce' ) . '<br/>' . $method->label_extra;
			else
				$method->full_label = $method->label . ' - ' . woocommerce_price($method->cost) . '<br/>' . $method->label_extra;
			
		} else {
			$method->full_label = $method->label;

			if ( ! isset($method->cost) ) {
                $method->full_label .= ' - Узнать сроки и стоимость';
                $method->full_label = '<span class="aslink">' . $method->full_label . '</span>';
            } elseif ( $method->cost == 0 ) {
                $method->full_label .= ' - <span class="free shipping">' . __( 'Free!', 'woocommerce' ) . '</span>';
            } elseif ( $method->cost > 0 ) {
                if ( $woocommerce->cart->tax_display_cart == 'excl' ) {
                    if( $changeable )
                        $method->full_label = '<span class="aslink">' . $method->full_label . '</span>';

                    if( $method->multicost > 1 )
                        $method->full_label .= ' - <span class="aslink">' . woocommerce_price( $method->cost, array('class'=>array('amount','aslink')) ) . '<i class="icon-arrow"></i></span>';
                    else
                        $method->full_label .= ' - ' . woocommerce_price( $method->cost );

                    if ( $method->get_shipping_tax() > 0 && $woocommerce->cart->prices_include_tax )
                        $method->full_label .= ' <small>' . $woocommerce->countries->ex_tax_or_vat() . '</small>';

                } else {
                    $method->full_label .= ' - ' . woocommerce_price( $method->cost + $method->get_shipping_tax() );
                    if ( $method->get_shipping_tax() > 0 && ! $woocommerce->cart->prices_include_tax ) {
                        $method->full_label .= ' <small>' . $woocommerce->countries->inc_tax_or_vat() . '</small>';
                    }
                }
            }           
		}
		$method->full_label = apply_filters( 'woocommerce_cart_shipping_method_full_label', $method->full_label, $method );
	}

	// Print a single available shipping method as plain text
	if ( 1 === count( $available_methods ) ) {
		$checked_id = $method->method_id;
		echo wp_kses_post( $method->full_label ) . '<input type="hidden" name="shipping_method" id="shipping_method" value="' . esc_attr( $method->id ) . '" />';

	// Show select boxes for methods
	} elseif ( get_option('woocommerce_shipping_method_format') == 'select' ) {

		echo '<select class="shipping_method shipping_methods collection" name="shipping_method">';

		foreach ( $available_methods as $method ) {
			$selected = selected( $method->id, $woocommerce->session->chosen_shipping_method, false);
			if( $selected ) $checked_id = $method->method_id;

			echo '<option value="' . esc_attr( $method->id ) . '" ' . selected( $method->id, $woocommerce->session->chosen_shipping_method, false ) . '>' . wp_kses_post( $method->full_label ). '</option>';
		}

		echo '</select>';

	// Show radio buttons for methods
	} else {

		echo '<ul class="shipping_methods collection">';
		foreach ( $available_methods as $method ) {
			$checked = checked( $method->id, $woocommerce->session->chosen_shipping_method, false);
			if( $checked ) $checked_id = $method->method_id;

			echo '<li' . ( $checked ? ' class="checked"' : '' ) . '><input type="radio" class="shipping_method ' . sanitize_title( $method->id ) . '" name="shipping_method" id="shipping_method_' . sanitize_title( $method->id ) . $salt . '" value="' . esc_attr( $method->id ) . '" ' . $checked . ' /> <label for="shipping_method_' . sanitize_title( $method->id ) . $salt . '">' . $method->full_label . '</label></li>';
		}
		echo '</ul>';
	}

// No shipping methods are available
} else {

	if ( ! $woocommerce->customer->get_shipping_country() || ! $woocommerce->customer->get_shipping_state() || ! $woocommerce->customer->get_shipping_postcode() ) {

		echo '<p class="shipping_methods collection">' . __( 'Please choose product options to see available shipping methods.', 'woocommerce' ) . '</p>';

	} else {

		$customer_location = $woocommerce->countries->countries[ $woocommerce->customer->get_shipping_country() ];

		echo apply_filters( 'woocommerce_no_shipping_available_html',
			'<p class="shipping_methods collection">' .
			sprintf( __( 'Sorry, it seems that there are no available shipping methods for your location (%s).', 'woocommerce' ) . ' ' . __( 'If you require assistance or wish to make alternate arrangements please contact us.', 'woocommerce' ), $customer_location ) .
			'</p>'
		);
	}
}
?>
<input type="hidden" name="shipping_method_variant" value="<?php echo $woocommerce->session->chosen_shipping_method_variant; ?>" />
<input type="hidden" name="shipping_method_sub_variant" value="<?php echo $woocommerce->session->chosen_shipping_method_sub_variant; ?>" />

<script type="text/javascript">
	jQuery(document).ready(function($) {
	    var xhr_m;
	    var xhr_r;
	    var xhr_sf;
	    var xhr_bf;
	    var block_css = { message: null, overlayCSS: {background: '#fff url(' + woocommerce_params.ajax_loader_url + ') no-repeat center', backgroundSize: '16px 16px', opacity: 0.6 }};
        
        // Update shipping methods

        function update_shipping_methods(data) {
            if( $( '.shipping_methods.collection' ).size() ) {
		$( '.shipping_methods.collection' ).parent().block(block_css);

		$.extend( data, {
		    shipping_method: $('.shipping_method:checked').val() || $('.shipping_method').val(),
		    action:  'woocommerce_shipping_methods_form',
		    security: woocommerce_params.shipping_methods_nonce
		});

                if (xhr_m) xhr_m.abort();
			    xhr_m = $.ajax({
				    type:		'POST',
				    url:		woocommerce_params.ajax_url,
				    data:		data,
				    success:	function(response) {
					    $('.shipping_methods.collection').parent().empty().unblock().html( $(response) );
				    }
			    });

		}
        }

        // Update order_review        
        function update_order_review(data) {
            if( $( '#order_review' ).size() ) {
			    $( '#order_review').block(block_css);

		        $.extend(data, {
			        action:		'woocommerce_update_order_review',
			        security: 	woocommerce_params.update_order_review_nonce
		        });

                if (xhr_r) xhr_r.abort();
			    xhr_r = $.ajax({
				    type:		'POST',
				    url:		woocommerce_params.ajax_url,
				    data:		data,
				    success:	function(response) {
					    $( '#order_review' ).unblock().html( $(response) );
				    }
			    });
			}        
        }

        // Update shipping fields        
        function update_shipping_fields(data) {
			if( $( '#checkout_shipping_address' ).size() ) {
			    $( '#checkout_shipping_address').parent().block(block_css);

		        $.extend(data, {
			        action:		'checkout_shipping_form',
			        security: 	woocommerce_params.checkout_shipping_form_nonce
		        });

                if (xhr_sf) xhr_sf.abort();
			    xhr_sf = $.ajax({
				    type:		'POST',
				    url:		woocommerce_params.ajax_url,
				    data:		data,
				    success:	function(response) {
					    $( '#checkout_shipping_address' ).html( $(response) );
					    $( '#checkout_shipping_address' ).parent().unblock();
				    }
			    });
			}        
        }

		// Update billing fields        
        function update_billing_fields(data) {
			if( $( '#checkout_billing_address' ).size() ) {
			    $( '#checkout_billing_address').parent().block(block_css);

		        $.extend(data, {
			        action:		'checkout_billing_form',
			        security: 	woocommerce_params.checkout_billing_form_nonce
		        });

                if (xhr_bf) xhr_bf.abort();
			    xhr_bf = $.ajax({
				    type:		'POST',
				    url:		woocommerce_params.ajax_url,
				    data:		data,
				    success:	function(response) {
					    $( '#checkout_billing_address' ).html( $(response) );
					    $( '#checkout_billing_address' ).parent().unblock();
				    }
			    });
			}        
        }

        // Get Form Data
        function get_form_data(el) {
            var data = {};

            $.each( $(el).closest('form').serializeArray(), function() {
                if (data[this.name] !== undefined) {
                    if (!data[this.name].push)
                        data[this.name] = [data[this.name]];
                    data[this.name].push(this.value || '');
                } else {
                    data[this.name] = this.value || '';
                }
            });
            return data;
        }
        
		$('.shipping_method').change(function(){
			var data = get_form_data(this);
            
            update_shipping_methods( data );
            update_order_review( data );
            update_shipping_fields( data );
            update_billing_fields( data );
		});
        
        
		$("input[name=\'shipping_method_variant\']:first" ).change(function(){
			var data = get_form_data(this);

            update_shipping_methods( data );
            update_shipping_methods( data );
            update_order_review( data );
		});
        
		$("input[name=\'shipping_method_sub_variant\']:first" ).change(function(){
			var data = get_form_data(this);

            update_shipping_methods( data );
            update_order_review( data );
            update_shipping_fields( data );
            update_billing_fields( data );
		});
	});
</script>
<!-- /Shipping methods -->

