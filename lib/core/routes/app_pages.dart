
import 'package:get/get.dart';
import '../../feature/auth/presentation/pages/auth_page.dart';
import '../../feature/auth/presentation/pages/change_password_page.dart';
import '../../feature/auth/presentation/pages/forgot_pass_page.dart';
import '../../feature/auth/presentation/pages/otp_screen.dart';
import '../../feature/auth/presentation/pages/splash_page.dart';
import '../../feature/admin/main_admin/presentation/pages/main_page_admin.dart';
import '../../feature/client/main_client/presentation/pages/client__request_for_delete_page.dart';
import '../../feature/client/main_client/presentation/pages/main_page_client.dart';
import '../../feature/client/main_client/presentation/pages/profile_page.dart';

part 'app_routes.dart';

class MyMiddleWare extends GetMiddleware {
  @override
  GetPage? onPageCalled(GetPage? page) {
    print(page?.name);
    return super.onPageCalled(page);
  }
}

abstract class AppPages {
  static final pages = [
    GetPage(
      name: Routes.SPLASH,
      page: () => const SplashPage(),
    ),
    GetPage(
      name: Routes.AUTH,
      page: () =>  AuthPage(),
      middlewares: [MyMiddleWare()],
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: Routes.MAINADMIN,
      page: () => const MainPageAdmin(),
      middlewares: [MyMiddleWare()],
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: Routes.MAINCLIENT,
      page: () =>  const MainPageClient(),
      middlewares: [MyMiddleWare()],
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: Routes.PROFILE,
      page: () =>  ProfilePage(),
      middlewares: [MyMiddleWare()],
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500),
    ),


    GetPage(
      name: Routes.deleteRequestAccount,
      page: () =>  ClientRequestForDeleteAccount(),
      middlewares: [MyMiddleWare()],
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    // GetPage(
    //   name: Routes.ADD_ITEM,
    //   page: () => const AddItemPage(),
    //   binding: AddItemBinding(),
    //   middlewares: [MyMiddleWare()],
    //   transition: Transition.fadeIn,
    //   transitionDuration: const Duration(milliseconds: 500),
    // ),
    GetPage(
      name: Routes.FORGOTPASS,
      page: () =>  ForgotPassPage(),
      middlewares: [MyMiddleWare()],
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500),
    ),

    GetPage(
      name: Routes.OTPSCREEN,
      page: () =>  OtpScreen(),
      middlewares: [MyMiddleWare()],
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500),
    ),

    GetPage(
      name: Routes.PASSRESET,
      page: () =>  ResetPasswordPage(),
      middlewares: [MyMiddleWare()],
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    // GetPage(
    //   name: Routes.MY_PRODUCTS,
    //   page: () => const MyProductsPage(),
    //   binding: MyProductsBinding(),
    //   middlewares: [MyMiddleWare()],
    //   transition: Transition.fadeIn,
    //   transitionDuration: const Duration(milliseconds: 500),
    // ),
    // GetPage(
    //   name: Routes.PRODUCT_DETAILS,
    //   page: () => const ProductDetailsPage(),
    //   binding: ProductDetailsBinding(),
    //   middlewares: [MyMiddleWare()],
    //   transition: Transition.fadeIn,
    //   transitionDuration: const Duration(milliseconds: 500),
    // ),
    // GetPage(
    //   name: Routes.MY_CART,
    //   page: () => const MyCartPage(),
    //   binding: MyCartBinding(),
    //   middlewares: [MyMiddleWare()],
    //   transition: Transition.fadeIn,
    //   transitionDuration: const Duration(milliseconds: 500),
    // ),
    // GetPage(
    //   name: Routes.BUY,
    //   page: () => const BuyPage(),
    //   binding: BuyBinding(),
    //   middlewares: [MyMiddleWare()],
    //   transition: Transition.fadeIn,
    //   transitionDuration: const Duration(milliseconds: 500),
    // ),
    // GetPage(
    //   name: Routes.MY_ORDERS,
    //   page: () => const MyOrdersPage(),
    //   binding: MyOrdersBinding(),
    //   middlewares: [MyMiddleWare()],
    //   transition: Transition.fadeIn,
    //   transitionDuration: const Duration(milliseconds: 500),
    // ),
    // GetPage(
    //   name: Routes.PROFILE,
    //   page: () => const ProfilePage(),
    //   binding: ProfileBinding(),
    //   middlewares: [MyMiddleWare()],
    //   transition: Transition.fadeIn,
    //   transitionDuration: const Duration(milliseconds: 500),
    // ),
    // GetPage(
    //   name: Routes.NOTIFICATIONS,
    //   page: () => const NotificationsPage(),
    //   binding: NotificationsBinding(),
    //   middlewares: [MyMiddleWare()],
    //   transition: Transition.fadeIn,
    //   transitionDuration: const Duration(milliseconds: 500),
    // ),
    // GetPage(
    //   name: Routes.UPDATE_PRODUCT,
    //   page: () => const UpdateProductPage(),
    //   binding: UpdateProductBinding(),
    //   middlewares: [MyMiddleWare()],
    //   transition: Transition.fadeIn,
    //   transitionDuration: const Duration(milliseconds: 500),
    // ),
    // GetPage(
    //   name: Routes.ABOUT_US,
    //   page: () => const AboutUsPage(),
    //   binding: AboutUsBinding(),
    //   middlewares: [MyMiddleWare()],
    //   transition: Transition.fadeIn,
    //   transitionDuration: const Duration(milliseconds: 500),
    // ),
    //
    // GetPage(
    //   name: Routes.REVIEW,
    //   page: () => ReviewPage(),
    //   binding: ReviewBinding(),
    //   middlewares: [MyMiddleWare()],
    //   transition: Transition.fadeIn,
    //   transitionDuration: const Duration(milliseconds: 500),
    // ),
  ];
}
