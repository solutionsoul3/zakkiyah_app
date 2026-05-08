import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:zakkiyah_app/Views/home/tile_items_screen.dart';
import 'package:zakkiyah_app/constants/images/images.dart';
import 'package:zakkiyah_app/widgets/app_menu_drawer.dart';
import 'package:zakkiyah_app/widgets/app_screen_header.dart';
import 'package:zakkiyah_app/widgets/responsive_frame.dart';

class TalkScreen extends StatelessWidget {
  const TalkScreen({super.key});

  static const List<_ImportantCategoryData> _categories = <_ImportantCategoryData>[
    _ImportantCategoryData(
      label: 'Snacks',
      imagePath: AppImages.snacks,
      labelColor: Color(0xFFFFB6C1),

    ),
    _ImportantCategoryData(
      label: 'Drinks',
      imagePath: AppImages.drink,
      labelColor: Color(0xFFFFCF70),

    ),
    _ImportantCategoryData(
      label: 'Breakfast',
      imagePath: AppImages.breakfast,
      labelColor: Color(0xFFA9EA9A),

    ),
    _ImportantCategoryData(
      label: 'Lunch',
      imagePath: AppImages.lunch,
      labelColor: Color(0xFF87E0EA),

    ),
    _ImportantCategoryData(
      label: 'Dinner',
      imagePath: AppImages.dinner,
      labelColor: Color(0xFF80D4F5),

    ),
    _ImportantCategoryData(
      label: 'Restraunt',
      imagePath: AppImages.restraunt,
      labelColor: Color(0xFFB7A5F7),

    ),
    _ImportantCategoryData(
      label: 'Myslef',
      imagePath: AppImages.myself,
      labelColor: Color(0xFFFFB590),

    ),
    _ImportantCategoryData(
      label: 'Friends',
      imagePath: AppImages.friends,
      labelColor: Color(0xFFC6AAFF),

    ),
    _ImportantCategoryData(
      label: 'Family Member',
      imagePath: AppImages.familymember,
      labelColor: Color(0xFFFFCB6B),

    ),
    _ImportantCategoryData(
      label: 'School',
      imagePath: AppImages.school,
      labelColor: Color(0xFFBEE08B),

    ),
    _ImportantCategoryData(
      label: 'Education',
      imagePath: AppImages.education,
      labelColor: Color(0xFF82D9F5),

    ),
    _ImportantCategoryData(
      label: 'Important',
      imagePath: AppImages.importanttt,
      labelColor: Color(0xFFFF9CB6),

    ),
  ];

  @override
  Widget build(BuildContext context) {
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
                titleContent: Row(
                  children: <Widget>[
                    Icon(Icons.home, size: 18.w),
                    SizedBox(width: 6.w),
                    Text('Home', style: TextStyle(fontSize: 20.sp)),
                    SizedBox(width: 12.w),
                    Icon(Icons.label_outline, size: 18.w),
                    SizedBox(width: 6.w),
                    Text('Talk', style: TextStyle(fontSize: 20.sp)),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(10.w),
                  child: Row(
                    children: <Widget>[
                      _leftRail(context),
                      SizedBox(width: 10.w),
                      Expanded(
                        child: LayoutBuilder(
                          builder: (BuildContext context, BoxConstraints constraints) {
                            final int crossAxisCount = constraints.maxWidth > 900 ? 3 : 2;
                            return GridView.builder(
                              itemCount: _categories.length,
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: crossAxisCount,
                                crossAxisSpacing: 14.w,
                                mainAxisSpacing: 14.h,
                                childAspectRatio: 1.0,
                              ),
                              itemBuilder: (_, int index) {
                                final _ImportantCategoryData category = _categories[index];
                                return _categoryCard(category);
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _leftRail(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      width: 92.w,
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1A1A1A) : const Color(0xFFE3E3E3),
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Column(
        children: <Widget>[
          SizedBox(height: 8.h),
          _railIcon(
            context: context,
            icon: Icons.arrow_back,
            label: 'Back',
            onTap: () => Navigator.pop(context),
          ),
          SizedBox(height: 8.h),
          _railIcon(
            context: context,
            icon: Icons.search,
            label: 'Search',
            onTap: () {},
          ),
          SizedBox(height: 8.h),
          _railIcon(
            context: context,
            icon: Icons.menu_book,
            label: 'Tutorial',
            onTap: () {},
          ),
          const Spacer(),
          _railIcon(
            context: context,
            icon: Icons.arrow_back_ios,
            label: 'Prev',
            onTap: () {},
          ),
          SizedBox(height: 8.h),
          _railIcon(
            context: context,
            icon: Icons.arrow_forward_ios,
            label: 'Next',
            onTap: () {},
          ),
          SizedBox(height: 8.h),
        ],
      ),
    );
  }

  Widget _railIcon({
    required BuildContext context,
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8.r),
      child: Container(
        width: 64.w,
        padding: EdgeInsets.symmetric(vertical: 8.h),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF2A2A2A) : const Color(0xFFF2F2F2),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Column(
          children: <Widget>[
            Icon(icon, size: 22.w, color: isDark ? Colors.white70 : Colors.black54),
            SizedBox(height: 3.h),
            Text(
              label,
              style: TextStyle(
                fontSize: 10.sp,
                color: isDark ? Colors.white : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _categoryCard(_ImportantCategoryData data) {
    final Color lightTileBackground = Color.lerp(data.labelColor, Colors.white, 0.82)!;
    return InkWell(
      // onTap: () {
      //   Get.to(
      //         () => TileItemsScreen(
      //       title: data.label,
      //       defaultAddImagePath: data.imagePath,
      //
      //       breadcrumbTitles: <String>['Home', 'Important',],
      //     ),
      //   );
      // },
      borderRadius: BorderRadius.circular(20.r),
      child: Stack(
        clipBehavior: Clip.none,
        children: <Widget>[
          Positioned.fill(
            top: 24.h,
            child: Container(
              decoration: BoxDecoration(
                color: lightTileBackground,
                borderRadius: BorderRadius.circular(18.r),
              ),
              child: Padding(
                padding: EdgeInsets.fromLTRB(10.w, 10.h, 10.w, 8.h),
                child: Center(
                  child: Image.asset(
                    data.imagePath,
                    width: 65.w,
                    height: 65.h,
                    fit: BoxFit.contain,
                    errorBuilder: (_, __, ___) =>
                        Icon(Icons.image_outlined, size: 28.w, color: Colors.blueGrey),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            child: ClipPath(
              clipper: _RibbonClipper(),
              child: Container(
                width: 120.w,
                height: 38.h,
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(left: 14.w, right: 26.w),
                color: data.labelColor,
                child: Text(
                  data.label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ImportantCategoryData {
  const _ImportantCategoryData({
    required this.label,
    required this.imagePath,
    required this.labelColor,
  });

  final String label;
  final String imagePath;
  final Color labelColor;
}

class _RibbonClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final Path path = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width - 20, 0)
      ..lineTo(size.width, size.height / 2)
      ..lineTo(size.width - 20, size.height)
      ..lineTo(0, size.height)
      ..close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
