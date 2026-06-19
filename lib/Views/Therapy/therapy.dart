import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zakkiyah_app/widgets/app_menu_drawer.dart';
import 'package:zakkiyah_app/widgets/app_screen_header.dart';
import 'package:zakkiyah_app/widgets/responsive_frame.dart';
import 'package:zakkiyah_app/widgets/voice_tap.dart';

class TherapyScreen extends StatelessWidget {
  const TherapyScreen({super.key});

  double _newCardSize(BoxConstraints constraints, bool isTablet) {
    final double width = constraints.maxWidth;
    final double height = constraints.maxHeight;

    if (isTablet) {
      if (width > height) {
        return (height * 0.58).clamp(150.0, 340.0);
      }
      return (width * 0.34).clamp(160.0, 300.0);
    }

    final double shortest = width < height ? width : height;
    return (shortest * 0.4).clamp(130.0, 200.0);
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final bool isTablet = MediaQuery.sizeOf(context).shortestSide >= 600;
    final Color panelColor = isDark ? const Color(0xFF1A1A1A) : const Color(0xFFEDEDED);
    final Color cardColor = isDark ? const Color(0xFF2A2A2A) : const Color(0xFFE3E3E3);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      endDrawer: const AppMenuDrawer(),
      body: SafeArea(
        child: ResponsiveFrame(
          tabletMaxWidth: 1300,
          child: Column(
            children: <Widget>[
              AppScreenHeader(
                topBarHeight: 56,
                topBarPadding: EdgeInsets.symmetric(horizontal: 8.w),
                greetingText: 'Good Morning Zakkiyah',
                titleContent: const AppHeaderTitle(
                  segments: <AppHeaderSegment>[
                    AppHeaderSegment(
                      label: 'Therapy',
                      icon: Icons.spa_outlined,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: panelColor,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(24.r),
                      bottomRight: Radius.circular(24.r),
                    ),
                  ),
                  child: LayoutBuilder(
                    builder: (BuildContext context, BoxConstraints constraints) {
                      final double cardSize = _newCardSize(constraints, isTablet);
                      final double iconCircle = cardSize * 0.4;
                      final double iconSize = iconCircle * 0.56;
                      final double labelSize = (cardSize * 0.09).clamp(12.0, 20.0);

                      return Center(
                        child: Padding(
                          padding: EdgeInsets.all(12.w),
                          child: VoiceTap(
                            announceText: 'New therapy item',
                            onTap: () async {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Create new therapy item')),
                              );
                            },
                            borderRadius: BorderRadius.circular(12.r),
                            child: SizedBox(
                              width: cardSize,
                              height: cardSize,
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  color: cardColor,
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      width: iconCircle,
                                      height: iconCircle,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.black,
                                      ),
                                      child: Icon(
                                        Icons.add,
                                        color: Colors.white,
                                        size: iconSize,
                                      ),
                                    ),
                                    SizedBox(height: cardSize * 0.06),
                                    FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Text(
                                        'New',
                                        style: TextStyle(
                                          fontSize: labelSize,
                                          color: isDark ? Colors.white : Colors.black87,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
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
}
