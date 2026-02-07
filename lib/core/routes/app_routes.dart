class AppRoutes {
  AppRoutes._();

  // Auth Routes
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String register = '/register';
  static const String forgotPassword = '/forgot-password';
  static const String verifyOtp = '/verify-otp';

  // Main Routes
  static const String main = '/main';
  static const String home = '/main/home';
  static const String explore = '/main/explore';
  static const String notifications = '/main/notifications';
  static const String profile = '/main/profile';

  // Debt
   static const String addDebt = '/debt/add';
   static const String detailDebt = '/debt/detail';
   static const String editDebt = '/debt/edit';

  // Feature Routes
  static const String productDetail = '/product/:id';
  static const String category = '/category/:id';
  static const String search = '/search';
  static const String cart = '/cart';
  static const String checkout = '/checkout';
  static const String orderHistory = '/order-history';
  static const String orderDetail = '/order/:id';
  static const String favorites = '/favorites';

  // Profile Routes
  static const String editProfile = '/edit-profile';
  static const String settings = '/settings';
  static const String changePassword = '/change-password';
  static const String addresses = '/addresses';
  static const String addAddress = '/addresses/add';
  static const String editAddress = '/addresses/edit/:id';
  static const String paymentMethods = '/payment-methods';
  static const String helpCenter = '/help-center';
  static const String about = '/about';
  static const String privacyPolicy = '/privacy-policy';
  static const String termsConditions = '/terms-conditions';

  // Additional Routes
  static const String chat = '/chat';
  static const String chatDetail = '/chat/:id';
  static const String reviews = '/reviews/:productId';
  static const String writeReview = '/write-review/:productId';
  static const String imagePreview = '/image-preview';
  static const String webView = '/webview';
}

class AppRoutePaths {
  AppRoutePaths._();

  static String productDetail(String id) => '/product/$id';
  static String category(String id) => '/category/$id';
  static String orderDetail(String id) => '/order/$id';
  static String chatDetail(String id) => '/chat/$id';
  static String reviews(String productId) => '/reviews/$productId';
  static String writeReview(String productId) => '/write-review/$productId';
  static String editAddress(String id) => '/addresses/edit/$id';
}