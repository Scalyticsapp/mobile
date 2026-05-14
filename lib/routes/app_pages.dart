import 'package:get/get.dart';

import '../views/splash/splash_view.dart';
import '../views/auth/login_view.dart';
import '../views/auth/register_view.dart';
import '../views/scan/scan_view.dart';
import '../views/scan/loading_view.dart';
import '../views/scan/question_view.dart';
import '../views/result/result_view.dart';
import '../views/recommendation/recommendation_view.dart';
import '../views/dashboard/dashboard_view.dart';
import '../views/progress/progress_view.dart';
import '../views/profile/profile_view.dart';
import '../views/notification/notification_view.dart';
import '../views/progress/scan_detail_view.dart';

import '../controllers/auth_controller.dart';
import '../controllers/scan_controller.dart';
import '../controllers/result_controller.dart';
import '../controllers/progress_controller.dart';
import '../controllers/dashboard_controller.dart';

import 'app_routes.dart';

class AppPages {
  static final routes = [

    GetPage(
      name: AppRoutes.splash,
      page: () => SplashView(),
    ),

    GetPage(
      name: AppRoutes.login,
      page: () => LoginView(),
      binding: BindingsBuilder(() {
        Get.lazyPut<AuthController>(() => AuthController(), fenix: true);
      }),
    ),

    GetPage(
      name: AppRoutes.register,
      page: () => RegisterView(),
      binding: BindingsBuilder(() {
        Get.lazyPut<AuthController>(() => AuthController(), fenix: true);
      }),
    ),

    GetPage(
      name: AppRoutes.dashboard,
      page: () => DashboardView(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => DashboardController());
      }),
    ),

    GetPage(
      name: AppRoutes.scan,
      page: () => ScanView(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => ScanController());
      }),
    ),

    GetPage(
      name: AppRoutes.loading,
      page: () => LoadingView(),
    ),

    // QuestionView: StatefulWidget, tidak perlu controller binding
    GetPage(
      name: AppRoutes.question,
      page: () => const QuestionView(),
    ),

    // ✅ ResultView: pakai ResultController binding
    GetPage(
      name: AppRoutes.result,
      page: () => const ResultView(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => ResultController());
      }),
    ),

    GetPage(
      name: AppRoutes.recommendation,
      page: () => RecommendationView(),
    ),

    GetPage(
      name: AppRoutes.progress,
      page: () => ProgressView(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => ProgressController());
      }),
    ),

    GetPage(
      name: AppRoutes.profile,
      page: () => ProfileView(),
    ),

    GetPage(
      name: AppRoutes.notification,
      page: () => const NotificationView(),
    ),

    GetPage(
  name: AppRoutes.scanDetail,
  page: () => const ScanDetailView(),
),
  ];
}