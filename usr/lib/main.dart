import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/service_detail_screen.dart';
import 'theme/app_theme.dart';
import 'utils/constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      initialRoute: '/',
      onGenerateRoute: (settings) {
        if (settings.name == '/') {
          return MaterialPageRoute(builder: (context) => const HomeScreen());
        }
        
        // Handle service routes dynamically
        final service = AppConstants.services.firstWhere(
          (s) => s.route == settings.name,
          orElse: () => AppConstants.services.first, // Fallback
        );

        if (service.route == settings.name) {
          return MaterialPageRoute(
            builder: (context) => GenericServiceScreen(service: service),
          );
        }

        return null;
      },
    );
  }
}
