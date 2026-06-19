import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zakkiyah_app/Routes/routes.dart';
import 'package:zakkiyah_app/services/voice_service.dart';

class AppMenuDrawer extends StatelessWidget {
  const AppMenuDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final Color background = isDark ? Colors.black : Colors.white;
    final Color textColor = isDark ? Colors.white : Colors.black;
    final Color iconColor = isDark ? Colors.white : Colors.black87;

    return Drawer(
      backgroundColor: background,
      child: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            SizedBox(
              height: 76,
              child: Center(
                child: Text(
                  'Settings Menu',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: textColor,
                  ),
                ),
              ),
            ),
            _homeItem(context, textColor: textColor, iconColor: iconColor),
            _item(
              context,
              icon: Icons.desktop_windows_outlined,
              title: 'Display',
              route: AppRoutes.settingsDisplay,
              textColor: textColor,
              iconColor: iconColor,
            ),
            _item(
              context,
              icon: Icons.person_outline,
              title: 'Profile',
              route: AppRoutes.settingsProfile,
              textColor: textColor,
              iconColor: iconColor,
            ),
            _item(
              context,
              icon: Icons.speed_outlined,
              title: 'Usage Control',
              route: AppRoutes.settingsUsageControl,
              textColor: textColor,
              iconColor: iconColor,
            ),
            _item(
              context,
              icon: Icons.apps_outlined,
              title: 'Manage Apps',
              route: AppRoutes.settingsApps,
              textColor: textColor,
              iconColor: iconColor,
            ),
            _item(
              context,
              icon: Icons.edit_note_outlined,
              title: 'Editor',
              route: AppRoutes.editor,
              textColor: textColor,
              iconColor: iconColor,
            ),
            _settingsItem(
              context,
              icon: Icons.grid_view_outlined,
              title: 'Layout',
              route: AppRoutes.settingsLayout,
              textColor: textColor,
              iconColor: iconColor,
            ),
            _settingsItem(
              context,
              icon: Icons.view_carousel_outlined,
              title: 'Card Behavior',
              route: AppRoutes.settingsCardBehavior,
              textColor: textColor,
              iconColor: iconColor,
            ),
            _settingsItem(
              context,
              icon: Icons.volume_up_outlined,
              title: 'Sound',
              route: AppRoutes.settingsSound,
              textColor: textColor,
              iconColor: iconColor,
            ),
            _settingsItem(
              context,
              icon: Icons.record_voice_over_outlined,
              title: 'Language And Voice',
              route: AppRoutes.settingsLanguageVoice,
              textColor: textColor,
              iconColor: iconColor,
            ),
            _settingsItem(
              context,
              icon: Icons.settings_input_component_outlined,
              title: 'Accessories',
              route: AppRoutes.settingsAccessories,
              textColor: textColor,
              iconColor: iconColor,
            ),
            _settingsItem(
              context,
              icon: Icons.devices_other_outlined,
              title: 'Device',
              route: AppRoutes.settingsDevice,
              textColor: textColor,
              iconColor: iconColor,
            ),
            _settingsItem(
              context,
              icon: Icons.privacy_tip_outlined,
              title: 'Account and Privacy',
              route: AppRoutes.settingsAccountPrivacy,
              textColor: textColor,
              iconColor: iconColor,
            ),
            _settingsItem(
              context,
              icon: Icons.help_outline,
              title: 'Help',
              route: AppRoutes.settingsHelp,
              textColor: textColor,
              iconColor: iconColor,
            ),
          ],
        ),
      ),
    );
  }

  Widget _homeItem(
    BuildContext context, {
    required Color textColor,
    required Color iconColor,
  }) {
    return InkWell(
      onTap: () async {
        final NavigatorState navigator = Navigator.of(context);
        await VoiceService.instance.speak('Home');
        if (!navigator.mounted) return;
        navigator.pop();
        Get.offAllNamed(AppRoutes.home);
      },
      child: SizedBox(
        height: 40,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: <Widget>[
              Icon(Icons.home_outlined, size: 18, color: iconColor),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Home',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: textColor),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _item(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String route,
    required Color textColor,
    required Color iconColor,
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
              Icon(icon, size: 16, color: iconColor),
              const SizedBox(width: 8),
              Expanded(child: Text(title, style: TextStyle(fontSize: 12, color: textColor))),
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
    required Color textColor,
    required Color iconColor,
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
              Icon(icon, size: 16, color: iconColor),
              const SizedBox(width: 8),
              Expanded(child: Text(title, style: TextStyle(fontSize: 12, color: textColor))),
            ],
          ),
        ),
      ),
    );
  }
}
