import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:zakkiyah_app/Routes/routes.dart';
import 'package:zakkiyah_app/constants/images/images.dart';
import 'package:zakkiyah_app/controllers/theme_controller.dart';
import 'package:zakkiyah_app/widgets/menu_drawer_button.dart';
import 'package:zakkiyah_app/widgets/responsive_frame.dart';

enum SettingsTab { display, profile, usageControl }

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key, this.initialTab = SettingsTab.display});

  final SettingsTab initialTab;

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final ThemeController _themeController = Get.find<ThemeController>();
  late SettingsTab _selectedTab;
  String _appSize = 'Medium';
  String _appAlignment = 'Left';
  String _theme = 'Light';
  bool _isEditingProfile = false;
  final TextEditingController _usernameController = TextEditingController(
    text: 'Username',
  );
  final TextEditingController _emailController = TextEditingController(
    text: 'zakkiyah@gmail.com',
  );

  @override
  void initState() {
    super.initState();
    _selectedTab = widget.initialTab;
    _theme = _themeController.isDarkMode ? 'Dark' : 'Light';
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final Color pageBg = isDark ? const Color(0xFF121212) : const Color(0xFFF4F4F4);
    return Scaffold(
      endDrawer: _SettingsDrawer(),
      body: SafeArea(
        child: ResponsiveFrame(
          tabletMaxWidth: 1200,
          child: Column(
            children: <Widget>[
              _topBar(),
              _subHeader(),
              Expanded(
                child: Container(
                  color: pageBg,
                  padding: EdgeInsets.all(14.w),
                  child: LayoutBuilder(
                    builder: (_, BoxConstraints constraints) {
                      final bool wide = constraints.maxWidth >= 760;
                      if (!wide) {
                        return SingleChildScrollView(
                          child: Column(
                            children: <Widget>[
                              _leftMenu(),
                              SizedBox(height: 12.h),
                              _content(),
                            ],
                          ),
                        );
                      }
                      return Row(
                        children: <Widget>[
                          SizedBox(width: 200.w, child: _leftMenu()),
                          SizedBox(width: 14.w),
                          Expanded(child: _content()),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _topBar() {
    return Container(
      height: 64.h,
      width: double.infinity,
      color: Colors.black,
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      child: Row(
        children: <Widget>[
          Text(
            _selectedTab == SettingsTab.display
                ? 'Display'
                : _selectedTab == SettingsTab.profile
                    ? 'Profile'
                    : 'Usage Control',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
          const Spacer(),
          const MenuDrawerButton(),
        ],
      ),
    );
  }

  Widget _subHeader() {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      width: double.infinity,
      color: isDark ? const Color(0xFF1B1B1B) : const Color(0xFFECECEC),
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      child: Container(
        width: 135.w,
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: 8.h),
        decoration: BoxDecoration(
          color: const Color(0xFF66D5FD),
          borderRadius: BorderRadius.circular(6.r),
        ),
        child: Text(
          'General Settings',
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _leftMenu() {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          _menuTile('Display', SettingsTab.display, Icons.desktop_windows_outlined),
          _menuTile('Profile', SettingsTab.profile, Icons.person_outline),
          _menuTile('Usage Control', SettingsTab.usageControl, Icons.speed_outlined),
        ],
      ),
    );
  }

  Widget _menuTile(String text, SettingsTab tab, IconData icon) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final bool active = _selectedTab == tab;
    return InkWell(
      onTap: () => setState(() => _selectedTab = tab),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: active
              ? (isDark ? const Color(0xFF5E61D8) : const Color(0xFF8B8DE8))
              : Colors.transparent,
          borderRadius: BorderRadius.circular(6.r),
        ),
        child: Row(
          children: <Widget>[
            Icon(
              icon,
              color: active ? Colors.white : (isDark ? Colors.white70 : Colors.black54),
              size: 18.w,
            ),
            SizedBox(width: 8.w),
            Text(
              text,
              style: TextStyle(
                color: active ? Colors.white : (isDark ? Colors.white : Colors.black87),
                fontSize: 13.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _content() {
    switch (_selectedTab) {
      case SettingsTab.display:
        return _displayContent();
      case SettingsTab.profile:
        return _profileContent();
      case SettingsTab.usageControl:
        return _usageControlContent();
    }
  }

  Widget _displayContent() {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _sectionCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _sectionTitle('App Size'),
                _radioRow(<String>['Small', 'Medium', 'Large'], _appSize, (
                  String value,
                ) {
                  setState(() => _appSize = value);
                }),
                SizedBox(height: 12.h),
                _sectionTitle('App Alignment'),
                _radioRow(<String>['Left', 'Center', 'Right'], _appAlignment, (
                  String value,
                ) {
                  setState(() => _appAlignment = value);
                }),
              ],
            ),
          ),
          SizedBox(height: 10.h),
          _sectionCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _sectionTitle('Layout'),
                SizedBox(height: 8.h),
                Container(
                  height: 80.h,
                  width: 120.w,
                  decoration: BoxDecoration(
                    color: isDark ? const Color(0xFF2A2A2A) : const Color(0xFFE6E6E6),
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  child: Icon(
                    Icons.grid_view,
                    color: isDark ? Colors.white70 : Colors.white54,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10.h),
          _sectionCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _sectionTitle('Theme'),
                SizedBox(height: 8.h),
                Row(
                  children: <Widget>[
                    _themeButton('Light', Icons.wb_sunny_outlined),
                    SizedBox(width: 12.w),
                    _themeButton('Dark', Icons.dark_mode_outlined),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _profileContent() {
    return SingleChildScrollView(
      child: _sectionCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                tooltip: _isEditingProfile ? 'Done editing' : 'Edit profile',
                onPressed: () {
                  setState(() => _isEditingProfile = !_isEditingProfile);
                },
                icon: Icon(
                  _isEditingProfile ? Icons.check_circle : Icons.edit,
                  color: const Color(0xFF66D5FD),
                  size: 22.w,
                ),
              ),
            ),
            Center(
              child: Stack(
                children: <Widget>[
                  CircleAvatar(
                    radius: 48.r,
                    backgroundColor: const Color(0xFFE8EEF8),
                    child: ClipOval(
                      child: Image.asset(
                        AppImages.homeAvatar,
                        fit: BoxFit.cover,
                        width: 96.w,
                        height: 96.w,
                        errorBuilder: (_, __, ___) => Icon(
                          Icons.person,
                          size: 40.w,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: GestureDetector(
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Image edit action clicked'),
                          ),
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.all(6.w),
                        decoration: const BoxDecoration(
                          color: Color(0xFF66D5FD),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.edit,
                          size: 14.w,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 8.h),
            Center(
              child: Text(
                _usernameController.text,
                style: TextStyle(
                  fontSize: 22.sp,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Colors.black87,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(height: 14.h),
            Text(
              'Username',
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 6.h),
            _field(
              controller: _usernameController,
              editable: _isEditingProfile,
            ),
            SizedBox(height: 8.h),
            Text(
              'Email',
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 6.h),
            _field(
              controller: _emailController,
              editable: _isEditingProfile,
            ),
            SizedBox(height: 10.h),
            SizedBox(
              width: 90.w,
              child: FilledButton.icon(
                style: FilledButton.styleFrom(
                  backgroundColor: const Color(0xFF66D5FD),
                  padding: EdgeInsets.symmetric(vertical: 10.h),
                ),
                onPressed: () {
                  setState(() => _isEditingProfile = false);
                },
                icon: const Icon(Icons.check, size: 14),
                label: const Text('Save'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _usageControlContent() {
    return _sectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _sectionTitle('Usage Control'),
          SizedBox(height: 8.h),
          Text(
            'Configure limits, session duration, and guidance preferences.',
            style: TextStyle(
              fontSize: 13.sp,
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : Colors.black87,
            ),
          ),
          SizedBox(height: 14.h),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text('Enable Safe Usage Mode'),
            value: true,
            onChanged: (_) {},
          ),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text('Daily Usage Reminder'),
            value: false,
            onChanged: (_) {},
          ),
        ],
      ),
    );
  }

  Widget _sectionCard({required Widget child}) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: child,
    );
  }

  Widget _sectionTitle(String text) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Text(
      text,
      style: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 18.sp,
        color: isDark ? Colors.white : Colors.black87,
      ),
    );
  }

  Widget _radioRow(
    List<String> values,
    String selected,
    ValueChanged<String> onChanged,
  ) {
    return Wrap(
      spacing: 18.w,
      children: values.map((String value) {
        return InkWell(
          onTap: () => onChanged(value),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Radio<String>(
                value: value,
                groupValue: selected,
                onChanged: (String? v) {
                  if (v != null) onChanged(v);
                },
              ),
              Text(value),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _themeButton(String name, IconData icon) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final bool selected = _theme == name;
    return InkWell(
      onTap: () {
        setState(() => _theme = name);
        if (name == 'Dark') {
          _themeController.setDarkMode();
        } else {
          _themeController.setLightMode();
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: selected
              ? const Color(0xFFFFC247)
              : (isDark ? const Color(0xFF2A2A2A) : const Color(0xFFF2F2F2)),
          borderRadius: BorderRadius.circular(6.r),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(icon, size: 22.w, color: isDark ? Colors.white : Colors.black),
            SizedBox(width: 6.w),
            Text(
              name,
              style: TextStyle(color: isDark ? Colors.white : Colors.black),
            ),
          ],
        ),
      ),
    );
  }

  Widget _field({
    required TextEditingController controller,
    required bool editable,
  }) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF2A2A2A) : const Color(0xFFF6F6F6),
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: TextField(
        controller: controller,
        enabled: editable,
        onChanged: (_) => setState(() {}),
        decoration: InputDecoration(
          isDense: true,
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
          suffixIcon: Icon(
            Icons.edit,
            size: 18.w,
            color: editable
                ? const Color(0xFF66D5FD)
                : (isDark ? Colors.white38 : Colors.black38),
          ),
        ),
        style: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w400,
          color: isDark ? Colors.white : Colors.black,
        ),
      ),
    );
  }
}

class DisplaySettingsScreen extends StatelessWidget {
  const DisplaySettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SettingsScreen(initialTab: SettingsTab.display);
  }
}

class ProfileSettingsScreen extends StatelessWidget {
  const ProfileSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SettingsScreen(initialTab: SettingsTab.profile);
  }
}

class UsageControlSettingsScreen extends StatelessWidget {
  const UsageControlSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SettingsScreen(initialTab: SettingsTab.usageControl);
  }
}

class _SettingsDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: <Widget>[
            const DrawerHeader(
              child: Center(
                child: Text(
                  'Settings Menu',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                ),
              ),
            ),
            _drawerItem(
              context,
              icon: Icons.desktop_windows_outlined,
              title: 'Display',
              route: AppRoutes.settingsDisplay,
            ),
            _drawerItem(
              context,
              icon: Icons.person_outline,
              title: 'Profile',
              route: AppRoutes.settingsProfile,
            ),
            _drawerItem(
              context,
              icon: Icons.speed_outlined,
              title: 'Usage Control',
              route: AppRoutes.settingsUsageControl,
            ),
            _drawerItem(
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

  Widget _drawerItem(
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
