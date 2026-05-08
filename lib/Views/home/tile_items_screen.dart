import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zakkiyah_app/constants/images/images.dart';
import 'package:zakkiyah_app/widgets/app_menu_drawer.dart';
import 'package:zakkiyah_app/widgets/app_screen_header.dart';
import 'package:zakkiyah_app/widgets/responsive_frame.dart';
import 'package:zakkiyah_app/widgets/voice_tap.dart';

class TileItemsScreen extends StatefulWidget {
  const TileItemsScreen({
    super.key,
    required this.title,
    this.initialItems,
    this.defaultAddImagePath = AppImages.shapes,
    this.breadcrumbTitles,
  });

  final String title;
  final List<TileItemData>? initialItems;
  final String defaultAddImagePath;
  final List<String>? breadcrumbTitles;

  @override
  State<TileItemsScreen> createState() => _TileItemsScreenState();
}

class _TileItemsScreenState extends State<TileItemsScreen> {
  late List<TileItemData> _items;
  final List<List<TileItemData>> _undoStack = <List<TileItemData>>[];
  final List<List<TileItemData>> _redoStack = <List<TileItemData>>[];
  final PageController _pageController = PageController();
  int _currentPage = 0;
  bool _isEditing = false;
  static const int _tilesPerPage = 8;

