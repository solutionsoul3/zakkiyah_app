import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:zakkiyah_app/Routes/routes.dart';
import 'package:zakkiyah_app/Views/Alphabet/alphabet.dart';
import 'package:zakkiyah_app/Views/Colors/colors_screen.dart';
import 'package:zakkiyah_app/Views/ConversationalPhrases/conversational_phrases.dart';
import 'package:zakkiyah_app/Views/DailyActivities/daily_activities.dart';
import 'package:zakkiyah_app/Views/DailyRoutine/daily_routine.dart';
import 'package:zakkiyah_app/Views/Draw/draw.dart';
import 'package:zakkiyah_app/Views/EmergencyResponse/emergency_response.dart';
import 'package:zakkiyah_app/Views/Feelings/feelings.dart';
import 'package:zakkiyah_app/Views/ICUCommunication/icu_communication.dart';
import 'package:zakkiyah_app/Views/Important/important.dart';
import 'package:zakkiyah_app/Views/Learn/learn.dart';
import 'package:zakkiyah_app/Views/Media/media.dart';
import 'package:zakkiyah_app/Views/MentalHealth/mental_health.dart';
import 'package:zakkiyah_app/Views/Numbers/numbers.dart';
import 'package:zakkiyah_app/Views/PainScale/pain_scale.dart';
import 'package:zakkiyah_app/Views/Read/read.dart';
import 'package:zakkiyah_app/Views/Schedule/schedule.dart';
import 'package:zakkiyah_app/Views/Shapes/shape.dart';
import 'package:zakkiyah_app/Views/SignLanguage/sign_language.dart';
import 'package:zakkiyah_app/Views/SimpleCommunication/simple_communication.dart';
import 'package:zakkiyah_app/Views/Talk/talk.dart';
import 'package:zakkiyah_app/Views/Therapy/therapy.dart';
import 'package:zakkiyah_app/Views/Type/type.dart';
import 'package:zakkiyah_app/Views/settings/settings_screen.dart';
import 'package:zakkiyah_app/constants/Colors/colors.dart';
import 'package:zakkiyah_app/constants/images/images.dart';
import 'package:zakkiyah_app/controllers/home_apps_controller.dart';
import 'package:zakkiyah_app/services/voice_service.dart';
import 'package:zakkiyah_app/widgets/app_screen_header.dart';
import 'package:zakkiyah_app/widgets/responsive_frame.dart';
import 'package:zakkiyah_app/widgets/voice_tap.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final PageController _pageController = PageController();
  final HomeAppsController _homeAppsController = Get.find<HomeAppsController>();
  int _currentPage = 0;
  int _getCrossAxisCount(BuildContext context) {
    final MediaQueryData media = MediaQuery.of(context);
    final double width = media.size.width;
    final bool isLandscape = media.orientation == Orientation.landscape;

    if (width >= 1300) return 7;
    if (width >= 1100) return isLandscape ? 6 : 5;
    if (width >= 900) return isLandscape ? 5 : 4;
    if (width >= 700) return 4;
    return 2; // mobile
  }

  double _getChildAspectRatio(BuildContext context) {
    final MediaQueryData media = MediaQuery.of(context);
    final double width = media.size.width;
    final bool isLandscape = media.orientation == Orientation.landscape;

    if (width >= 1300) return isLandscape ? 1.25 : 1.12;
    if (width >= 1100) return isLandscape ? 1.2 : 1.08;
    if (width >= 900) return isLandscape ? 1.12 : 1.0;
    if (width >= 700) return 0.95;
    return 1.15;
  }
  final List<_HomeTileData> _allTiles = <_HomeTileData>[
      _HomeTileData('Talk', AppImages.talk, AppColors.homeTile1),
      _HomeTileData('Schedule', AppImages.schedule, AppColors.homeTile2),
      _HomeTileData('Type', AppImages.type, AppColors.homeTile3),
      _HomeTileData('Media', AppImages.media, AppColors.homeTile4),
      _HomeTileData('Therapy', AppImages.therapy, AppColors.homeTile5),
      _HomeTileData('Draw', AppImages.draw, AppColors.homeTile6),
      _HomeTileData('Learn', AppImages.learn, AppColors.homeTile7),
      _HomeTileData('Read', AppImages.read, AppColors.homeTile8),
      _HomeTileData('Shapes', AppImages.shapes, AppColors.homeTile1),
      _HomeTileData('Daily Routine', AppImages.dailyRoutine, AppColors.homeTile2),
      _HomeTileData('Alphabet', AppImages.alphabet, AppColors.homeTile3),
      _HomeTileData('Numbers', AppImages.numbers, AppColors.homeTile4),
      _HomeTileData('Colors', AppImages.colors, AppColors.homeTile5),
      _HomeTileData('Sign Language', AppImages.signLanguage, AppColors.homeTile6),
      _HomeTileData('Feelings', AppImages.feelings, AppColors.homeTile7),
      _HomeTileData('Important', AppImages.important, AppColors.homeTile8),
      _HomeTileData(
        'Conversational Phrases',
        AppImages.conversationalPhrases,
        AppColors.homeTile1,
      ),
      _HomeTileData('Daily Activities', AppImages.dailyActivities, AppColors.homeTile2),
      _HomeTileData('ICU Communication', AppImages.kidConversation, AppColors.homeTile3),
      _HomeTileData('Emergency Response', AppImages.emergencyResponse, AppColors.homeTile4),
      _HomeTileData(
        'Simple Communication',
        AppImages.simpleCommunication,
        AppColors.homeTile5,
      ),
      _HomeTileData('Mental Health', AppImages.mentalHealth, AppColors.homeTile6),
      _HomeTileData('Pain Scale', AppImages.planSchedule, AppColors.homeTile7),
      _HomeTileData('Important', AppImages.importantt, AppColors.homeTile8),
  ];

  List<List<_HomeTileData>> get _pages {
    final Set<String> enabled = _homeAppsController.enabledLabels;
    final List<_HomeTileData> visible = _allTiles
        .where((tile) => enabled.contains(tile.label))
        .toList();
    if (visible.isEmpty) return <List<_HomeTileData>>[<_HomeTileData>[]];

    const int pageSize = 8;
    final List<List<_HomeTileData>> pages = <List<_HomeTileData>>[];
    for (int i = 0; i < visible.length; i += pageSize) {
      pages.add(
        visible.sublist(i, i + pageSize > visible.length ? visible.length : i + pageSize),
      );
    }
    return pages;
  }

  void _goToPage(int page) {
    _pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: _HomeMenuDrawer(),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: ResponsiveFrame(
          tabletMaxWidth: 1200,
          child: Column(
            children: <Widget>[
              AppScreenHeader(
                topBarHeight: 64,
                topBarPadding: EdgeInsets.symmetric(horizontal: 12.w),
                titleContent: Row(
                  children: <Widget>[
                    Icon(Icons.home, size: 22.w),
                    SizedBox(width: 6.w),
                    Text(
                      'Home',
                      style: TextStyle(fontSize: 24.sp),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Obx(() {
                  final List<List<_HomeTileData>> pages = _pages;
                  if (_currentPage >= pages.length) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      if (!mounted) return;
                      setState(() => _currentPage = pages.length - 1);
                      _pageController.jumpToPage(pages.length - 1);
                    });
                  }

                  return Padding(
                    padding: EdgeInsets.all(10.w),
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: pages.length,
                      onPageChanged: (int index) => setState(() => _currentPage = index),
                      itemBuilder: (_, int pageIndex) {
                        final List<_HomeTileData> pageItems = pages[pageIndex];
                        return GridView.builder(
                          itemCount: pageItems.length,
                          physics: const BouncingScrollPhysics(),
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: _getCrossAxisCount(context),
                            mainAxisSpacing: 15.h,
                            crossAxisSpacing: 15.w,
                            childAspectRatio: _getChildAspectRatio(context),
                          ),
                          itemBuilder: (_, int index) {
                            final _HomeTileData tile = pageItems[index];
                            return _HomeTile(
                              data: tile,
                              announceText: tile.label,
                              onTap: () async {
                                _openTileScreen(tile.label.toLowerCase());
                              },
                            );
                          },
                        );
                      },
                    ),
                  );
                }),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(12.w, 0, 12.w, 8.h),
                child: Row(
                  children: <Widget>[
                    _ArrowButton(
                      icon: Icons.arrow_back_ios_new,
                      announceText: 'Previous page',
                      enabled: _currentPage > 0,
                      onTap: () => _goToPage(_currentPage - 1),
                    ),
                    const Spacer(),
                    Row(
                      children: List<Widget>.generate(_pages.length, (int index) {
                        final bool active = _currentPage == index;
                        return Container(
                          margin: EdgeInsets.symmetric(horizontal: 3.w),
                          width: 14.w,
                          height: 14.h,
                          decoration: BoxDecoration(
                            color: active ? Colors.black : const Color(0xFFD7D7D7),
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                        );
                      }),
                    ),
                    const Spacer(),
                    _ArrowButton(
                      icon: Icons.arrow_forward_ios,
                      announceText: 'Next page',
                      enabled: _currentPage < _pages.length - 1,
                      onTap: () => _goToPage(_currentPage + 1),
                      dark: true,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _openTileScreen(String key) {
    if (key == 'talk') {
      Get.to(() => const TalkScreen());
    } else if (key == 'schedule') {
      Get.to(() => const ScheduleScreen());
    } else if (key == 'type') {
      Get.to(() => const TypeScreen());
    } else if (key == 'media') {
      Get.to(() => const MediaScreen());
    } else if (key == 'therapy') {
      Get.to(() => const TherapyScreen());
    } else if (key == 'draw') {
      Get.to(() => const DrawScreen());
    } else if (key == 'learn') {
      Get.to(() => const LearnScreen());
    } else if (key == 'read') {
      Get.to(() => const ReadScreen());
    } else if (key == 'shapes') {
      Get.to(() => const ShapeScreen());
    } else if (key == 'daily routine') {
      Get.to(() => const DailyRoutineScreen());
    } else if (key == 'alphabet') {
      Get.to(() => const AlphabetScreen());
    } else if (key == 'numbers') {
      Get.to(() => const NumbersScreen());
    } else if (key == 'colors') {
      Get.to(() => const ColorsCategoryScreen());
    } else if (key == 'sign language') {
      Get.to(() => const SignLanguageScreen());
    } else if (key == 'feelings') {
      Get.to(() => const FeelingsScreen());
    } else if (key == 'conversational phrases') {
      Get.to(() => const ConversationalPhrasesScreen());
    } else if (key == 'daily activities') {
      Get.to(() => const DailyActivitiesScreen());
    } else if (key == 'icu communication') {
      Get.to(() => const ICUCommunicationScreen());
    } else if (key == 'emergency response') {
      Get.to(() => const EmergencyResponseScreen());
    } else if (key == 'simple communication') {
      Get.to(() => const SimpleCommunicationScreen());
    } else if (key == 'mental health') {
      Get.to(() => const MentalHealthScreen());
    } else if (key == 'pain scale') {
      Get.to(() => const PainScaleScreen());
    } else if (key == 'important') {
      Get.to(() => const ImportantScreen());
    }
  }
}

class _HomeTile extends StatelessWidget {
  const _HomeTile({
    required this.data,
    required this.announceText,
    this.onTap,
  });
  final _HomeTileData data;
  final String announceText;
  final Future<void> Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final double width = MediaQuery.of(context).size.width;
    final bool isTablet = width >= 700;
    final Color lightTileBackground = Color.lerp(data.labelColor, Colors.white, 0.82)!;
    return VoiceTap(
      announceText: announceText,
      onTap: onTap ?? () async {},
      enabled: onTap != null,
      borderRadius: BorderRadius.circular(8.r),
      child: Container(
        decoration: BoxDecoration(
          color: lightTileBackground,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(8.w),
                child: Image.asset(
                  data.imagePath,
                  width: (isTablet ? 72 : (isLandscape ? 68 : 85)).w,
                  height: (isTablet ? 72 : (isLandscape ? 68 : 85)).h,
                  fit: BoxFit.contain,
                  errorBuilder: (_, __, ___) =>
                      Icon(Icons.image_outlined, size: 24.w, color: Colors.blueGrey),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 4.w),
              decoration: BoxDecoration(
                color: data.labelColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(8.r),
                  bottomRight: Radius.circular(8.r),
                ),
              ),
              child: Text(
                data.label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: (isTablet ? 14 : (isLandscape ? 14 : 18)).sp,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ArrowButton extends StatelessWidget {
  const _ArrowButton({
    required this.icon,
    required this.announceText,
    required this.enabled,
    required this.onTap,
    this.dark = false,
  });
  final IconData icon;
  final String announceText;
  final bool enabled;
  final VoidCallback onTap;
  final bool dark;

  @override
  Widget build(BuildContext context) {
    final bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final Color background = dark ? Colors.black : Colors.grey;
    final Color iconColor = dark ? Colors.white : Colors.black;
    return VoiceTap(
      announceText: announceText,
      onTap: () async => onTap(),
      enabled: enabled,
      borderRadius: BorderRadius.circular(20.r),
      child: Opacity(
        opacity: enabled ? 1 : 0.35,
        child: Container(
          width: (isLandscape ? 34 : 42).w,
          height: (isLandscape ? 34 : 42).w,
          decoration: BoxDecoration(color: background, shape: BoxShape.circle),
          child: Icon(icon, size: (isLandscape ? 12 : 14).w, color: iconColor),
        ),
      ),
    );
  }
}

class _HomeTileData {
  const _HomeTileData(this.label, this.imagePath, this.labelColor);
  final String label;
  final String imagePath;
  final Color labelColor;
}

class _HomeMenuDrawer extends StatelessWidget {
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
              tab: SettingsTab.layout,
            ),
            _settingsItem(
              context,
              icon: Icons.view_carousel_outlined,
              title: 'Card Behavior',
              tab: SettingsTab.cardBehavior,
            ),
            _settingsItem(
              context,
              icon: Icons.volume_up_outlined,
              title: 'Sound',
              tab: SettingsTab.sound,
            ),
            _settingsItem(
              context,
              icon: Icons.record_voice_over_outlined,
              title: 'Language And Voice',
              tab: SettingsTab.languageVoice,
            ),
            _settingsItem(
              context,
              icon: Icons.settings_input_component_outlined,
              title: 'Accessories',
              tab: SettingsTab.accessories,
            ),
            _settingsItem(
              context,
              icon: Icons.devices_other_outlined,
              title: 'Device',
              tab: SettingsTab.device,
            ),
            _settingsItem(
              context,
              icon: Icons.privacy_tip_outlined,
              title: 'Account and Privacy',
              tab: SettingsTab.accountPrivacy,
            ),
            _settingsItem(
              context,
              icon: Icons.help_outline,
              title: 'Help',
              tab: SettingsTab.help,
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
      onTap: () async {
        final NavigatorState navigator = Navigator.of(context);
        await VoiceService.instance.speak(title);
        if (!navigator.mounted) return;
        navigator.pop();
        Get.toNamed(route);
      },
    );
  }

  Widget _settingsItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required SettingsTab tab,
  }) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: () async {
        final NavigatorState navigator = Navigator.of(context);
        await VoiceService.instance.speak(title);
        if (!navigator.mounted) return;
        navigator.pop();
        Get.to(() => SettingsScreen(initialTab: tab, drawerSectionMode: true));
      },
    );
  }
}
