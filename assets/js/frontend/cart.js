jQuery(document).ready(function($) {

	// Shipping calculator
	$(document)
		.on( 'click', '.shipping-calculator-button', function() {
			$('.shipping-calculator-form').slideToggle('slow');
			return false;
		})
		.on( 'updated:shipping_method', function() {
			var $form = $('*[name=shipping_method]:first').closest('form');
			var data = closest_form_data( $form );
			var block_css = {message: null, overlayCSS: {background: '#fff url(' + woocommerce_params.ajax_loader_url + ') no-repeat center', backgroundSize: '16px 16px', opacity: 0.6}};

			//$('.shop_table.cart').block( block_css );
			
			$('.cart_totals tr').each(function(){
					var $this = $(this);
					if( $this.hasClass('shipping') ) return;
					$this.find('td').block( block_css );
			});

			$.post( $form.attr('action'), data, function(response) {
				//$('table.shop_table.cart').replaceWith( $(response).find('table.shop_table.cart') ).unblock();

				$('.cart_totals tr').each(function(){
					var $this = $(this);
					if( $this.hasClass('shipping') ) return;
					$this.replaceWith( $(response).find( ".cart_totals tr." + ( $this.attr("class") ).replace( " ", "." ) ) ).unblock();
				});
			});
		})

	$('.shipping-calculator-form').hide();
});