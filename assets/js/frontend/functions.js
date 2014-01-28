/*
 * Carton Functions
 */

// It gets data from closest html form as a hash array (for ajax post query etc.). Using jQuery.
function closest_form_data(el) {
    var data = {};

    jQuery.each( jQuery(el).closest('form').serializeArray(), function() {
        if ( data[this.name] !== undefined ) {
            if ( !data[this.name].push )
                data[this.name] = [data[this.name]];
            data[this.name].push(this.value || '');
        } else {
            data[this.name] = this.value || '';
        }
    });
    return data;
}

