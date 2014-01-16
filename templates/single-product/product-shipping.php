<?php
/**
 * Single Product Shipping
 *
 * @author      Andrey
 * @package     WooCommerce/Templates
 * @version     1.0
 */

global $product;
?>

<!-- Shipping methods -->
<div class="delivery-box">
    <div><?php woocommerce_get_template( 'shipping/methods.php' ); ?></div>
    <small>* <em>стоимость доставки вашей корзины <strong>вместе с этим товаром</strong></em></small>
</div>
<!-- /Shipping methods -->

