import 'package:get/get.dart';

import '../views/splash/splash_view.dart';
import '../views/auth/login_view.dart';
import '../views/auth/register_view.dart';
import '../views/scan/scan_view.dart';
import '../views/scan/loading_view.dart';
import '../views/result/result_view.dart';
import '../views/recommendation/recommendation_view.dart';
import '../views/dashboard/dashboard_view.dart';
import '../views/progress/progress_view.dart';
import '../views/profile/profile_view.dart';
import '../views/notification/notification_view.dart';
import '../views/scan/question_view.dart';

import '../controllers/auth_controller.dart';
import '../controllers/scan_controller.dart';
import '../controllers/result_controller.dart';
import '../controllers/progress_controller.dart';
import '../controllers/dashboard_controller.dart';

import 'app_routes.dart';

class AppPages {
  static final routes = [

    /// SPLASH
    GetPage(
      name: AppRoutes.splash,
      page: () => SplashView(),
    ),

    /// LOGIN
    GetPage(
      name: AppRoutes.login,
      page: () => LoginView(),
      binding: BindingsBuilder(() {
        Get.lazyPut<AuthController>(() => AuthController(), fenix: true);
      }),
    ),

    /// REGISTER
    GetPage(
      name: AppRoutes.register,
      page: () => RegisterView(),
      binding: BindingsBuilder(() {
        Get.lazyPut<AuthController>(() => AuthController(), fenix: true);
      }),
    ),

    /// SCAN
    GetPage(
      name: AppRoutes.scan,
      page: () => ScanView(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => ScanController());
      }),
    ),

    /// LOADING
    GetPage(
      name: AppRoutes.loading,
      page: () => LoadingView(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => ResultController());
      }),
    ),

    /// RESULT
    GetPage(
      name: AppRoutes.result,
      page: () => ResultView(),
    ),

    /// RECOMMENDATION
    GetPage(
      name: AppRoutes.recommendation,
      page: () => RecommendationView(),
    ),

    /// 🔥 DASHBOARD (FIX TOTAL)
    GetPage(
      name: AppRoutes.dashboard,
      page: () => DashboardView(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => DashboardController());
      }),
    ),

    /// PROGRESS
    GetPage(
      name: AppRoutes.progress,
      page: () => ProgressView(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => ProgressController());
      }),
    ),

    /// PROFILE
    GetPage(
      name: AppRoutes.profile,
      page: () => ProfileView(),
    ),

    GetPage(
      name: AppRoutes.notification,
      page: () => const NotificationView(),
    ),

    GetPage(
  name: AppRoutes.question,
  page: () => const QuestionView(),
),
  ];
}