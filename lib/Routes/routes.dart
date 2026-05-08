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
  static const String settingsApps = '/settings-apps';
  static const String settingsLayout = '/settings-layout';
  static const String settingsCardBehavior = '/settings-card-behavior';
  static const String settingsSound = '/settings-sound';
  static const String settingsLanguageVoice = '/settings-language-voice';
  static const String settingsAccessories = '/settings-accessories';
  static const String settingsDevice = '/settings-device';
  static const String settingsAccountPrivacy = '/settings-account-privacy';
  static const String settingsHelp = '/settings-help';
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
    GetPage(name: settingsApps, page: () => const AppsSettingsScreen()),
    GetPage(name: settingsLayout, page: () => const LayoutSettingsScreen()),
    GetPage(name: settingsCardBehavior, page: () => const CardBehaviorSettingsScreen()),
    GetPage(name: settingsSound, page: () => const SoundSettingsScreen()),
    GetPage(name: settingsLanguageVoice, page: () => const LanguageVoiceSettingsScreen()),
    GetPage(name: settingsAccessories, page: () => const AccessoriesSettingsScreen()),
    GetPage(name: settingsDevice, page: () => const DeviceSettingsScreen()),
    GetPage(name: settingsAccountPrivacy, page: () => const AccountPrivacySettingsScreen()),
    GetPage(name: settingsHelp, page: () => const HelpSettingsScreen()),
    GetPage(name: editor, page: () => const EditorScreen()),
  ];
}
