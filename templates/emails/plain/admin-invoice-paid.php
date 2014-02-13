<?php
/**
 * Admin new order email (plain text)
 *
 * @author		WooThemes
 * @package 	WooCommerce/Templates/Emails/Plain
 * @version 	2.0.0
 */
if ( ! defined( 'ABSPATH' ) ) exit; // Exit if accessed directly

echo $email_heading . "\n\n";

echo sprintf( __( 'You have received the payment from %s for order %s', 'woocommerce' ), $order->billing_first_name . ' ' . $order->billing_last_name, $order->get_order_number() ) . "\n\n";
echo sprintf( __( 'Order date: %s', 'woocommerce'), date_i18n( __( 'jS F Y', 'woocommerce' ), strtotime( $order->order_date ) ) ) . "\n";

echo "\n****************************************************\n\n";

_e( 'Customer details', 'woocommerce' );

if ( $order->billing_email )
	echo __( 'Email:', 'woocommerce' ); echo $order->billing_email. "\n";

if ( $order->billing_phone )
	echo __( 'Tel:', 'woocommerce' ); ?> <?php echo $order->billing_phone. "\n";
echo "\n****************************************************\n\n";

echo apply_filters( 'woocommerce_email_footer_text', get_option( 'woocommerce_email_footer_text' ) );