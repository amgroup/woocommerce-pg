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
<pre>
<?php //var_dump($woocommerce->session) ?>
</pre>
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

		echo '<select class="shipping_method shipping_methods collection' . ($ajax ? ' async' : ' sync') . '" name="shipping_method">';

		foreach ( $available_methods as $method ) {
			$selected = selected( $method->id, $woocommerce->session->chosen_shipping_method, false);
			if( $selected ) $checked_id = $method->method_id;

			echo '<option value="' . esc_attr( $method->id ) . '" ' . selected( $method->id, $woocommerce->session->chosen_shipping_method, false ) . '>' . wp_kses_post( $method->full_label ). '</option>';
		}

		echo '</select>';

	// Show radio buttons for methods
	} else {

		echo '<ul class="shipping_methods collection' . ($ajax ? ' async' : ' sync') . '">';
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

		echo '<p class="shipping_methods collection' . ($ajax ? ' async' : ' sync') . '">' . __( 'Please choose product options to see available shipping methods.', 'woocommerce' ) . '</p>';

	} else {

		$customer_location = $woocommerce->countries->countries[ $woocommerce->customer->get_shipping_country() ];

		echo apply_filters( 'woocommerce_no_shipping_available_html',
			'<p class="shipping_methods collection' . ($ajax ? ' async' : ' sync') . '">' .
			sprintf( __( 'Sorry, it seems that there are no available shipping methods for your location (%s).', 'woocommerce' ) . ' ' . __( 'If you require assistance or wish to make alternate arrangements please contact us.', 'woocommerce' ), $customer_location ) .
			'</p>'
		);
	}
}
?>
<input type="hidden" name="shipping_method_variant" value="<?php echo $woocommerce->session->chosen_shipping_method_variant; ?>" />
<input type="hidden" name="shipping_method_sub_variant" value="<?php echo $woocommerce->session->chosen_shipping_method_sub_variant; ?>" />
