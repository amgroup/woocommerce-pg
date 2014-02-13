<?php
/**
 * Admin new order email
 *
 * @author WooThemes
 * @package WooCommerce/Templates/Emails/HTML
 * @version 2.0.0
 */

if ( ! defined( 'ABSPATH' ) ) exit; // Exit if accessed directly

$paid_date = get_post_meta( $order->id, '_paid_date', true );
//if (! $paid_date ) exit;
?>

<?php do_action( 'woocommerce_email_header', $email_heading ); ?>

<h3>
    <?php printf( __( 'You have received the payment from %s for order %s', 'woocommerce' ), $order->billing_first_name . ' ' . $order->billing_last_name, $order->get_order_number() ); ?>,&nbsp;
    <?php printf( '<time datetime="%s">%s</time>', date_i18n( 'c', strtotime( $order->order_date ) ), date_i18n( woocommerce_date_format(), strtotime( $order->order_date ) ) ); ?>.
</h3>

<p><?php _e( 'Payment via', 'woocommerce' ); ?> <?php echo get_post_meta( $order->id, '_payment_method_title', true ); ?> at <?php echo date_i18n( woocommerce_date_format(), strtotime( $paid_date ) ) . ' ' . date_i18n( woocommerce_time_format(), strtotime( $paid_date ) ); ?></p>

<?php

// Shipping Recipient details
$shipping_details = array();
$shipping_name = array();

if( $order->shipping_first_name )
    $shipping_name[] = $order->shipping_first_name;
if( $order->shipping_last_name )
    $shipping_name[] = $order->shipping_last_name;
    
if( !empty($shipping_name) )
    $shipping_details[] = '<strong>' . ( (string) implode(' ', $shipping_name) ) . '</strong>';

if ($order->shipping_phone)
    $shipping_details[] = '<a href="tel:' . preg_replace("/([^0-9]+)/", "", $order->shipping_phone) . '">' . $order->shipping_phone . '</a>';
    
if ($order->shipping_email)
    $shipping_details[] = '<a href="mailto:' . $order->shipping_email . '">' . $order->shipping_email . '</a>';
    
if( !empty( $shipping_details ) ) {

    echo '<h4>' . __( 'Recipient details', 'woocommerce' ) . '</h4>';
    echo '<p>' . implode( ", ",  $shipping_details ) . '</p>';
}


// Billing Customer details
$billing_details = array();
$billing_name = array();

if( $order->billing_first_name )
    $billing_name[] = $order->billing_first_name;
if( $order->billing_last_name )
    $billing_name[] = $order->billing_last_name;
    
if( !empty($billing_name) )
    $billing_details[] = '<strong>' . ( (string) implode(' ', $billing_name) ) . '</strong>';

if ($order->billing_phone)
    $billing_details[] = '<a href="tel:' . preg_replace("/([^0-9]+)/", "", $order->billing_phone) . '">' . $order->billing_phone . '</a>';
    
if ($order->billing_email)
    $billing_details[] = '<a href="mailto:' . $order->billing_email . '">' . $order->billing_email . '</a>';
    
if( !empty( $billing_details ) ) {

    echo '<h4>' . __( 'Customer details', 'woocommerce' ) . '</h4>';
    echo '<p>' . implode( ", ",  $billing_details ) . '</p>';
}

?>
