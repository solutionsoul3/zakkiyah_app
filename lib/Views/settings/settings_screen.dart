import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:zakkiyah_app/Routes/routes.dart';
import 'package:zakkiyah_app/constants/images/images.dart';
import 'package:zakkiyah_app/controllers/home_apps_controller.dart';
import 'package:zakkiyah_app/controllers/theme_controller.dart';
import 'package:zakkiyah_app/widgets/menu_drawer_button.dart';
import 'package:zakkiyah_app/widgets/responsive_frame.dart';

enum SettingsTab {
  display,
  profile,
  usageControl,
  apps,
  layout,
  cardBehavior,
  sound,
  languageVoice,
  accessories,
  device,
  accountPrivacy,
  help,
}

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({
    super.key,
    this.initialTab = SettingsTab.display,
    this.drawerSectionMode = false,
  });

  final SettingsTab initialTab;
  final bool drawerSectionMode;

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final ThemeController _themeController = Get.find<ThemeController>();
  final HomeAppsController _homeAppsController = Get.find<HomeAppsController>();
  late SettingsTab _selectedTab;
  String _appSize = 'Medium';
  String _appAlignment = 'Left';
  String _theme = 'Light';
  String _gridAlignment = 'Center';
  String _buttonBarAlignment = 'Left';
  String _spokenWordColor = 'Yellow';
  String _language = 'English';
  String _voiceProfile = 'Justin - Child - English (US)';
  bool _playSoundFolders = true;
  bool _playSoundCards = true;
  bool _projectionFolders = false;
  bool _projectionCards = false;
  bool _highlightSpoken = false;
  bool _offlineVoicesOnly = false;
  bool _showScrollbarWhenScrolling = true;
  bool _enableSwipeNavigation = true;
  bool _shareUsageData = true;
  double _tapSound = 0.12;
  double _messageWindowMode = 0.95;
  double _voiceSpeed = 0.90;
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
              if (!widget.drawerSectionMode) _subHeader(),
              Expanded(
                child: Container(
                  color: pageBg,
                  padding: EdgeInsets.all(14.w),
                  child: widget.drawerSectionMode
                      ? SingleChildScrollView(child: _content())
                      : LayoutBuilder(
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
            _tabTitle(_selectedTab),
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
          _menuTile('Manage Apps', SettingsTab.apps, Icons.apps_outlined),
          _menuTile('Layout', SettingsTab.layout, Icons.grid_view_outlined),
          _menuTile('Card Behavior', SettingsTab.cardBehavior, Icons.view_carousel_outlined),
          _menuTile('Sound', SettingsTab.sound, Icons.volume_up_outlined),
          _menuTile('Language & Voice', SettingsTab.languageVoice, Icons.record_voice_over_outlined),
          _menuTile('Accessories', SettingsTab.accessories, Icons.settings_input_component_outlined),
          _menuTile('Device', SettingsTab.device, Icons.devices_other_outlined),
          _menuTile('Account & Privacy', SettingsTab.accountPrivacy, Icons.privacy_tip_outlined),
          _menuTile('Help', SettingsTab.help, Icons.help_outline),
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
      case SettingsTab.apps:
        return _appsContent();
      case SettingsTab.layout:
        return _layoutContent();
      case SettingsTab.cardBehavior:
        return _cardBehaviorContent();
      case SettingsTab.sound:
        return _soundContent();
      case SettingsTab.languageVoice:
        return _languageVoiceContent();
      case SettingsTab.accessories:
        return _accessoriesContent();
      case SettingsTab.device:
        return _deviceContent();
      case SettingsTab.accountPrivacy:
        return _accountPrivacyContent();
      case SettingsTab.help:
        return _helpContent();
    }
  }

  String _tabTitle(SettingsTab tab) {
    switch (tab) {
      case SettingsTab.display:
        return 'Display';
      case SettingsTab.profile:
        return 'Profile';
      case SettingsTab.usageControl:
        return 'Usage Control';
      case SettingsTab.apps:
        return 'Manage Apps';
      case SettingsTab.layout:
        return 'Layout';
      case SettingsTab.cardBehavior:
        return 'Card Behavior';
      case SettingsTab.sound:
        return 'Sound';
      case SettingsTab.languageVoice:
        return 'Language and Voices';
      case SettingsTab.accessories:
        return 'Accessories';
      case SettingsTab.device:
        return 'Device';
      case SettingsTab.accountPrivacy:
        return 'Account and Privacy';
      case SettingsTab.help:
        return 'Help';
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

  Widget _appsContent() {
    return _sectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _sectionTitle('Manage Apps'),
          SizedBox(height: 8.h),
          Text(
            'Lock/Unlock apps shown on Home, then press Apply.',
            style: TextStyle(
              fontSize: 13.sp,
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : Colors.black87,
            ),
          ),
          SizedBox(height: 10.h),
          Obx(
            () => Column(
              children: _homeAppsController.availableLabels.map((String label) {
                return SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(label),
                  subtitle: Text(
                    _homeAppsController.isEnabled(label) ? 'Unlocked' : 'Locked',
                  ),
                  value: _homeAppsController.isEnabled(label),
                  onChanged: (bool value) {
                    _homeAppsController.setEnabled(label, value);
                  },
                );
              }).toList(),
            ),
          ),
          SizedBox(height: 8.h),
          Align(
            alignment: Alignment.centerRight,
            child: FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: const Color(0xFF66D5FD),
                foregroundColor: Colors.black,
              ),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Manage Apps changes applied')),
                );
              },
              child: const Text('Apply'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _layoutContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _sectionTitle('Layout'),
        SizedBox(height: 10.h),
        _bluePanel(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Grid Preview', style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500)),
                    SizedBox(height: 8.h),
                    Container(
                      height: 120.h,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF0D100),
                        border: Border.all(color: Colors.black26),
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                      child: GridView.builder(
                        padding: EdgeInsets.all(10.w),
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: 6,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                        ),
                        itemBuilder: (_, __) => Container(color: const Color(0xFF66788A)),
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Text('Card Preview', style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500)),
                    SizedBox(height: 8.h),
                    Container(
                      height: 130.h,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6.r),
                        border: Border.all(color: const Color(0xFFD5DDE5)),
                      ),
                      child: Column(
                        children: <Widget>[
                          Expanded(
                            child: Image.asset(
                              AppImages.album,
                              width: double.infinity,
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) => const SizedBox.shrink(),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(6.w),
                            child: const Text('I would like to go for ...'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _radioRow(<String>['Left', 'Center', 'Right'], _gridAlignment, (String value) {
                      setState(() => _gridAlignment = value);
                    }),
                    SizedBox(height: 10.h),
                    Text('Message Window Mode', style: TextStyle(fontSize: 13.sp)),
                    Slider(value: _messageWindowMode, onChanged: (double v) => setState(() => _messageWindowMode = v)),
                    SizedBox(height: 8.h),
                    Text('Button Bar Alignment', style: TextStyle(fontSize: 13.sp)),
                    _radioRow(<String>['Left', 'Right', 'Top', 'Bottom'], _buttonBarAlignment, (String value) {
                      setState(() => _buttonBarAlignment = value);
                    }),
                    SizedBox(height: 8.h),
                    Text('Grid Size', style: TextStyle(fontSize: 13.sp)),
                    Row(
                      children: <Widget>[
                        OutlinedButton(onPressed: () {}, child: const Text('- Less')),
                        SizedBox(width: 8.w),
                        Container(
                          width: 34.w,
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(vertical: 7.h),
                          decoration: BoxDecoration(border: Border.all(color: const Color(0xFFD1D8E0))),
                          child: const Text('2'),
                        ),
                        SizedBox(width: 8.w),
                        OutlinedButton(onPressed: () {}, child: const Text('+ More')),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _cardBehaviorContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _sectionTitle('Card Behavior'),
        SizedBox(height: 10.h),
        _bluePanel(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Play Sound - Folders'),
                value: _playSoundFolders,
                onChanged: (bool v) => setState(() => _playSoundFolders = v),
              ),
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Play Sound - Cards'),
                value: _playSoundCards,
                onChanged: (bool v) => setState(() => _playSoundCards = v),
              ),
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Projection - Folders'),
                value: _projectionFolders,
                onChanged: (bool v) => setState(() => _projectionFolders = v),
              ),
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Projection - Cards'),
                value: _projectionCards,
                onChanged: (bool v) => setState(() => _projectionCards = v),
              ),
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Highlight Spoken Words'),
                value: _highlightSpoken,
                onChanged: (bool v) => setState(() => _highlightSpoken = v),
              ),
              _radioRow(<String>['Yellow', 'Orange', 'Blue'], _spokenWordColor, (String value) {
                setState(() => _spokenWordColor = value);
              }),
            ],
          ),
        ),
      ],
    );
  }

  Widget _soundContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _sectionTitle('Sound'),
        SizedBox(height: 10.h),
        _bluePanel(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text('Volume'),
              Slider(value: 0.80, onChanged: (_) {}),
              SizedBox(height: 8.h),
              const Text('Tap Sound'),
              Slider(value: _tapSound, onChanged: (double v) => setState(() => _tapSound = v)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _languageVoiceContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _sectionTitle('Language and Voices'),
        SizedBox(height: 10.h),
        _bluePanel(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text('Default Language'),
              _radioRow(<String>['English', 'Spanish'], _language, (String value) {
                setState(() => _language = value);
              }),
              SizedBox(height: 8.h),
              const Text('Voices'),
              DropdownButtonFormField<String>(
                value: _voiceProfile,
                items: const <String>[
                  'Justin - Child - English (US)',
                  'Salli - Adult - English (US)',
                  'Miguel - Adult - Spanish',
                ].map((String v) => DropdownMenuItem<String>(value: v, child: Text(v))).toList(),
                onChanged: (String? v) {
                  if (v != null) setState(() => _voiceProfile = v);
                },
              ),
              SizedBox(height: 8.h),
              const Text('Set Speed'),
              Slider(value: _voiceSpeed, onChanged: (double v) => setState(() => _voiceSpeed = v)),
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Use Offline Voices Only'),
                value: _offlineVoicesOnly,
                onChanged: (bool v) => setState(() => _offlineVoicesOnly = v),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _accessoriesContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _sectionTitle('Accessories'),
        SizedBox(height: 10.h),
        _bluePanel(
          child: Column(
            children: <Widget>[
              _accessoryRow('Keyboard', 'Find available bluetooth keyboards'),
              _accessoryRow('Mouse and Pointer', 'Find available bluetooth mouse'),
              _accessoryRow('Speakers', 'Find available bluetooth speakers'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _deviceContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _sectionTitle('About'),
        SizedBox(height: 10.h),
        _bluePanel(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _infoRow('Software Version', 'Android OS 16 / API-36'),
              _infoRow('Hardware ID', 'R9TX40JKYTE'),
              _infoRow('Serial Number', '6874DTB'),
              _infoRow('Unique Device Identifier (UDI)', 'Not set'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _accountPrivacyContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _sectionTitle('Account and Privacy'),
        SizedBox(height: 10.h),
        _bluePanel(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text('Account'),
              SizedBox(height: 4.h),
              const Text('logged in as: qmoree43a(@lgaccount.com)'),
              SizedBox(height: 8.h),
              FilledButton(onPressed: () {}, child: const Text('Log out')),
              SizedBox(height: 10.h),
              const Text('Privacy'),
              const Text(
                'You are currently opted in to allow us to collect your usage network and location data. This helps improve the application and services.',
              ),
              _radioRow(<String>['Yes', 'No'], _shareUsageData ? 'Yes' : 'No', (String value) {
                setState(() => _shareUsageData = value == 'Yes');
              }),
            ],
          ),
        ),
      ],
    );
  }

  Widget _helpContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _sectionTitle('Help'),
        SizedBox(height: 10.h),
        _bluePanel(
          child: Column(
            children: <Widget>[
              _helpRow('Help Articles', 'Device Training & Support Articles and Videos', 'View Help Articles'),
              _helpRow('Contact Us', '(888)-274-2742\n8:30 AM - 7:00 PM, ET', 'Schedule A Session'),
              _helpRow('Remote Support', 'Grant us temporary access to the product support team.', 'Grant Access'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _infoRow(String title, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        children: <Widget>[
          Expanded(flex: 2, child: Text(title)),
          Expanded(flex: 3, child: Text(value)),
        ],
      ),
    );
  }

  Widget _bluePanel({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: const Color(0xFFEAF4FD),
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: const Color(0xFFD7E4F0)),
      ),
      child: child,
    );
  }

  Widget _accessoryRow(String title, String subtitle) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(title, style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500)),
                Text(subtitle, style: TextStyle(fontSize: 12.sp)),
              ],
            ),
          ),
          FilledButton(onPressed: () {}, child: const Text('View available devices')),
        ],
      ),
    );
  }

  Widget _helpRow(String title, String subtitle, String buttonText) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(title, style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500)),
                Text(subtitle, style: TextStyle(fontSize: 12.sp)),
              ],
            ),
          ),
          FilledButton(onPressed: () {}, child: Text(buttonText)),
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
    return const SettingsScreen(
      initialTab: SettingsTab.display,
      drawerSectionMode: true,
    );
  }
}

