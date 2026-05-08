import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zakkiyah_app/widgets/app_menu_drawer.dart';
import 'package:zakkiyah_app/widgets/app_screen_header.dart';
import 'package:zakkiyah_app/widgets/responsive_frame.dart';

class TherapyScreen extends StatelessWidget {
  const TherapyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      endDrawer: const AppMenuDrawer(),
      body: SafeArea(
        child: ResponsiveFrame(
          tabletMaxWidth: 1300,
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFFEDEDED),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(24.r),
                bottomRight: Radius.circular(24.r),
              ),
            ),
            child: Column(
              children: <Widget>[
                AppScreenHeader(
                  topBarHeight: 56,
                  topBarPadding: EdgeInsets.symmetric(horizontal: 8.w),
                  titleContent: Row(
                    children: <Widget>[
                      Icon(Icons.home, size: 18.w),
                      SizedBox(width: 6.w),
                      Text('Home', style: TextStyle(fontSize: 20.sp)),
                      SizedBox(width: 12.w),
                      Icon(Icons.spa_outlined, size: 18.w),
                      SizedBox(width: 6.w),
                      Text('Therapy', style: TextStyle(fontSize: 20.sp)),
                    ],
                  ),
                ),
                Expanded(
                  child: Center(
                    child: InkWell(
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Create new therapy item')),
                        );
                      },
                      borderRadius: BorderRadius.circular(12.r),
                      child: Container(
                        width: 160.w,
                        height: 160.h,
                        decoration: BoxDecoration(
                          color: const Color(0xFFE3E3E3),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              width: 64.w,
                              height: 64.w,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.black,
                              ),
                              child: Icon(Icons.add, color: Colors.white, size: 36.w),
                            ),
                            SizedBox(height: 10.h),
                            Text('New', style: TextStyle(fontSize: 14.sp)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
