import 'package:get/get.dart';
import 'package:zakkiyah_app/Views/auth/onboarding_one.dart';
import 'package:zakkiyah_app/Views/auth/onboarding_three.dart';
import 'package:zakkiyah_app/Views/auth/onboarding_two.dart';
import 'package:zakkiyah_app/Views/auth/signin.dart';
import 'package:zakkiyah_app/Views/auth/verification.dart';
import 'package:zakkiyah_app/Views/editor/editor.dart';
import 'package:zakkiyah_app/Views/home/home_screen.dart';
import 'package:zakkiyah_app/Views/settings/settings_screen.dart';

class AppRoutes {
  static const String verification = '/verification';
  static const String onboard1 = '/onboard1';
  static const String onboard2 = '/onboard2';
  static const String onboard3 = '/onboard3';
  static const String login = '/login';
  static const String home = '/home';
  static const String settingsDisplay = '/settings-display';
  static const String settingsProfile = '/settings-profile';
  static const String settingsUsageControl = '/settings-usage-control';
  static const String editor = '/editor';

  static final List<GetPage> pages = [
    GetPage(name: login, page: () => const SignInScreen()),
    GetPage(name: verification, page: () => const VerificationScreen()),
    GetPage(name: onboard1, page: () => const OnboardingScreenOne()),
    GetPage(name: onboard2, page: () => const OnboardingScreenTwo()),
    GetPage(name: onboard3, page: () => const OnboardingScreenThree()),
    GetPage(name: home, page: () => HomeScreen()),
    GetPage(name: settingsDisplay, page: () => const DisplaySettingsScreen()),
    GetPage(name: settingsProfile, page: () => const ProfileSettingsScreen()),
    GetPage(
      name: settingsUsageControl,
      page: () => const UsageControlSettingsScreen(),
    ),
    GetPage(name: editor, page: () => const EditorScreen()),
  ];
}
