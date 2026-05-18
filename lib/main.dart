import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';

import 'package:intl/date_symbol_data_local.dart';

import 'package:supabase_flutter/supabase_flutter.dart';

import 'controllers/auth_controller.dart';
import 'controllers/dashboard_controller.dart';
import 'controllers/progress_controller.dart';

import 'core/theme/app_theme.dart';

import 'routes/app_pages.dart';
import 'routes/app_routes.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized();

  await _initializeApp();

  runApp(
    const ScalpAIApp(),
  );
}

// ✅ INITIALIZE APP
Future<void> _initializeApp()
    async {
  await initializeDateFormatting(
    'id',
    null,
  );

  await Supabase.initialize(
    url:
        'https://fsknwbbganyyxpnnrntt.supabase.co',

    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImZza253YmJnYW55eXhwbm5ybnR0Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3Nzc3ODI2ODMsImV4cCI6MjA5MzM1ODY4M30.KSnDL4uSLIREh9eAeOlClsnb-vPNAGcbbk6fhqIC6gw',
  );

    Get.put(
    DashboardController(),
    permanent: true,
  );

  Get.put(
    AuthController(),
    permanent: true,
  );

  Get.put(
    ProgressController(),
    permanent: true,
  );

  SystemChrome
      .setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      systemNavigationBarColor:
          Colors.black,

      systemNavigationBarIconBrightness:
          Brightness.light,
    ),
  );
}

class ScalpAIApp
    extends StatelessWidget {
  const ScalpAIApp({
    super.key,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    return GetMaterialApp(
      title: 'ScalpAI',

      debugShowCheckedModeBanner:
          false,

      theme: AppTheme.dark,

      initialRoute:
          AppRoutes.splash,

      getPages:
          AppPages.routes,
    );
  }
}