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
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      _leftMenu(),
                      const SizedBox(width: 14.0),
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
    final bool isTablet = isTabletLayout(context);
    final bool isLandscape = _isLandscape;
    
    // Fixed sizes for both tablet and mobile
    final double menuWidth = isTablet 
        ? (isLandscape ? 110.0 : 145.0) 
        : 135.0; // Moderate size for mobile (was 155.0)
    
    return Container(
      width: menuWidth,
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
            margin: EdgeInsets.only(bottom: isTablet ? (isLandscape ? 4.0 : 10.0) : 12.0),
            padding: EdgeInsets.symmetric(
              horizontal: isTablet ? (isLandscape ? 4.0 : 8.0) : 6.0, // Reduced from 10.0
              vertical: isTablet ? (isLandscape ? 4.0 : 6.0) : 6.0, // Reduced from 8.0
            ),
            decoration: BoxDecoration(
              color: colorScheme.surface,
              borderRadius: BorderRadius.circular(24.r),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                _pagerButton(Icons.arrow_back, false),
                SizedBox(width: isTablet ? (isLandscape ? 4.0 : 8.0) : 6.0), // Reduced from 10.0
                Text(
                  '1 / 1',
                  style: TextStyle(fontSize: isTablet ? (isLandscape ? 9.0 : 11.0) : 11.0), // Reduced from 13.0
                ),
                SizedBox(width: isTablet ? (isLandscape ? 4.0 : 8.0) : 6.0), // Reduced from 10.0
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
    final bool isTablet = isTabletLayout(context);
    final bool isLandscape = _isLandscape;
    final bool useDarkSelectedStyle = isDark && selected;
    final bool useLightSelectedStyle = !isDark && selected;
    
    // Fixed sizes for both tablet and mobile
    final double iconSize = isTablet ? (isLandscape ? 16.0 : 22.0) : 24.0; // was 26.0
    final double textSize = isTablet ? (isLandscape ? 12.0 : 16.0) : 16.0; // was 18.0
    final double horizontalPadding = isTablet ? (isLandscape ? 8.0 : 10.0) : 10.0; // was 12.0
    final double verticalPadding = isTablet ? (isLandscape ? 5.0 : 8.0) : 8.0; // was 10.0
    final double spacing = isTablet ? (isLandscape ? 4.0 : 8.0) : 8.0; // was 10.0
    
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding,
          vertical: verticalPadding,
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
              size: iconSize,
              color: selected ? Colors.black : colorScheme.onSurface,
            ),
            SizedBox(width: spacing),
            Text(
              label,
              style: textTheme.bodyMedium?.copyWith(
                fontSize: textSize,
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
    final bool isTablet = isTabletLayout(context);
    final bool isLandscape = _isLandscape;
    final double radius = isTablet ? (isLandscape ? 12.0 : 18.0) : 16.0; // Reduced from 20.0
    final double iconSize = isTablet ? (isLandscape ? 12.0 : 16.0) : 14.0; // Reduced from 18.0
    
    return CircleAvatar(
      radius: radius,
      backgroundColor: dark ? colorScheme.onSurface : colorScheme.surface,
      child: Icon(
        icon,
        size: iconSize,
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
    final bool isTablet = isTabletLayout(context);
    final bool isLandscape = _isLandscape;
    final double circleSize = isTablet ? (isLandscape ? 48.0 : 70.0) : 80.0;
    final double iconSize = isTablet ? (isLandscape ? 30.0 : 46.0) : 52.0;
    
    return _tileFrame(
      child: Container(
        color: _fixedTileGrey,
        child: Center(
          child: Container(
            width: circleSize,
            height: circleSize,
            decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
            child: Icon(
              Icons.file_upload_outlined,
              color: Colors.black,
              size: iconSize,
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
    final bool isTablet = isTabletLayout(context);
    final bool isLandscape = _isLandscape;
    final double padding = isTablet ? (isLandscape ? 8.0 : 14.0) : 18.0;
    
    return _tileFrame(
      child: Container(
        color: _fixedTileGrey,
        child: Padding(
          padding: EdgeInsets.all(padding),
          child: Image.asset(
            AppImages.drawing,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }

  Widget _albumTile(String title) {
    final bool isTablet = isTabletLayout(context);
    final bool isLandscape = _isLandscape;
    final double horizontalPadding = isTablet ? (isLandscape ? 6.0 : 10.0) : 12.0;
    final double topPadding = isTablet ? (isLandscape ? 4.0 : 8.0) : 10.0;
    final double bottomPadding = isTablet ? (isLandscape ? 3.0 : 6.0) : 8.0;
    final double badgePaddingH = isTablet ? (isLandscape ? 6.0 : 10.0) : 12.0;
    final double badgePaddingV = isTablet ? (isLandscape ? 2.0 : 3.0) : 4.0;
    final double badgeTextSize = isTablet ? (isLandscape ? 9.0 : 11.0) : 13.0;
    final double nameTextSize = isTablet ? (isLandscape ? 10.0 : 13.0) : 15.0;
    final double descTextSize = isTablet ? (isLandscape ? 8.0 : 11.0) : 13.0;
    final double spacing = isTablet ? (isLandscape ? 2.0 : 3.0) : 4.0;
    
    return _tileFrame(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(
              horizontalPadding,
              topPadding,
              horizontalPadding,
              bottomPadding,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: badgePaddingH,
                    vertical: badgePaddingV,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF71D2F8),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: badgeTextSize,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(height: spacing),
                Text(
                  'Album Name',
                  style: TextStyle(
                    fontSize: nameTextSize,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  'Write Here',
                  style: TextStyle(
                    fontSize: descTextSize,
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
    final bool isTablet = isTabletLayout(context);
    final bool isLandscape = _isLandscape;
    final double iconSize = isTablet ? (isLandscape ? 24.0 : 36.0) : 42.0;
    final double textSize = isTablet ? (isLandscape ? 11.0 : 14.0) : 16.0;
    final double spacing = isTablet ? (isLandscape ? 4.0 : 8.0) : 10.0;
    
    return _tileFrame(
      child: Container(
        color: _fixedTileGrey,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(icon, size: iconSize, color: Colors.black54),
              SizedBox(height: spacing),
              Text(
                label,
                style: TextStyle(
                  fontSize: textSize,
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
