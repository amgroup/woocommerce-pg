jQuery(document).ready(function($) {

	$(document)
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
		});

	$('p.password, form.login, .checkout_coupon, div.shipping_address').hide();

	$('input.show_password').change(function(){
		$('p.password').slideToggle();
	});

	$('a.showlogin').click(function(){
		$('form.login').slideToggle();
		return false;
	});

	$('a.showcoupon').click(function(){
		$('.checkout_coupon').slideToggle();
		$('#coupon_code').focus();
		return false;
	});

	$('#shiptobilling input').change(function(){
		$('div.shipping_address').hide();
		if (!$(this).is(':checked')) {
			$('div.shipping_address').slideDown();
		}
	}).change();

	if ( woocommerce_params.option_guest_checkout == 'yes' ) {

		$('div.create-account').hide();

		$('input#createaccount').change(function(){
			$('div.create-account').hide();
			if ($(this).is(':checked')) {
				$('div.create-account').slideDown();
			}
		}).change();

	}

	/* Payment option selection */
	$('#order_review')
	.on( 'click', '.payment_methods input.input-radio', function() {
		if ( $('.payment_methods input.input-radio').length > 1 ) {
			$('div.payment_box').filter(':visible').slideUp(250);
			if ($(this).is(':checked')) {
				$('div.payment_box.' + $(this).attr('ID')).slideDown(250);
			}
		} else {
			$('div.payment_box').show();
		}
	})

	// Trigger initial click
	.find('input[name=payment_method]:checked').click();
});

