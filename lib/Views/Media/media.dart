import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zakkiyah_app/constants/images/images.dart';
import 'package:zakkiyah_app/widgets/app_menu_drawer.dart';
import 'package:zakkiyah_app/widgets/app_screen_header.dart';
import 'package:zakkiyah_app/widgets/responsive_frame.dart';

class MediaScreen extends StatefulWidget {
  const MediaScreen({super.key});

  @override
  State<MediaScreen> createState() => _MediaScreenState();
}

class _MediaScreenState extends State<MediaScreen> {
  static const Color _fixedTileGrey = Color(0xFFE5E5E5);
  int _selectedIndex = 0;

  static const List<_MediaMenuItem> _menuItems = <_MediaMenuItem>[
    _MediaMenuItem(label: 'All Files', icon: Icons.folder_open_outlined),
    _MediaMenuItem(label: 'Albums', icon: Icons.collections_outlined),
    _MediaMenuItem(label: 'Photos', icon: Icons.photo_outlined),
    _MediaMenuItem(label: 'Videos', icon: Icons.videocam_outlined),
    _MediaMenuItem(label: 'Audio', icon: Icons.graphic_eq_rounded),
    _MediaMenuItem(label: 'Drawings', icon: Icons.brush_outlined),
    _MediaMenuItem(label: 'Downloads', icon: Icons.download_outlined),
    _MediaMenuItem(label: 'Trash', icon: Icons.delete_outline),
  ];

  bool get _isLandscape =>
      MediaQuery.of(context).orientation == Orientation.landscape;

  double _tileShortSide(double width, double height) =>
      math.min(width, height);

