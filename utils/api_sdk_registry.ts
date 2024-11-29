const apiSdkRegistry: any = {
  'registration-api': { version: '', method: 'customer_signup', entity: 'registration' },
  'guest-login-api': { version: '', method: 'existing_user_signin', entity: 'signin' },
  'otp-login-api': { version: '', method: 'signin', entity: 'signin' },
  'google-login-api': { version: '', method: 'signin', entity: 'signin' },
  'login-api': { version: '', method: 'get_access_token', entity: 'access_token' },
  'default-currency-api': { version: '', method: 'get_default_currency', entity: 'product' },
  'multi-language-data-api': { version: '', methiod: 'get_languages', entity: 'translation' },
  'navbar-api': { version: '', method: 'get_mega_menu', entity: 'mega_menu' },
  'banner-api': { version: '', method: 'get', entity: 'banner' },
  'display-tags-api': { version: '', method: 'get_tagged_products', entity: 'product' },
  'breadcrums-api': { version: '', method: 'breadcrums', entity: 'mega_menu' },
  'get-product-listing-filters-api': { version: '', method: 'get_filters', entity: 'filter' },
  'product-list-api': { version: '', method: 'get_list', entity: 'product' },
  'catalog-product-list-api': { version: '', method: 'get_items', entity: 'catalog' },
  'brand-product-list-api': { version: '', method: 'get_list', entity: 'product' },
  'product-detail-api': { version: '', method: 'get_details', entity: 'product' },
  'product-variants-api': { version: '', method: 'get_variants', entity: 'variant' },
  'get-wishlist-items-api': { version: '', method: 'get_wishlist_items', entity: 'wishlist' },
  'add-item-to-wishlist-api': { version: '', method: 'add_to_wishlist', entity: 'wishlist' },
  'remove-item-from-wishlist-api': { version: '', method: 'remove_from_wishlist', entity: 'wishlist' },
  'get-cart-list-items-api': { version: '', method: 'get_list', entity: 'cart' },
  'add-cart-api': { version: '', method: 'put_products', entity: 'cart' },
  'clear-cart-api': { version: '', method: 'clear_cart', entity: 'cart' },
  'remove-single-item-cart-api': { version: '', method: 'delete_products', entity: 'cart' },
  'order-list-api': { version: '', method: 'get_orders', entity: 'order' },
  'order-detail-api': { version: '', method: 'get_order_detail', entity: 'order' },
  'user-permission-api': { version: '', method: 'ready_to_dispatch_permission', entity: 'user_permission' },
  'order-reports-api': { version: '', method: 'report_data', entity: 'sales_order_report' },
  'bulk-order-cancel-api': { version: '', method: 'sales_order_cancel', entity: 'sales_order' },
  'update-customer-name-api': { version: '', method: 'update_customer_name_for_cart', entity: 'cart' },
  'ready-to-dispatch-api': { version: '', method: 'update_soid_completed_status', entity: 'user_permission' },
  'delete-order-api': { version: '', method: 'delete_soid_and_child_item', entity: 'user_permission' },
};

export default apiSdkRegistry;
