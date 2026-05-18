import 'package:get/get.dart';
import '../routes/app_routes.dart';

class DashboardController extends GetxController {
  final selectedTab = 0.obs;

  /// Peta index → route
  static const _routes = [
    AppRoutes.dashboard,
    AppRoutes.scan,
    AppRoutes.progress,
    AppRoutes.profile,
  ];

  void navigateTo(
    int fromIndex,
    int toIndex,
  ) {
    if (fromIndex == toIndex) {
      return;
    }

    selectedTab.value = toIndex;

    Get.toNamed(
      _routes[toIndex],
    );
  }
}