class ProfileSettingsScreen extends StatelessWidget {
  const ProfileSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SettingsScreen(
      initialTab: SettingsTab.profile,
      drawerSectionMode: true,
    );
  }
}

class UsageControlSettingsScreen extends StatelessWidget {
  const UsageControlSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SettingsScreen(
      initialTab: SettingsTab.usageControl,
      drawerSectionMode: true,
    );
  }
}

class AppsSettingsScreen extends StatelessWidget {
  const AppsSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SettingsScreen(
      initialTab: SettingsTab.apps,
      drawerSectionMode: true,
    );
  }
}

class LayoutSettingsScreen extends StatelessWidget {
  const LayoutSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SettingsScreen(
      initialTab: SettingsTab.layout,
      drawerSectionMode: true,
    );
  }
}

class CardBehaviorSettingsScreen extends StatelessWidget {
  const CardBehaviorSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SettingsScreen(
      initialTab: SettingsTab.cardBehavior,
      drawerSectionMode: true,
    );
  }
}

class SoundSettingsScreen extends StatelessWidget {
  const SoundSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SettingsScreen(
      initialTab: SettingsTab.sound,
      drawerSectionMode: true,
    );
  }
}

class LanguageVoiceSettingsScreen extends StatelessWidget {
  const LanguageVoiceSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SettingsScreen(
      initialTab: SettingsTab.languageVoice,
      drawerSectionMode: true,
    );
  }
}

