import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zakkiyah_app/Routes/routes.dart';

class AppMenuDrawer extends StatelessWidget {
  const AppMenuDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: <Widget>[
            const DrawerHeader(
              child: Center(
                child: Text(
                  'Menu',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
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
              icon: Icons.edit_note_outlined,
              title: 'Editor',
              route: AppRoutes.editor,
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
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: () {
        Navigator.pop(context);
        Get.toNamed(route);
      },
    );
  }
}
