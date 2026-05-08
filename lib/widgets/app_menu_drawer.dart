import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zakkiyah_app/Routes/routes.dart';
import 'package:zakkiyah_app/Views/settings/settings_screen.dart';
import 'package:zakkiyah_app/services/voice_service.dart';

class AppMenuDrawer extends StatelessWidget {
  const AppMenuDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const SizedBox(
              height: 76,
              child: Center(
                child: Text(
                  'Settings Menu',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
              ),
            ),
            _item(
              context,
              icon: Icons.home_outlined,
              title: 'Home',
              route: AppRoutes.home,
            ),
            _item(
              context,
              icon: Icons.desktop_windows_outlined,
              title: 'Display',
              route: AppRoutes.settingsDisplay,
            ),
            _item(
              context,
              icon: Icons.person_outline,
              title: 'Profile',
              route: AppRoutes.settingsProfile,
            ),
            _item(
              context,
              icon: Icons.speed_outlined,
              title: 'Usage Control',
              route: AppRoutes.settingsUsageControl,
            ),
            _item(
              context,
              icon: Icons.apps_outlined,
              title: 'Manage Apps',
              route: AppRoutes.settingsApps,
            ),
            _item(
              context,
              icon: Icons.edit_note_outlined,
              title: 'Editor',
              route: AppRoutes.editor,
            ),
            _settingsItem(
              context,
              icon: Icons.grid_view_outlined,
              title: 'Layout',
              route: AppRoutes.settingsLayout,
            ),
            _settingsItem(
              context,
              icon: Icons.view_carousel_outlined,
              title: 'Card Behavior',
              route: AppRoutes.settingsCardBehavior,
            ),
            _settingsItem(
              context,
              icon: Icons.volume_up_outlined,
              title: 'Sound',
              route: AppRoutes.settingsSound,
            ),
            _settingsItem(
              context,
              icon: Icons.record_voice_over_outlined,
              title: 'Language And Voice',
              route: AppRoutes.settingsLanguageVoice,
            ),
            _settingsItem(
              context,
              icon: Icons.settings_input_component_outlined,
              title: 'Accessories',
              route: AppRoutes.settingsAccessories,
            ),
            _settingsItem(
              context,
              icon: Icons.devices_other_outlined,
              title: 'Device',
              route: AppRoutes.settingsDevice,
            ),
            _settingsItem(
              context,
              icon: Icons.privacy_tip_outlined,
              title: 'Account and Privacy',
              route: AppRoutes.settingsAccountPrivacy,
            ),
            _settingsItem(
              context,
              icon: Icons.help_outline,
              title: 'Help',
              route: AppRoutes.settingsHelp,
            ),
          ],
        ),
      ),
    );
  }

  Widget _item(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String route,
  }) {
    return InkWell(
      onTap: () async {
        final NavigatorState navigator = Navigator.of(context);
        await VoiceService.instance.speak(title);
        if (!navigator.mounted) return;
        navigator.pop();
        Get.toNamed(route);
      },
      child: SizedBox(
        height: 32,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: <Widget>[
              Icon(icon, size: 16),
              const SizedBox(width: 8),
              Expanded(child: Text(title, style: const TextStyle(fontSize: 12))),
            ],
          ),
        ),
      ),
    );
  }

  Widget _settingsItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String route,
  }) {
    return InkWell(
      onTap: () async {
        final NavigatorState navigator = Navigator.of(context);
        await VoiceService.instance.speak(title);
        if (!navigator.mounted) return;
        navigator.pop();
        Get.toNamed(route);
      },
      child: SizedBox(
        height: 32,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: <Widget>[
              Icon(icon, size: 16),
              const SizedBox(width: 8),
              Expanded(child: Text(title, style: const TextStyle(fontSize: 12))),
            ],
          ),
        ),
      ),
    );
  }
}
