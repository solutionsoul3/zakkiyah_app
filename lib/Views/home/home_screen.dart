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
  static const String _greetingMessage = 'Good morning Zakkiyah';
  static bool _hasSpokenGreetingThisSession = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || _hasSpokenGreetingThisSession) return;
      _hasSpokenGreetingThisSession = true;
      VoiceService.instance.speak(_greetingMessage);
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  double _getChildAspectRatio({
    required BuildContext context,
    required double maxWidth,
    required double maxHeight,
    required int crossAxisCount,
    required int itemCount,
  }) {
    final double spacing = responsiveTileSpacing(context);
    return gridChildAspectRatioForFit(
      maxWidth: maxWidth,
      maxHeight: maxHeight,
      crossAxisCount: crossAxisCount,
      itemCount: itemCount,
      mainAxisSpacing: spacing,
      crossAxisSpacing: spacing,
    );
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
                topBarPadding: EdgeInsets.symmetric(
                  horizontal: isTabletLayout(context) ? 16.0 : 12.w,
                ),
                greetingText: _greetingMessage,
                titleContent: const AppHeaderTitle(
                  showBackButton: false,
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

                  return LayoutBuilder(
                    builder: (BuildContext context, BoxConstraints outerConstraints) {
                      final bool isTablet = isTabletLayout(context);
                      final bool isLandscape = isLandscapeLayout(context);
                      
                      // Padding values
                      final double horizontalPadding = isTablet 
                          ? (isLandscape ? 16.0 : 14.0)
                          : 10.w;
                      final double verticalPadding = isTablet
                          ? (isLandscape ? 12.0 : 14.0)
                          : 10.h;
                      
                      // Calculate available space after padding
                      final double availableWidth = outerConstraints.maxWidth - (horizontalPadding * 2);
                      final double availableHeight = outerConstraints.maxHeight - (verticalPadding * 2);
                      
                      const int crossAxisCount = kTileCrossAxisCount; // 2 columns
                      const int targetRows = 4; // 4 rows for 8 tiles
                      final double spacing = responsiveTileSpacing(context);
                      
                      // Calculate dimensions for exactly 4 rows
                      final double totalVerticalSpacing = (targetRows - 1) * spacing;
                      final double totalHorizontalSpacing = (crossAxisCount - 1) * spacing;
                      
                      final double cellHeight = (availableHeight - totalVerticalSpacing) / targetRows;
                      final double cellWidth = (availableWidth - totalHorizontalSpacing) / crossAxisCount;
                      
                      // Calculate aspect ratio WITHOUT clamping - let it be what it needs to be
                      final double aspectRatio = cellWidth / cellHeight;
                      
                      return Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: horizontalPadding,
                          vertical: verticalPadding,
                        ),
                        child: PageView.builder(
                          controller: _pageController,
                          itemCount: pages.length,
                          onPageChanged: (int index) => setState(() => _currentPage = index),
                          itemBuilder: (_, int pageIndex) {
                            final List<_HomeTileData> pageItems = pages[pageIndex];
                            
                            return GridView.builder(
                              itemCount: pageItems.length,
                              physics: const NeverScrollableScrollPhysics(),
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: crossAxisCount,
                                mainAxisSpacing: spacing,
                                crossAxisSpacing: spacing,
                                childAspectRatio: aspectRatio,
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
                    },
                  );
                }),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(
                  isTabletLayout(context) ? 14.0 : 12.w,
                  0,
                  isTabletLayout(context) ? 14.0 : 12.w,
                  isTabletLayout(context) ? 10.0 : 8.h,
                ),
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
                        final bool isTablet =
                            MediaQuery.sizeOf(context).shortestSide >= 600;
                        final bool isLandscape =
                            MediaQuery.sizeOf(context).width > MediaQuery.sizeOf(context).height;
                        final double dotSize = isTablet
                            ? (isLandscape ? 10.0 : 11.0)
                            : 10.0;
                        return Container(
                          margin: EdgeInsets.symmetric(
                            horizontal: isTablet ? 4.0 : 3.w,
                          ),
                          width: dotSize,
                          height: dotSize,
                          decoration: BoxDecoration(
                            color: active ? Colors.black : const Color(0xFFD7D7D7),
                            borderRadius: BorderRadius.circular(dotSize),
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
    final Color lightTileBackground = Color.lerp(data.labelColor, Colors.white, 0.82)!;

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (!constraints.maxHeight.isFinite || constraints.maxHeight <= 0) {
          return const SizedBox.shrink();
        }

        final double tileShort = constraints.maxHeight < constraints.maxWidth
            ? constraints.maxHeight
            : constraints.maxWidth;
        final bool isTablet = isTabletLayout(context);
        final bool isLandscape = isLandscapeLayout(context);
        final double imagePadding = (tileShort * 0.06).clamp(5.0, 12.0);
        final double labelFontSize = (tileShort * 0.09).clamp(12.0, isTablet ? 16.0 : 15.0);
        final int labelMaxLines = data.label.length > 14 ? 2 : 1;

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
                  flex: isLandscape && isTablet ? 7 : 6,
                  child: Padding(
                    padding: EdgeInsets.all(imagePadding),
                    child: Image.asset(
                      data.imagePath,
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.contain,
                      errorBuilder: (_, __, ___) => Icon(
                        Icons.image_outlined,
                        size: (tileShort * 0.28).clamp(22.0, 38.0),
                        color: Colors.blueGrey,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: isLandscape && isTablet ? 3 : 2,
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                      horizontal: isTablet ? 6.0 : 4.0,
                      vertical: isLandscape ? (isTablet ? 3.0 : 2.0) : 4.0,
                    ),
                    decoration: BoxDecoration(
                      color: data.labelColor,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(8.r),
                        bottomRight: Radius.circular(8.r),
                      ),
                    ),
                    alignment: Alignment.center,
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        data.label,
                        maxLines: labelMaxLines,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: labelFontSize,
                          fontWeight: FontWeight.w500,
                          height: 1.1,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
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
    final Size screenSize = MediaQuery.sizeOf(context);
    final bool isLandscape = screenSize.width > screenSize.height;
    final bool isTablet = screenSize.shortestSide >= 600;
    final Color background = dark ? Colors.black : Colors.grey;
    final Color iconColor = dark ? Colors.white : Colors.black;

    final double buttonSize = isTablet
        ? (isLandscape ? 38.0 : 40.0)
        : (isLandscape ? 36.0 : 38.0);
    final double iconSize = buttonSize * 0.42;

    return VoiceTap(
      announceText: announceText,
      onTap: () async => onTap(),
      enabled: enabled,
      borderRadius: BorderRadius.circular(20.r),
      child: Opacity(
        opacity: enabled ? 1 : 0.35,
        child: Container(
          width: buttonSize,
          height: buttonSize,
          decoration: BoxDecoration(color: background, shape: BoxShape.circle),
          child: Icon(icon, size: iconSize, color: iconColor),
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
            ListTile(
              leading: Icon(Icons.home_outlined, color: iconColor),
              title: Text(
                'Home',
                style: TextStyle(
                  color: textColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              onTap: () async {
                final NavigatorState navigator = Navigator.of(context);
                await VoiceService.instance.speak('Home');
                if (!navigator.mounted) return;
                navigator.pop();
                Get.offAllNamed(AppRoutes.home);
              },
            ),
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
              tab: SettingsTab.layout,
              textColor: textColor,
              iconColor: iconColor,
            ),
            _settingsItem(
              context,
              icon: Icons.view_carousel_outlined,
              title: 'Card Behavior',
              tab: SettingsTab.cardBehavior,
              textColor: textColor,
              iconColor: iconColor,
            ),
            _settingsItem(
              context,
              icon: Icons.volume_up_outlined,
              title: 'Sound',
              tab: SettingsTab.sound,
              textColor: textColor,
              iconColor: iconColor,
            ),
            _settingsItem(
              context,
              icon: Icons.record_voice_over_outlined,
              title: 'Language And Voice',
              tab: SettingsTab.languageVoice,
              textColor: textColor,
              iconColor: iconColor,
            ),
            _settingsItem(
              context,
              icon: Icons.settings_input_component_outlined,
              title: 'Accessories',
              tab: SettingsTab.accessories,
              textColor: textColor,
              iconColor: iconColor,
            ),
            _settingsItem(
              context,
              icon: Icons.devices_other_outlined,
              title: 'Device',
              tab: SettingsTab.device,
              textColor: textColor,
              iconColor: iconColor,
            ),
            _settingsItem(
              context,
              icon: Icons.privacy_tip_outlined,
              title: 'Account and Privacy',
              tab: SettingsTab.accountPrivacy,
              textColor: textColor,
              iconColor: iconColor,
            ),
            _settingsItem(
              context,
              icon: Icons.help_outline,
              title: 'Help',
              tab: SettingsTab.help,
              textColor: textColor,
              iconColor: iconColor,
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
    required Color textColor,
    required Color iconColor,
  }) {
    return ListTile(
      leading: Icon(icon, color: iconColor),
      title: Text(title, style: TextStyle(color: textColor)),
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
    required Color textColor,
    required Color iconColor,
  }) {
    return ListTile(
      leading: Icon(icon, color: iconColor),
      title: Text(title, style: TextStyle(color: textColor)),
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
