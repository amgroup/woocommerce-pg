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
	    }

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
					    update_order_review( data );
					    update_shipping_fields( data );
					    update_billing_fields( data );
				    },
				    error:	function(response) {
					    $('.shipping_methods.collection').parent().empty().unblock();
					    update_order_review( data );
					    update_shipping_fields( data );
					    update_billing_fields( data );
				    }
			    });

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
        
	$('.shipping_method, input[name=shipping_method_variant]:first, input[name=shipping_method_sub_variant]:first').live("change", function(){
		update_shipping_methods( get_form_data(this) );
	});
        
	    if( $( ".shipping_methods.collection" ).hasClass("sync" ) ) {
		$( ".shipping_methods.collection" ).parent().block(block_css);
			var data = get_form_data( $( ".shipping_methods.collection" ) );

			    $.extend( data, {
				shipping_method: $(".shipping_method:checked").val() || $('.shipping_method').val(),
			        action:  "woocommerce_shipping_methods",
				security: woocommerce_params.shipping_methods_nonce
			    });

			    if (xhr_m) xhr_m.abort();
			    xhr_m = $.ajax({
				type:		"POST",
				url:		woocommerce_params.ajax_url,
				data:		data,
				success:	function(response) {
				    $(".shipping_methods.collection").parent().empty().unblock().html( $(response) );
				}
			    });
	    }
	});
