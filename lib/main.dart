import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'theme/app_theme.dart';
import 'routes/app_pages.dart';
import 'routes/app_routes.dart';
import 'controllers/dashboard_controller.dart';
import 'controllers/auth_controller.dart'; 
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('id', null);

  // 🔥 TAMBAH INI
  await Supabase.initialize(
    url: 'https://fsknwbbganyyxpnnrntt.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImZza253YmJnYW55eXhwbm5ybnR0Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3Nzc3ODI2ODMsImV4cCI6MjA5MzM1ODY4M30.KSnDL4uSLIREh9eAeOlClsnb-vPNAGcbbk6fhqIC6gw',
  );

  Get.put(DashboardController(), permanent: true);
  Get.put(AuthController(), permanent: true);

  SystemChrome.setSystemUIOverlayStyle(
  const SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.black,
    systemNavigationBarIconBrightness: Brightness.light,
  ),
);

  runApp(const ScalpAIApp());
}

class ScalpAIApp extends StatelessWidget {
  const ScalpAIApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'ScalpAI',
      theme: AppTheme.dark,
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.splash,
      getPages: AppPages.routes,
    );
  }
}