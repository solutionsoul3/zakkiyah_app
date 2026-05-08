import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:zakkiyah_app/Routes/routes.dart';
import 'package:zakkiyah_app/controllers/home_apps_controller.dart';
import 'package:zakkiyah_app/controllers/theme_controller.dart';

void main() {
  Get.put(ThemeController(), permanent: true);
  Get.put(HomeAppsController(), permanent: true);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      useInheritedMediaQuery: true, // ✅ rotation fix
      builder: (_, __) {
        final ThemeController themeController = Get.find<ThemeController>();

        return Obx(
              () => GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Zakkiyah Admin',
            initialRoute: AppRoutes.login,
            getPages: AppRoutes.pages,

            // ✅ ONLY added this (no theme change)
            builder: (context, child) {
              return ResponsiveWrapper(child: child!);
            },

            themeMode: themeController.themeMode,

            // 🔒 YOUR ORIGINAL THEME (UNCHANGED)
            theme: ThemeData(
              brightness: Brightness.light,
              scaffoldBackgroundColor: Colors.white,
              colorScheme: const ColorScheme.light(
                primary: Colors.black,
                onPrimary: Colors.white,
                secondary: Colors.black87,
                onSurface: Colors.black,
                surface: Colors.white,
              ),
              textTheme: const TextTheme(
                bodyLarge: TextStyle(color: Colors.black),
                bodyMedium: TextStyle(color: Colors.black),
                bodySmall: TextStyle(color: Colors.black),
                titleLarge: TextStyle(color: Colors.black),
                titleMedium: TextStyle(color: Colors.black),
                titleSmall: TextStyle(color: Colors.black),
              ),
              primaryTextTheme: const TextTheme(
                bodyLarge: TextStyle(color: Colors.black),
                bodyMedium: TextStyle(color: Colors.black),
              ),
              iconTheme: const IconThemeData(color: Colors.black),
              drawerTheme: const DrawerThemeData(backgroundColor: Colors.white),
              cardColor: Colors.white,
              appBarTheme: const AppBarTheme(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
              ),
              useMaterial3: true,
            ),

            // 🔒 YOUR ORIGINAL DARK THEME (UNCHANGED)
            darkTheme: ThemeData(
              brightness: Brightness.dark,
              scaffoldBackgroundColor: Colors.black,
              colorScheme: const ColorScheme.dark(
                primary: Colors.white,
                onPrimary: Colors.black,
                secondary: Colors.white70,
                surface: Color(0xFF121212),
                onSurface: Colors.white,
              ),
              textTheme: const TextTheme(
                bodyLarge: TextStyle(color: Colors.white),
                bodyMedium: TextStyle(color: Colors.white),
                bodySmall: TextStyle(color: Colors.white),
                titleLarge: TextStyle(color: Colors.white),
                titleMedium: TextStyle(color: Colors.white),
                titleSmall: TextStyle(color: Colors.white),
              ),
              primaryTextTheme: const TextTheme(
                bodyLarge: TextStyle(color: Colors.white),
                bodyMedium: TextStyle(color: Colors.white),
              ),
              iconTheme: const IconThemeData(color: Colors.white),
              drawerTheme: const DrawerThemeData(
                backgroundColor: Color(0xFF121212),
              ),
              cardColor: const Color(0xFF1B1B1B),
              appBarTheme: const AppBarTheme(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
              ),
              useMaterial3: true,
            ),
          ),
        );
      },
    );
  }
}

////////////////////////////////////////////////////////////
/// ✅ RESPONSIVE WRAPPER (handles tablet + rotation)
////////////////////////////////////////////////////////////

class ResponsiveWrapper extends StatelessWidget {
  final Widget child;

  const ResponsiveWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final MediaQueryData media = MediaQuery.of(context);
    final bool isLandscape = media.orientation == Orientation.landscape;
    final bool isTablet = media.size.shortestSide >= 600;

    final double textScale = isLandscape ? (isTablet ? 0.78 : 0.76) : 1.0;
    final double widthScale = isLandscape ? (isTablet ? 0.86 : 0.84) : 1.0;
    final double constrainedWidth = media.size.width * widthScale;

    return MediaQuery(
      data: media.copyWith(textScaler: TextScaler.linear(textScale)),
      child: Center(
        child: SizedBox(
          width: constrainedWidth,
          height: media.size.height,
          child: child,
        ),
      ),
    );
  }
}