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
import 'package:zakkiyah_app/constants/Colors/colors.dart';
import 'package:zakkiyah_app/constants/images/images.dart';
import 'package:zakkiyah_app/widgets/app_screen_header.dart';
import 'package:zakkiyah_app/widgets/responsive_frame.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final PageController _pageController = PageController();
  int _currentPage = 0;
  final Set<String> _unlockedTiles = <String>{};

  final List<List<_HomeTileData>> _pages = <List<_HomeTileData>>[
    <_HomeTileData>[
      _HomeTileData('Talk', AppImages.talk, AppColors.homeTile1),
      _HomeTileData('Schedule', AppImages.schedule, AppColors.homeTile2),
      _HomeTileData('Type', AppImages.type, AppColors.homeTile3),
      _HomeTileData('Media', AppImages.media, AppColors.homeTile4),
      _HomeTileData('Therapy', AppImages.therapy, AppColors.homeTile5),
      _HomeTileData('Draw', AppImages.draw, AppColors.homeTile6),
      _HomeTileData('Learn', AppImages.learn, AppColors.homeTile7),
      _HomeTileData('Read', AppImages.read, AppColors.homeTile8),
    ],
    <_HomeTileData>[
      _HomeTileData('Shapes', AppImages.shapes, AppColors.homeTile1),
      _HomeTileData('Daily Routine', AppImages.dailyRoutine, AppColors.homeTile2),
      _HomeTileData('Alphabet', AppImages.alphabet, AppColors.homeTile3),
      _HomeTileData('Numbers', AppImages.numbers, AppColors.homeTile4),
      _HomeTileData('Colors', AppImages.colors, AppColors.homeTile5),
      _HomeTileData('Sign Language', AppImages.signLanguage, AppColors.homeTile6),
      _HomeTileData('Feelings', AppImages.feelings, AppColors.homeTile7),
      _HomeTileData('Important', AppImages.important, AppColors.homeTile8),
    ],
    <_HomeTileData>[
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
    ],
  ];

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
                child: Padding(
                  padding: EdgeInsets.all(10.w),
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: _pages.length,
                    onPageChanged: (int index) => setState(() => _currentPage = index),
                    itemBuilder: (_, int pageIndex) {
                      final List<_HomeTileData> pageItems = _pages[pageIndex];
                      return GridView.builder(
                        itemCount: pageItems.length,
                        physics: const BouncingScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 15.h,
                          crossAxisSpacing: 15.w,
                          childAspectRatio: 1.15,
                        ),
                        itemBuilder: (_, int index) {
                          final _HomeTileData tile = pageItems[index];
                          final bool isUnlocked = _unlockedTiles.contains(tile.label);
                          return _HomeTile(
                            data: tile,
                            isUnlocked: isUnlocked,
                            onLockToggle: () {
                              setState(() {
                                if (isUnlocked) {
                                  _unlockedTiles.remove(tile.label);
                                } else {
                                  _unlockedTiles.add(tile.label);
                                }
                              });
                            },
                            onTap: () {
                              if (!isUnlocked) return;
                              _openTileScreen(tile.label.toLowerCase());
                            },
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(12.w, 0, 12.w, 8.h),
                child: Row(
                  children: <Widget>[
                    _ArrowButton(
                      icon: Icons.arrow_back_ios_new,
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
    required this.isUnlocked,
    required this.onLockToggle,
    this.onTap,
  });
  final _HomeTileData data;
  final bool isUnlocked;
  final VoidCallback onLockToggle;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final Color lightTileBackground = Color.lerp(data.labelColor, Colors.white, 0.82)!;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8.r),
      child: Container(
        decoration: BoxDecoration(
          color: lightTileBackground,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(8.w),
                    child: Image.asset(
                      data.imagePath,
                      width: 85.w,
                      height: 85.h,
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
                    style: TextStyle(color: Colors.black87, fontSize: 18.sp),
                  ),
                ),
              ],
            ),
            Positioned(
              top: 6.h,
              right: 6.w,
              child: GestureDetector(
                onTap: onLockToggle,
                child: Container(
                  padding: EdgeInsets.all(4.w),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    isUnlocked ? Icons.lock_open_rounded : Icons.lock_rounded,
                    size: 18.w,
                    color: Colors.black87,
                  ),
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
    required this.enabled,
    required this.onTap,
    this.dark = false,
  });
  final IconData icon;
  final bool enabled;
  final VoidCallback onTap;
  final bool dark;

  @override
  Widget build(BuildContext context) {
    final Color background = dark ? Colors.black : Colors.grey;
    final Color iconColor = dark ? Colors.white : Colors.black;
    return InkWell(
      onTap: enabled ? onTap : null,
      borderRadius: BorderRadius.circular(20.r),
      child: Opacity(
        opacity: enabled ? 1 : 0.35,
        child: Container(
          width: 42.w,
          height: 42.w,
          decoration: BoxDecoration(color: background, shape: BoxShape.circle),
          child: Icon(icon, size: 14.w, color: iconColor),
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