class AccessoriesSettingsScreen extends StatelessWidget {
  const AccessoriesSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SettingsScreen(
      initialTab: SettingsTab.accessories,
      drawerSectionMode: true,
    );
  }
}

class DeviceSettingsScreen extends StatelessWidget {
  const DeviceSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SettingsScreen(
      initialTab: SettingsTab.device,
      drawerSectionMode: true,
    );
  }
}

class AccountPrivacySettingsScreen extends StatelessWidget {
  const AccountPrivacySettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SettingsScreen(
      initialTab: SettingsTab.accountPrivacy,
      drawerSectionMode: true,
    );
  }
}

class HelpSettingsScreen extends StatelessWidget {
  const HelpSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SettingsScreen(
      initialTab: SettingsTab.help,
      drawerSectionMode: true,
    );
  }
}

class _SettingsDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Scrollbar(
          thumbVisibility: true,
          child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            SizedBox(
              height: 64,
              child: const Center(
                child: Text(
                  'Settings Menu',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
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
              icon: Icons.apps_outlined,
              title: 'Manage Apps',
              route: AppRoutes.settingsApps,
            ),
            _drawerItem(
              context,
              icon: Icons.edit_note_outlined,
              title: 'Editor',
              route: AppRoutes.editor,
            ),
            _drawerSettingsItem(
              context,
              icon: Icons.grid_view_outlined,
              title: 'Layout',
              route: AppRoutes.settingsLayout,
            ),
            _drawerSettingsItem(
              context,
              icon: Icons.view_carousel_outlined,
              title: 'Card Behavior',
              route: AppRoutes.settingsCardBehavior,
            ),
            _drawerSettingsItem(
              context,
              icon: Icons.volume_up_outlined,
              title: 'Sound',
              route: AppRoutes.settingsSound,
            ),
            _drawerSettingsItem(
              context,
              icon: Icons.record_voice_over_outlined,
              title: 'Language And Voice',
              route: AppRoutes.settingsLanguageVoice,
            ),
            _drawerSettingsItem(
              context,
              icon: Icons.settings_input_component_outlined,
              title: 'Accessories',
              route: AppRoutes.settingsAccessories,
            ),
            _drawerSettingsItem(
              context,
              icon: Icons.devices_other_outlined,
              title: 'Device',
              route: AppRoutes.settingsDevice,
            ),
            _drawerSettingsItem(
              context,
              icon: Icons.privacy_tip_outlined,
              title: 'Account and Privacy',
              route: AppRoutes.settingsAccountPrivacy,
            ),
            _drawerSettingsItem(
              context,
              icon: Icons.help_outline,
              title: 'Help',
              route: AppRoutes.settingsHelp,
            ),
          ],
          ),
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
    return InkWell(
      onTap: () {
        Navigator.pop(context);
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

  Widget _drawerSettingsItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String route,
  }) {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
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
