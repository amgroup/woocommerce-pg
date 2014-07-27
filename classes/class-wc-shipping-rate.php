<?php
/**
 * WooCommerce Shipping Rate Class
 *
 * Simple Class for storing rates.
 *
 * @class 		WC_Shipping_Rate
 * @version		2.0.0
 * @package		WooCommerce/Classes/Shipping
 * @category	Class
 * @author 		WooThemes
 */

if ( ! defined( 'ABSPATH' ) ) exit; // Exit if accessed directly

class WC_Shipping_Rate {

	var $id 		= '';
	var $label 		= '';
	var $label_extra= '';
        var $multicost  = 0;
	var $cost 		= 0;
	var $cost_real  = 0;
	var $info       = array();
	var $taxes 		= array();
	var $method_id	= '';
	var $options    = '';

	/**
	 * __construct function.
	 *
	 * @access public
	 * @param mixed $id
	 * @param mixed $label
	 * @param mixed $cost
	 * @param mixed $taxes
	 * @return void
	 */
	public function __construct( $id, $label=null, $multicost=null, $cost=null, $cost_real=null, $taxes=null, $method_id=null, $label_extra=null, $info=null ) {
	    if( is_array($id) ) {
		$this->id 		= $id['id'];
		$this->label 		= $id['label'];
		$this->label_extra	= $id['label_extra'];
    		$this->multicost 	= $id['multicost'];
		$this->cost 		= $id['cost'];
		$this->cost_real	= $id['cost_real'];
		$this->taxes 		= $id['taxes'] ? $id['taxes'] : array();
		$this->info 		= $id['info'] ? $id['info'] : array();
		$this->method_id 	= $id['method_id'];
		$this->options		= null;
	    } else {
		$this->id 		= $id;
		$this->label 		= $label;
		$this->label_extra	= $label_extra;
    		$this->multicost 	= $multicost;
		$this->cost 		= $cost;
		$this->cost_real	= $cost_real;
		$this->taxes 		= $taxes ? $taxes : array();
		$this->info 		= $info ? $info : array();
		$this->method_id 	= $method_id;
		$this->options		= null;
	    }
	}

	/**
	 * get_shipping_tax function.
	 *
	 * @access public
	 * @return array
	 */
	function get_shipping_tax() {
		$taxes = 0;
		if ( $this->taxes && sizeof( $this->taxes ) > 0 )
			$taxes = array_sum( $this->taxes );
		return $taxes;
	}
}