  @override
  void initState() {
    super.initState();
    _items = widget.initialItems != null
        ? List<TileItemData>.from(widget.initialItems!)
        : List<TileItemData>.generate(
            8,
            (int index) => TileItemData(
              title: '${widget.title} ${index + 1}',
              imagePath: widget.defaultAddImagePath,
            ),
          );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

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
                titleContent: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(children: _buildBreadcrumbs()),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(10.w),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      _leftActionRail(),
                      SizedBox(width: 10.w),
                      Expanded(
                        child: PageView.builder(
                          controller: _pageController,
                          itemCount: _pageItems.length,
                          onPageChanged: (int index) {
                            setState(() => _currentPage = index);
                          },
                          itemBuilder: (_, int pageIndex) {
                            final List<TileItemData> items = _pageItems[pageIndex];
                            return GridView.builder(
                              itemCount: items.length,
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 10.w,
                                mainAxisSpacing: 10.h,
                                childAspectRatio: 0.68,
                              ),
                              itemBuilder: (_, int index) {
                                final int actualIndex = (pageIndex * _tilesPerPage) + index;
                                return _itemCard(items[index], actualIndex);
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

  Widget _itemCard(TileItemData item, int index) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final bool isMediaScreen = widget.title.toLowerCase() == 'media';
    final bool canModifyItem = _isEditing && item.isCustom;
    return VoiceTap(
      announceText: item.title,
      onTap: () async {},
      borderRadius: BorderRadius.circular(14.r),
      child: Container(
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF202020) : const Color(0xFFFAFAFA),
          borderRadius: BorderRadius.circular(14.r),
        ),
        child: Column(
          children: <Widget>[
            if (canModifyItem)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                child: Row(
                  children: <Widget>[
                    _circleAction(
                      color: Colors.red,
                      icon: Icons.delete,
                      announceText: 'Delete ${item.title}',
                      onTap: () => _deleteItem(index),
                    ),
                    const Spacer(),
                    _circleAction(
                      color: Colors.black,
                      icon: Icons.edit,
                      announceText: 'Edit ${item.title}',
                      onTap: () => _editItem(index),
                    ),
                  ],
                ),
              )
            else
              SizedBox(height: 10.h),
            Expanded(
              child: isMediaScreen
                  ? _buildMediaPreview(item.title)
                  : Center(
                      child: Image.asset(
                        item.imagePath ?? AppImages.shapes,
                        width: 120.w,
                        height: 120.h,
                        fit: BoxFit.contain,
                        errorBuilder: (_, __, ___) => Icon(
                          Icons.image_outlined,
                          color: isDark ? Colors.white54 : Colors.black45,
                          size: 34.w,
                        ),
                      ),
                    ),
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 8.h),
              decoration: BoxDecoration(
                color: isMediaScreen
                    ? _mediaLabelBackground(item.title)
                    : (isDark ? const Color(0xFF3C3C3C) : const Color(0xFFF0F0F0)),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(14.r),
                  bottomRight: Radius.circular(14.r),
                ),
              ),
              child: Text(
                item.title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: isMediaScreen
                      ? const Color(0xFF2F3A4A)
                      : (isDark ? Colors.white : Colors.black),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _mediaLabelBackground(String title) {
    switch (title.toLowerCase()) {
      case 'all file':
      case 'download':
      case 'trash':
        return const Color(0xFFEFF4FF);
      case 'albums':
      case 'audio':
        return const Color(0xFFFFF1C9);
      case 'photos':
      case 'videos':
        return const Color(0xFFDCE9FF);
      case 'drawing':
        return const Color(0xFFD6F3FF);
      default:
        return const Color(0xFFF0F0F0);
    }
  }

  Widget _buildMediaPreview(String title) {
    final String key = title.toLowerCase();
    final Color frameColor = key == 'albums' || key == 'audio'
        ? const Color(0xFFFFE7A8)
        : key == 'drawing'
            ? const Color(0xFFCBF0FF)
            : key == 'download' || key == 'trash'
                ? const Color(0xFFF5F7FC)
                : const Color(0xFFDDE9FF);

    final List<Color> dots = key == 'albums' || key == 'audio'
        ? <Color>[const Color(0xFFFFC44D), const Color(0xFFFFD97A), const Color(0xFFFFB43D)]
        : key == 'photos' || key == 'videos'
            ? <Color>[const Color(0xFF8E6755), const Color(0xFFB68A77), const Color(0xFFA57963)]
            : key == 'drawing'
                ? <Color>[const Color(0xFF77C9FF), const Color(0xFFA8E4FF), const Color(0xFF55B6EE)]
                : <Color>[const Color(0xFF6E89A8), const Color(0xFF9FB3C9), const Color(0xFF4C6A89)];

    if (key == 'download' || key == 'trash') {
      return Center(
        child: Container(
          width: 120.w,
          height: 120.h,
          decoration: BoxDecoration(
            color: frameColor,
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Icon(
            key == 'download' ? Icons.download_rounded : Icons.delete_outline_rounded,
            size: 48.w,
            color: key == 'download' ? const Color(0xFF2E7DFF) : const Color(0xFF7B8A9D),
          ),
        ),
      );
    }

    return Center(
      child: Container(
        width: 120.w,
        height: 120.h,
        decoration: BoxDecoration(
          color: frameColor,
          borderRadius: BorderRadius.circular(16.r),
        ),
        padding: EdgeInsets.all(10.w),
        child: Wrap(
          spacing: 8.w,
          runSpacing: 8.h,
          alignment: WrapAlignment.center,
          children: List<Widget>.generate(
            6,
            (int i) => Container(
              width: 28.w,
              height: 28.h,
              decoration: BoxDecoration(
                color: dots[i % dots.length],
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 1.6),
              ),
              child: key == 'videos'
                  ? Icon(Icons.play_arrow_rounded, size: 14.w, color: Colors.white)
                  : null,
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildBreadcrumbs() {
    final List<String> titles = widget.breadcrumbTitles ?? <String>['Home', widget.title];
    return List<Widget>.generate(titles.length, (int index) {
      final bool isActive = index == titles.length - 1;
      final String? imagePath = _breadcrumbAssetForTitle(titles[index]);
      return Padding(
        padding: EdgeInsets.only(right: 10.w),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
          decoration: BoxDecoration(
            color: isActive ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              if (imagePath != null)
                Image.asset(
                  imagePath,
                  width: 18.w,
                  height: 18.w,
                  fit: BoxFit.contain,
                  errorBuilder: (_, __, ___) => Icon(
                    Icons.label_outline,
                    color: isActive ? Colors.black : Colors.white,
                    size: 18.w,
                  ),
                )
              else
                Icon(
                  Icons.label_outline,
                  color: isActive ? Colors.black : Colors.white,
                  size: 18.w,
                ),
              SizedBox(width: 6.w),
              Text(
                titles[index],
                style: TextStyle(
                  color: isActive ? Colors.black : Colors.white,
                  fontSize: 20.sp,
                  fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  String? _breadcrumbAssetForTitle(String title) {
    switch (title.toLowerCase()) {
      case 'home':
        return AppImages.homeAvatar;
      case 'talk':
        return AppImages.talk;
      case 'schedule':
        return AppImages.schedule;
      case 'type':
        return AppImages.type;
      case 'media':
        return AppImages.media;
      case 'therapy':
        return AppImages.therapy;
      case 'draw':
        return AppImages.draw;
      case 'learn':
        return AppImages.learn;
      case 'read':
        return AppImages.read;
      case 'shapes':
        return AppImages.shapes;
      case 'daily routine':
        return AppImages.dailyRoutine;
      case 'alphabet':
        return AppImages.alphabet;
      case 'numbers':
        return AppImages.numbers;
      case 'colors':
        return AppImages.colors;
      case 'sign language':
        return AppImages.signLanguage;
      case 'feelings':
        return AppImages.feelings;
      case 'important':
        return AppImages.important;
      case 'conversational phrases':
        return AppImages.conversationalPhrases;
      case 'daily activities':
        return AppImages.dailyActivities;
      case 'icu communication':
        return AppImages.kidConversation;
      case 'emergency response':
        return AppImages.emergencyResponse;
      case 'simple communication':
        return AppImages.simpleCommunication;
      case 'mental health':
        return AppImages.mentalHealth;
      case 'pain scale':
        return AppImages.planSchedule;
      case 'animal':
        return AppImages.animal;
      case 'fruits':
        return AppImages.fruits;
      case 'vegetable':
        return AppImages.vegetable;
      case 'seasons':
        return AppImages.seasons;
      case 'weather':
        return AppImages.weatherSunny;
      case 'months':
        return AppImages.month;
      case 'body parts':
        return AppImages.bodyparts;
      case 'sports':
        return AppImages.sports;
      case 'birds':
        return AppImages.birds;
      case 'jobs':
        return AppImages.jobs;
      case 'sentences':
        return AppImages.sentences;
      case 'snacks':
        return AppImages.snacks;
      case 'drinks':
        return AppImages.drink;
      case 'breakfast':
        return AppImages.breakfast;
      case 'lunch':
        return AppImages.lunch;
      case 'dinner':
        return AppImages.dinner;
      case 'restraunt':
        return AppImages.restraunt;
      case 'myslef':
        return AppImages.myself;
      case 'friends':
        return AppImages.friends;
      case 'family member':
        return AppImages.familymember;
      case 'school':
        return AppImages.school;
      case 'education':
        return AppImages.education;
      default:
        return null;
    }
  }

  Widget _circleAction({
    required Color color,
    required IconData icon,
    required String announceText,
    required VoidCallback onTap,
  }) {
    return VoiceTap(
      announceText: announceText,
      onTap: () async => onTap(),
      borderRadius: BorderRadius.circular(999.r),
      child: CircleAvatar(
        radius: 12.r,
        backgroundColor: color,
        child: Icon(icon, color: Colors.white, size: 14.w),
      ),
    );
  }

  Widget _leftActionRail() {
    final bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      width: (isLandscape ? 78 : 92).w,
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1A1A1A) : const Color(0xFFE3E3E3),
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(height: 8.h),
            _railIcon(
              icon: Icons.arrow_back,
              label: 'Back',
              announceText: 'Back',
              onTap: () => Navigator.pop(context),
            ),
            SizedBox(height: 8.h),
            _railIcon(
              icon: Icons.add_box_outlined,
              label: 'Add',
              announceText: 'Add item',
              onTap: _isEditing ? _addNew : () {},
            ),
            SizedBox(height: 8.h),
            _railIcon(
              icon: _isEditing ? Icons.check_circle_outline : Icons.edit_note_outlined,
              label: _isEditing ? 'Done' : 'Edit',
              announceText: _isEditing ? 'Done editing' : 'Edit mode',
              onTap: _toggleEditMode,
            ),
            SizedBox(height: 20.h),
            _railIcon(
              icon: Icons.undo,
              label: 'Undo',
              announceText: 'Undo',
              onTap: _isEditing && _undoStack.isNotEmpty ? _undo : () {},
            ),
            SizedBox(height: 20.h),
            _railIcon(
              icon: Icons.redo,
              label: 'Redo',
              announceText: 'Redo',
              onTap: _isEditing && _redoStack.isNotEmpty ? _redo : () {},
            ),
            SizedBox(height: 12.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                VoiceTap(
                  announceText: 'Previous page',
                  enabled: _currentPage > 0,
                  onTap: () async => _pageController.previousPage(
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.easeInOut,
                  ),
                  child: Icon(
                    Icons.chevron_left,
                    size: (isLandscape ? 16 : 20).w,
                    color: _currentPage > 0 ? Colors.black54 : Colors.black26,
                  ),
                ),
                SizedBox(width: 6.w),
                Text(
                  '${_currentPage + 1}/${_pageItems.length}',
                  style: TextStyle(
                    fontSize: (isLandscape ? 12 : 14).sp,
                    color: isDark ? Colors.white : Colors.black,
                  ),
                ),
                SizedBox(width: 6.w),
                VoiceTap(
                  announceText: 'Next page',
                  enabled: _currentPage < _pageItems.length - 1,
                  onTap: () async => _pageController.nextPage(
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.easeInOut,
                  ),
                  child: Icon(
                    Icons.chevron_right,
                    size: (isLandscape ? 16 : 20).w,
                    color: _currentPage < _pageItems.length - 1
                        ? Colors.black54
                        : Colors.black26,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.h),
          ],
        ),
      ),
    );
  }

  Widget _railIcon({
    required IconData icon,
    required String label,
    required String announceText,
    required VoidCallback onTap,
  }) {
    final bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return VoiceTap(
      announceText: announceText,
      onTap: () async => onTap(),
      borderRadius: BorderRadius.circular(8.r),
      child: Container(
        width: (isLandscape ? 54 : 64).w,
        padding: EdgeInsets.symmetric(vertical: (isLandscape ? 6 : 8).h),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF2A2A2A) : const Color(0xFFF2F2F2),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Column(
          children: <Widget>[
            Icon(icon, size: (isLandscape ? 18 : 22).w, color: isDark ? Colors.white70 : Colors.black54),
            SizedBox(height: 2.h),
            Text(
              label,
              style: TextStyle(
                fontSize: (isLandscape ? 9 : 10).sp,
                color: isDark ? Colors.white : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _captureStateForUndo() {
    _undoStack.add(List<TileItemData>.from(_items));
    _redoStack.clear();
  }

  List<List<TileItemData>> get _pageItems {
    if (_items.isEmpty) {
      return <List<TileItemData>>[<TileItemData>[]];
    }
    final List<List<TileItemData>> pages = <List<TileItemData>>[];
    for (int i = 0; i < _items.length; i += _tilesPerPage) {
      pages.add(
        _items.sublist(
          i,
          (i + _tilesPerPage > _items.length) ? _items.length : i + _tilesPerPage,
        ),
      );
    }
    return pages;
  }

  void _deleteItem(int index) {
    if (!_isEditing || !_items[index].isCustom) return;
    _captureStateForUndo();
    setState(() => _items.removeAt(index));
  }

  void _addNew() {
    if (!_isEditing) return;
    _captureStateForUndo();
    setState(() {
      _items.add(
        TileItemData(
          title: 'New Item',
          imagePath: widget.defaultAddImagePath,
          isCustom: true,
        ),
      );
    });
  }

  Future<void> _editItem(int index) async {
    if (!_isEditing || !_items[index].isCustom) return;
    final TextEditingController controller = TextEditingController(text: _items[index].title);
    final String? updated = await showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Edit Item'),
        content: TextField(controller: controller),
        actions: <Widget>[
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          FilledButton(
            onPressed: () => Navigator.pop(context, controller.text.trim()),
            child: const Text('Save'),
          ),
        ],
      ),
    );
    if (updated == null || updated.isEmpty) return;
    _captureStateForUndo();
    setState(() => _items[index] = _items[index].copyWith(title: updated));
  }

  void _undo() {
    if (!_isEditing) return;
    if (_undoStack.isEmpty) return;
    _redoStack.add(List<TileItemData>.from(_items));
    setState(() => _items = _undoStack.removeLast());
  }

  void _redo() {
    if (!_isEditing) return;
    if (_redoStack.isEmpty) return;
    _undoStack.add(List<TileItemData>.from(_items));
    setState(() => _items = _redoStack.removeLast());
  }

  void _toggleEditMode() {
    setState(() => _isEditing = !_isEditing);
  }
}

class TileItemData {
  const TileItemData({
    required this.title,
    required this.imagePath,
    this.isCustom = false,
  });

  final String title;
  final String? imagePath;
  final bool isCustom;

  TileItemData copyWith({String? title, String? imagePath, bool? isCustom}) {
    return TileItemData(
      title: title ?? this.title,
      imagePath: imagePath ?? this.imagePath,
      isCustom: isCustom ?? this.isCustom,
    );
  }
}
