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
                titleContent: Row(
                  children: <Widget>[
                    _topTab('Home', false),
                    SizedBox(width: 8.w),
                    _topTab('Media', true),
                  ],
                ),
                greetingText: 'Good Morning Zakkiyah',
              ),
              Expanded(
                child: Container(
                  color: colorScheme.surface,
                  padding: EdgeInsets.all(10.w),
                  child: Row(
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

  Widget _topTab(String title, bool active) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: active ? colorScheme.onSurface : colorScheme.onSurface.withOpacity(0.9),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(
            active ? Icons.people_alt : Icons.home_filled,
            color: colorScheme.surface,
            size: 18.w,
          ),
          SizedBox(width: 8.w),
          Text(
            title,
            style: textTheme.titleMedium?.copyWith(
              color: colorScheme.surface,
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _leftMenu() {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      width: 145.w,
      decoration: BoxDecoration(
        color: isDark ? colorScheme.surfaceContainerHighest : colorScheme.surfaceVariant,
        borderRadius: BorderRadius.circular(4.r),
      ),
      child: Column(
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
          const Spacer(),
          Container(
            margin: EdgeInsets.only(bottom: 10.h),
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: colorScheme.surface,
              borderRadius: BorderRadius.circular(24.r),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                _pagerButton(Icons.arrow_back, false),
                SizedBox(width: 8.w),
                Text('1 / 1', style: TextStyle(fontSize: 11.sp)),
                SizedBox(width: 8.w),
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
    final bool useDarkSelectedStyle = isDark && selected;
    final bool useLightSelectedStyle = !isDark && selected;
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
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
              size: 22.w,
              color: selected ? Colors.black : colorScheme.onSurface,
            ),
            SizedBox(width: 8.w),
            Text(
              label,
              style: textTheme.bodyMedium?.copyWith(
                fontSize: 16.sp,
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
    return CircleAvatar(
      radius: 16.r,
      backgroundColor: dark ? colorScheme.onSurface : colorScheme.surface,
      child: Icon(
        icon,
        size: 16.w,
        color: dark ? colorScheme.surface : colorScheme.onSurface,
      ),
    );
  }

  Widget _mainGrid() {
    final List<Widget> tiles = _tilesForSelectedMenu();
    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 14.w,
      mainAxisSpacing: 14.h,
      childAspectRatio: 0.7,
      children: tiles,
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
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return _tileFrame(
      child: Container(
        color: _fixedTileGrey,
        child: Center(
          child: Container(
            width: 70.w,
            height: 70.w,
            decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle),
            child: Icon(Icons.file_upload_outlined, color: Colors.black, size: 46.w),
          ),
        ),
      ),
    );
  }

  Widget _photoTile({required bool play}) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return _tileFrame(
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          if (play) Container(color: _fixedTileGrey),
          Image.asset(AppImages.photo, fit:BoxFit.cover),
          if (play) Container(color: colorScheme.scrim.withOpacity(0.25)),
          if (play)
            Center(
              child: CircleAvatar(
                radius: 26.r,
                backgroundColor: colorScheme.surface,
                child: Icon(Icons.play_arrow_rounded, color: colorScheme.onSurface, size: 34.w),
              ),
            ),
        ],
      ),
    );
  }

  Widget _audioTile({required bool selected}) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final TextTheme textTheme = Theme.of(context).textTheme;
    return _tileFrame(
      child: Container(
        color: _fixedTileGrey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              radius: 34.r,
              backgroundColor: Colors.white,
              child: Icon(
                Icons.volume_up_rounded,
                color: Colors.black,
                size: 38.w,
              ),
            ),
            SizedBox(height: 10.h),
            Text(
              '10 Oct 2025',
              style: textTheme.titleSmall?.copyWith(
                fontSize: 20.sp,
                color: colorScheme.onSecondaryContainer,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _drawingTile() {
    return _tileFrame(
      child: Container(
        color: _fixedTileGrey,
        child: Padding(
          padding: EdgeInsets.all(14.w),
          child: Image.asset(AppImages.drawing, height:20,width:20),
        ),
      ),
    );
  }

  Widget _albumTile(String title) {
    return _tileFrame(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(10.w, 8.h, 10.w, 6.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 3.h),
                  decoration: BoxDecoration(
                    color: const Color(0xFF71D2F8),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 11.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(height: 3.h),
                Text('Album Name', style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w500)),
                Text('Write Here', style: TextStyle(fontSize: 11.sp, color: Colors.black54)),
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
    return _tileFrame(
      child: Container(
        color: _fixedTileGrey,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(icon, size: 36.w, color: Colors.black54),
              SizedBox(height: 8.h),
              Text(label, style: TextStyle(fontSize: 14.sp, color: Colors.black87)),
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
