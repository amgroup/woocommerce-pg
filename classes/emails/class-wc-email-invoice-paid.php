<?php

if ( ! defined( 'ABSPATH' ) ) exit; // Exit if accessed directly

/**
 * WC_Email_Invoice_Paid
 *
 * Order emails are sent when an order marked as paid for.
 *
 * @class 		WC_Email_Invoice_Paid
 * @version		2.0.0
 * @package		WooCommerce/Classes/Emails
 * @author 		WooThemes
 * @extends 		WC_Email
 */
class WC_Email_Invoice_Paid extends WC_Email {

	/**
	 * Constructor
	 */
	function __construct() {

		$this->id 			= 'invoice_paid';
		$this->title 			= __( 'Invoice Paid', 'woocommerce' );
		$this->description		= __( 'Order emails are sent when an order marked as paid for.', 'woocommerce' );

		$this->heading 			= __( 'Payment Received', 'woocommerce' );
		$this->subject      	= __( '[{blogname}] We got payment for ({order_number}) - {order_date}', 'woocommerce' );
		$this->template_html 	= 'emails/admin-invoice-paid.php';
		$this->template_plain 	= 'emails/plain/admin-invoice-paid.php';

		// Triggers for this email
		add_action( 'woocommerce_payment_complete', array( $this, 'trigger' ) );

		// Call parent constructor
		parent::__construct();

		// Other settings
		$this->recipient = $this->get_option( 'recipient' );

		if ( ! $this->recipient )
			$this->recipient = get_option( 'admin_email' );

	}

	/*
         * get_attachments function.
         *
         * @access public
         * @return string
         */
        function get_attachments($order_id) {
                return apply_filters( 'woocommerce_email_attachments_' . $this->id, $order_id );
        }

	/**
	 * trigger function.
	 *
	 * @access public
	 * @return void
	 */
	function trigger( $order_id ) {
		global $woocommerce;

		if ( $order_id ) {
			$this->object 		= new WC_Order( $order_id );

			$this->find[] = '{order_date}';
			$this->replace[] = date_i18n( woocommerce_date_format(), strtotime( $this->object->order_date ) );

			$this->find[] = '{order_number}';
			$this->replace[] = $this->object->get_order_number();
		}

		if ( ! $this->is_enabled() || ! $this->get_recipient() )
			return;

		$this->send( $this->get_recipient(), $this->get_subject(), $this->get_content(), $this->get_headers(), $this->get_attachments($order_id) );
	}

	/**
	 * get_content_html function.
	 *
	 * @access public
	 * @return string
	 */
	function get_content_html() {
		ob_start();
		woocommerce_get_template( $this->template_html, array(
			'order' 	=> $this->object,
			'email_heading' => $this->get_heading()
		) );
		return ob_get_clean();
	}

	/**
	 * get_content_plain function.
	 *
	 * @access public
	 * @return string
	 */
	function get_content_plain() {
		ob_start();
		woocommerce_get_template( $this->template_plain, array(
			'order'		=> $this->object,
			'email_heading' => $this->get_heading()
		) );
		return ob_get_clean();
	}

    /**
     * Initialise Settings Form Fields
     *
     * @access public
     * @return void
     */
    function init_form_fields() {
    	$this->form_fields = array(
			'enabled' => array(
				'title' 		=> __( 'Enable/Disable', 'woocommerce' ),
				'type' 			=> 'checkbox',
				'label' 		=> __( 'Enable this email notification', 'woocommerce' ),
				'default' 		=> 'yes'
			),
			'recipient' => array(
				'title' 		=> __( 'Recipient(s)', 'woocommerce' ),
				'type' 			=> 'text',
				'description' 	=> sprintf( __( 'Enter recipients (comma separated) for this email. Defaults to <code>%s</code>.', 'woocommerce' ), esc_attr( get_option('admin_email') ) ),
				'placeholder' 	=> '',
				'default' 		=> ''
			),
			'subject' => array(
				'title' 		=> __( 'Subject', 'woocommerce' ),
				'type' 			=> 'text',
				'description' 	=> sprintf( __( 'This controls the email subject line. Leave blank to use the default subject: <code>%s</code>.', 'woocommerce' ), $this->subject ),
				'placeholder' 	=> '',
				'default' 		=> ''
			),
			'heading' => array(
				'title' 		=> __( 'Email Heading', 'woocommerce' ),
				'type' 			=> 'text',
				'description' 	=> sprintf( __( 'This controls the main heading contained within the email notification. Leave blank to use the default heading: <code>%s</code>.', 'woocommerce' ), $this->heading ),
				'placeholder' 	=> '',
				'default' 		=> ''
			),
			'email_type' => array(
				'title' 		=> __( 'Email type', 'woocommerce' ),
				'type' 			=> 'select',
				'description' 	=> __( 'Choose which format of email to send.', 'woocommerce' ),
				'default' 		=> 'html',
				'class'			=> 'email_type',
				'options'		=> array(
					'plain'		 	=> __( 'Plain text', 'woocommerce' ),
					'html' 			=> __( 'HTML', 'woocommerce' ),
					'multipart' 	=> __( 'Multipart', 'woocommerce' ),
				)
			)
		);
    }
}