  Widget _circleMediaButton({
    required IconData icon,
    required double diameter,
    Color backgroundColor = Colors.white,
    Color iconColor = Colors.black,
  }) {
    return Container(
      width: diameter,
      height: diameter,
      decoration: BoxDecoration(color: backgroundColor, shape: BoxShape.circle),
      child: Icon(icon, color: iconColor, size: diameter * 0.52),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
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
                      label: 'Media',
                      icon: Icons.perm_media_outlined,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  color: colorScheme.surface,
                  padding: EdgeInsets.all(10.w),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      _leftMenu(),
                      SizedBox(width: 12.w),
                      Expanded(child: _mainGrid()),
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

  Widget _leftMenu() {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final bool isLandscape = _isLandscape;
    return Container(
      width: (isLandscape ? 110 : 145).w,
      decoration: BoxDecoration(
        color: isDark ? colorScheme.surfaceContainerHighest : colorScheme.surfaceVariant,
        borderRadius: BorderRadius.circular(4.r),
      ),
      child: Column(
        children: <Widget>[
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _menuButton(
                  label: 'Go Back',
                  icon: Icons.reply_rounded,
                  selected: false,
                  onTap: () => Navigator.pop(context),
                ),
                for (int i = 0; i < _menuItems.length; i++)
                  _menuButton(
                    label: _menuItems[i].label,
                    icon: _menuItems[i].icon,
                    selected: i == _selectedIndex,
                    onTap: () => setState(() => _selectedIndex = i),
                  ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: (isLandscape ? 4 : 10).h),
            padding: EdgeInsets.symmetric(
              horizontal: (isLandscape ? 4 : 8).w,
              vertical: (isLandscape ? 4 : 6).h,
            ),
            decoration: BoxDecoration(
              color: colorScheme.surface,
              borderRadius: BorderRadius.circular(24.r),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                _pagerButton(Icons.arrow_back, false),
                SizedBox(width: (isLandscape ? 4 : 8).w),
                Text(
                  '1 / 1',
                  style: TextStyle(fontSize: (isLandscape ? 9 : 11).sp),
                ),
                SizedBox(width: (isLandscape ? 4 : 8).w),
                _pagerButton(Icons.arrow_forward, true),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _menuButton({
    required String label,
    required IconData icon,
    required bool selected,
    required VoidCallback onTap,
  }) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final TextTheme textTheme = Theme.of(context).textTheme;
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final bool isLandscape = _isLandscape;
    final bool useDarkSelectedStyle = isDark && selected;
    final bool useLightSelectedStyle = !isDark && selected;
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: (isLandscape ? 8 : 10).w,
          vertical: (isLandscape ? 5 : 8).h,
        ),
        decoration: BoxDecoration(
          color: useDarkSelectedStyle
              ? Colors.white
              : (useLightSelectedStyle
                    ? const Color(0xFF71D2F8)
                    : Colors.transparent),
          border: Border(
            bottom: BorderSide(color: colorScheme.outline.withOpacity(0.2)),
          ),
        ),
        child: Row(
          children: <Widget>[
            Icon(
              icon,
              size: (isLandscape ? 16 : 22).w,
              color: selected ? Colors.black : colorScheme.onSurface,
            ),
            SizedBox(width: (isLandscape ? 4 : 8).w),
            Text(
              label,
              style: textTheme.bodyMedium?.copyWith(
                fontSize: (isLandscape ? 12 : 16).sp,
                color: selected ? Colors.black : colorScheme.onSurface,
                fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _pagerButton(IconData icon, bool dark) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final bool isLandscape = _isLandscape;
    return CircleAvatar(
      radius: (isLandscape ? 12 : 18).r,
      backgroundColor: dark ? colorScheme.onSurface : colorScheme.surface,
      child: Icon(
        icon,
        size: (isLandscape ? 12 : 16).w,
        color: dark ? colorScheme.surface : colorScheme.onSurface,
      ),
    );
  }

  Widget _mainGrid() {
    final List<Widget> tiles = _tilesForSelectedMenu();
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        const int crossAxisCount = kTileCrossAxisCount;
        final bool isTablet = isTabletLayout(context);
        final double spacing = isTablet ? 14.0 : 14.w;
        
        // Calculate to fit all tiles in one screen without scrolling
        final int itemCount = tiles.length;
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
          itemBuilder: (_, int index) => tiles[index],
        );
      },
    );
  }

  List<Widget> _tilesForSelectedMenu() {
    switch (_selectedIndex) {
      case 0: // All Files
        return <Widget>[
          _uploadTile(),
          _photoTile(play: false),
          _audioTile(selected: false),
          _audioTile(selected: true),
          _drawingTile(),
          _photoTile(play: true),
          _drawingTile(),
          _photoTile(play: true),
        ];
      case 1: // Albums
        return <Widget>[
          _albumTile('A1'),
          _albumTile('A2'),
          _albumTile('A3'),
          _albumTile('A4'),
          _albumTile('A5'),
          _albumTile('A6'),
          _albumTile('A7'),
          _albumTile('A8'),
        ];
      case 2: // Photos
        return List<Widget>.generate(8, (_) => _photoTile(play: false));
      case 3: // Videos
        return List<Widget>.generate(8, (_) => _photoTile(play: true));
      case 4: // Audio
        return <Widget>[
          _audioTile(selected: true),
          _audioTile(selected: false),
          _audioTile(selected: false),
          _audioTile(selected: false),
          _audioTile(selected: false),
          _audioTile(selected: false),
          _audioTile(selected: false),
          _audioTile(selected: false),
        ];
      case 5: // Drawings
        return List<Widget>.generate(8, (_) => _drawingTile());
      case 6: // Downloads
        return List<Widget>.generate(
          8,
          (int i) => _statusTile('Download ${i + 1}', Icons.download_done_rounded),
        );
      case 7: // Trash
        return List<Widget>.generate(
          8,
          (int i) => _statusTile('Trash ${i + 1}', Icons.delete_outline_rounded),
        );
      default:
        return <Widget>[_statusTile('No data', Icons.info_outline)];
    }
  }

  Widget _tileFrame({required Widget child, bool selected = false}) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        color: _fixedTileGrey,
        borderRadius: BorderRadius.circular(14.r),
        border: selected ? Border.all(color: colorScheme.primary, width: 2) : null,
      ),
      child: ClipRRect(borderRadius: BorderRadius.circular(14.r), child: child),
    );
  }

  Widget _uploadTile() {
    final bool isLandscape = _isLandscape;
    return _tileFrame(
      child: Container(
        color: _fixedTileGrey,
        child: Center(
          child: Container(
            width: (isLandscape ? 48 : 70).w,
            height: (isLandscape ? 48 : 70).w,
            decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
            child: Icon(
              Icons.file_upload_outlined,
              color: Colors.black,
              size: (isLandscape ? 30 : 46).w,
            ),
          ),
        ),
      ),
    );
  }

  Widget _photoTile({required bool play}) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final double shortSide = _tileShortSide(
          constraints.maxWidth,
          constraints.maxHeight,
        );
        final double playDiameter = shortSide * 0.34;

        return _tileFrame(
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              if (play) Container(color: _fixedTileGrey),
              Image.asset(AppImages.photo, fit: BoxFit.cover),
              if (play) Container(color: colorScheme.scrim.withOpacity(0.25)),
              if (play)
                Center(
                  child: _circleMediaButton(
                    icon: Icons.play_arrow_rounded,
                    diameter: playDiameter,
                    backgroundColor: colorScheme.surface,
                    iconColor: colorScheme.onSurface,
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _audioTile({required bool selected}) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final TextTheme textTheme = Theme.of(context).textTheme;
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final double shortSide = _tileShortSide(
          constraints.maxWidth,
          constraints.maxHeight,
        );
        final double iconDiameter = shortSide * 0.38;
        final double labelSize = shortSide * 0.11;

        return _tileFrame(
          selected: selected,
          child: Container(
            color: _fixedTileGrey,
            padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 4.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  flex: 3,
                  child: Center(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: _circleMediaButton(
                        icon: Icons.volume_up_rounded,
                        diameter: iconDiameter,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Center(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        '10 Oct 2025',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: textTheme.titleSmall?.copyWith(
                          fontSize: labelSize,
                          color: colorScheme.onSecondaryContainer,
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

  Widget _drawingTile() {
    final bool isLandscape = _isLandscape;
    return _tileFrame(
      child: Container(
        color: _fixedTileGrey,
        child: Padding(
          padding: EdgeInsets.all((isLandscape ? 8 : 14).w),
          child: Image.asset(
            AppImages.drawing,
            height: (isLandscape ? 14 : 20).h,
            width: (isLandscape ? 14 : 20).w,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }

  Widget _albumTile(String title) {
    final bool isLandscape = _isLandscape;
    return _tileFrame(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(
              (isLandscape ? 6 : 10).w,
              (isLandscape ? 4 : 8).h,
              (isLandscape ? 6 : 10).w,
              (isLandscape ? 3 : 6).h,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: (isLandscape ? 6 : 10).w,
                    vertical: (isLandscape ? 2 : 3).h,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF71D2F8),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: (isLandscape ? 9 : 11).sp,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(height: (isLandscape ? 2 : 3).h),
                Text(
                  'Album Name',
                  style: TextStyle(
                    fontSize: (isLandscape ? 10 : 13).sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  'Write Here',
                  style: TextStyle(
                    fontSize: (isLandscape ? 8 : 11).sp,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(14.r),
                bottomRight: Radius.circular(14.r),
              ),
              child: Image.asset(
                AppImages.album,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(color: _fixedTileGrey),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _statusTile(String label, IconData icon) {
    final bool isLandscape = _isLandscape;
    return _tileFrame(
      child: Container(
        color: _fixedTileGrey,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(icon, size: (isLandscape ? 24 : 36).w, color: Colors.black54),
              SizedBox(height: (isLandscape ? 4 : 8).h),
              Text(
                label,
                style: TextStyle(
                  fontSize: (isLandscape ? 11 : 14).sp,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MediaMenuItem {
  const _MediaMenuItem({required this.label, required this.icon});

  final String label;
  final IconData icon;
}
