import 'package:get/get.dart';

import '../core/bindings/auth_binding.dart';
import '../core/bindings/dashboard_binding.dart';
import '../core/bindings/progress_binding.dart';
import '../core/bindings/result_binding.dart';
import '../core/bindings/scan_binding.dart';

import '../routes/app_routes.dart';

import '../views/auth/login_view.dart';
import '../views/auth/register_view.dart';

import '../views/dashboard/dashboard_view.dart';

import '../views/notification/notification_view.dart';

import '../views/profile/profile_view.dart';

import '../views/progress/progress_view.dart';
import '../views/progress/scan_detail_view.dart';

import '../views/recommendation/recommendation_view.dart';

import '../views/result/result_view.dart';

import '../views/scan/loading_view.dart';
import '../views/scan/question_view.dart';
import '../views/scan/scan_view.dart';

import '../views/splash/splash_view.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashView(),
    ),

    GetPage(
      name: AppRoutes.login,
      page: () => LoginView(),
      binding: AuthBinding(),
    ),

    GetPage(
      name: AppRoutes.register,
      page: () => RegisterView(),
      binding: AuthBinding(),
    ),

    GetPage(
      name: AppRoutes.dashboard,
      page: () => DashboardView(),
      binding: DashboardBinding(),
    ),

    GetPage(
      name: AppRoutes.scan,
      page: () => ScanView(),
      binding: ScanBinding(),
    ),

    GetPage(
      name: AppRoutes.loading,
      page: () => LoadingView(),
    ),

    GetPage(
      name: AppRoutes.question,
      page: () => const QuestionView(),
    ),

    GetPage(
      name: AppRoutes.result,
      page: () => const ResultView(),
      binding: ResultBinding(),
    ),

    GetPage(
      name: AppRoutes.recommendation,
      page: () => RecommendationView(),
    ),

    GetPage(
      name: AppRoutes.progress,
      page: () => ProgressView(),
      binding: ProgressBinding(),
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