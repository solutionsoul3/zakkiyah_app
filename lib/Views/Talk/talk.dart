import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:zakkiyah_app/Views/home/tile_items_screen.dart';
import 'package:zakkiyah_app/constants/images/images.dart';
import 'package:zakkiyah_app/widgets/app_menu_drawer.dart';
import 'package:zakkiyah_app/widgets/app_screen_header.dart';
import 'package:zakkiyah_app/widgets/responsive_frame.dart';

class TalkScreen extends StatefulWidget {
  const TalkScreen({super.key});

  @override
  State<TalkScreen> createState() => _TalkScreenState();
}

class _TalkScreenState extends State<TalkScreen> {
  bool _isEditing = false;

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
                titleContent: const AppHeaderTitle(
                  segments: <AppHeaderSegment>[
                    AppHeaderSegment(
                      label: 'Talk',
                      icon: Icons.record_voice_over_outlined,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      _leftRail(context),
                      const SizedBox(width: 12.0),
                      Expanded(
                        child: LayoutBuilder(
                          builder: (BuildContext context, BoxConstraints constraints) {
                            final int crossAxisCount =
                                responsiveCrossAxisCount(context, width: constraints.maxWidth);
                            final bool isTablet = isTabletLayout(context);
                            final double spacing = isTablet ? 14.0 : 16.0; // Increased spacing for mobile
                            
                            // Calculate to fit all 12 categories in 6 rows (2x6 grid)
                            final int itemCount = _categories.length;
                            final int targetRows = (itemCount / crossAxisCount).ceil();
                            
                            final double availableWidth = constraints.maxWidth;
                            final double availableHeight = constraints.maxHeight;
                            
                            final double totalHorizontalSpacing = spacing * (crossAxisCount - 1);
                            final double totalVerticalSpacing = spacing * (targetRows - 1);
                            
                            final double cellHeight = (availableHeight - totalVerticalSpacing) / targetRows;
                            final double cellWidth = (availableWidth - totalHorizontalSpacing) / crossAxisCount;
                            final double aspectRatio = cellWidth / cellHeight;
                            
                            return GridView.builder(
                              itemCount: itemCount,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: crossAxisCount,
                                crossAxisSpacing: spacing,
                                mainAxisSpacing: spacing,
                                childAspectRatio: aspectRatio,
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
      width: railWidth(context),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1A1A1A) : const Color(0xFFE3E3E3),
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(height: railVerticalPadding(context)),
            _railIcon(
              context: context,
              icon: Icons.arrow_back,
              label: 'Back',
              onTap: () => Navigator.pop(context),
            ),
            SizedBox(height: railVerticalPadding(context)),
            _railIcon(
              context: context,
              icon: Icons.add_box_outlined,
              label: 'Add',
              onTap: () {},
            ),
            SizedBox(height: railVerticalPadding(context)),
            _railIcon(
              context: context,
              icon: _isEditing ? Icons.check_circle_outline : Icons.edit_note_outlined,
              label: _isEditing ? 'Done' : 'Edit',
              onTap: () => setState(() => _isEditing = !_isEditing),
            ),
            SizedBox(height: railVerticalPadding(context) * 2.5),
            _railIcon(
              context: context,
              icon: Icons.undo,
              label: 'Undo',
              onTap: () {},
            ),
            SizedBox(height: railVerticalPadding(context) * 2.5),
            _railIcon(
              context: context,
              icon: Icons.redo,
              label: 'Redo',
              onTap: () {},
            ),
            SizedBox(height: railVerticalPadding(context) * 1.5),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.chevron_left, size: railIconSize(context) * 0.9, color: Colors.black54),
                SizedBox(width: 6.0),
                Text(
                  '1/1',
                  style: TextStyle(
                    fontSize: railLabelSp(context),
                    color: isDark ? Colors.white : Colors.black,
                  ),
                ),
                SizedBox(width: 6.0),
                Icon(Icons.chevron_right, size: railIconSize(context) * 0.9, color: Colors.black54),
              ],
            ),
            SizedBox(height: railVerticalPadding(context)),
          ],
        ),
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
        width: railIconContainerW(context),
        padding: EdgeInsets.symmetric(vertical: railVerticalPadding(context)),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF2A2A2A) : const Color(0xFFF2F2F2),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Column(
          children: <Widget>[
            Icon(icon, size: railIconSize(context), color: isDark ? Colors.white70 : Colors.black54),
            SizedBox(height: 3.0),
            Text(
              label,
              style: TextStyle(
                fontSize: railLabelSp(context),
                color: isDark ? Colors.white : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _categoryCard(_ImportantCategoryData data) {
    final bool isTablet = isTabletLayout(context);
    final Color lightTileBackground = Color.lerp(data.labelColor, Colors.white, 0.82)!;
    
    // Larger sizes for mobile
    final double borderRadius = isTablet ? 20.0 : 24.0;
    final double innerRadius = isTablet ? 18.0 : 22.0;
    final double ribbonTop = isTablet ? 24.0 : 28.0;
    final double ribbonWidth = isTablet ? 120.0 : 130.0;
    final double ribbonHeight = isTablet ? 38.0 : 34.0;
    final double ribbonPaddingLeft = isTablet ? 14.0 : 16.0;
    final double ribbonPaddingRight = isTablet ? 26.0 : 30.0;
    final double ribbonTextSize = isTablet ? 15.0 : 18.0;
    final double imagePadding = isTablet ? 10.0 : 12.0;
    final double imagePaddingBottom = isTablet ? 8.0 : 10.0;
    final double imageSize = isTablet ? 65.0 : 75.0;
    final double iconSize = isTablet ? 28.0 : 32.0;
    
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
      borderRadius: BorderRadius.circular(borderRadius),
      child: Stack(
        clipBehavior: Clip.none,
        children: <Widget>[
          Positioned.fill(
            top: ribbonTop,
            child: Container(
              decoration: BoxDecoration(
                color: lightTileBackground,
                borderRadius: BorderRadius.circular(innerRadius),
              ),
              child: Padding(
                padding: EdgeInsets.fromLTRB(imagePadding, imagePadding, imagePadding, imagePaddingBottom),
                child: Center(
                  child: Image.asset(
                    data.imagePath,
                    width: imageSize,
                    height: imageSize,
                    fit: BoxFit.contain,
                    errorBuilder: (_, __, ___) =>
                        Icon(Icons.image_outlined, size: iconSize, color: Colors.blueGrey),
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
                width: ribbonWidth,
                height: ribbonHeight,
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(left: ribbonPaddingLeft, right: ribbonPaddingRight),
                color: data.labelColor,
                child: Text(
                  data.label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: ribbonTextSize,
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
