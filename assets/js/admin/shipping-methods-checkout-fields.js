
jQuery(document).ready( function(){

    function update_shipping_checkout_fields_required() {
	var sel_1 = jQuery(".chosen_select.shipping_checkout_fields");
	var sel_2 = jQuery(".chosen_select.shipping_checkout_fields_required");
	var checked = sel_1.val();

	sel_2.find("option").addClass( "wrong" );

	for( var val in checked ) {
	    var sel_1_opt = sel_1.find("option[value='" + checked[val] + "']");
	    var sel_2_opt = sel_2.find("option[value='" + checked[val] + "']");
	    
	    if( sel_2_opt.length == 0 ) {
		sel_2.append( "<option value=\"" + checked[val] + "\">" + sel_1_opt.text() + "</option>" );
	    } else {
		sel_2_opt.removeClass( "wrong" );
	    }
	}
	sel_2.find("option.wrong").remove();
	sel_2.trigger("liszt:updated");
    }

    jQuery(".chosen_select.shipping_checkout_fields" ).change(update_shipping_checkout_fields_required);
    update_shipping_checkout_fields_required();
});

