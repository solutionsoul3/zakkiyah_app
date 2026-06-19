import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zakkiyah_app/Routes/routes.dart';
import 'package:zakkiyah_app/widgets/app_menu_drawer.dart';
import 'package:zakkiyah_app/widgets/app_screen_header.dart';
import 'package:zakkiyah_app/widgets/responsive_frame.dart';

enum EditorType { folder, card }
enum EditorMode { communication, recording, video, web }

class EditorScreen extends StatefulWidget {
  const EditorScreen({super.key});

  @override
  State<EditorScreen> createState() => _EditorScreenState();
}

class _EditorScreenState extends State<EditorScreen> {
  EditorType _selectedType = EditorType.card;
  EditorMode _selectedMode = EditorMode.communication;

  bool get _isDark => Theme.of(context).brightness == Brightness.dark;

  Color get _containerColor => _isDark ? Colors.black : Colors.white;

  Color get _textColor => _isDark ? Colors.white : Colors.black;

  Color get _mutedTextColor => _isDark ? Colors.white70 : Colors.black87;

  Color get _fieldColor => _isDark ? const Color(0xFF1A1A1A) : const Color(0xFFF3F3F3);

  Color get _pageBg => _isDark ? const Color(0xFF121212) : const Color(0xFFF4F4F4);

  Color get _previewBg => _isDark ? const Color(0xFF1A1A1A) : const Color(0xFFEDEDED);

  bool get _isLandscape =>
      MediaQuery.of(context).orientation == Orientation.landscape;

  double get _sectionFontSize => _isLandscape ? 13.sp : 16.sp;

  double get _cardPadding => _isLandscape ? 8.w : 12.w;

  void _goHome() {
    Get.offAllNamed(AppRoutes.home);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _pageBg,
      endDrawer: const AppMenuDrawer(),
      body: SafeArea(
        child: ResponsiveFrame(
          tabletMaxWidth: 1200,
          child: Column(
            children: <Widget>[
              AppScreenHeader(
                topBarHeight: _isLandscape ? 48 : 64,
                topBarPadding: EdgeInsets.symmetric(horizontal: 10.w),
                greetingText: 'Good Morning Zakkiyah',
                titleContent: AppHeaderTitle(
                  onHomeTap: _goHome,
                  fontSize: _isLandscape ? 16.sp : 20.sp,
                  segments: const <AppHeaderSegment>[
                    AppHeaderSegment(
                      label: 'Editor',
                      icon: Icons.edit_note_outlined,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  color: _pageBg,
                  padding: EdgeInsets.all(_isLandscape ? 8.w : 12.w),
                  child: LayoutBuilder(
                    builder: (_, BoxConstraints constraints) {
                      final bool sideBySide =
                          constraints.maxWidth >= 600 || _isLandscape;

                      if (_isLandscape) {
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Expanded(
                              flex: 3,
                              child: Column(
                                children: <Widget>[
                                  Expanded(child: _formCard()),
                                  SizedBox(height: 8.h),
                                  _bottomCard(compact: true),
                                ],
                              ),
                            ),
                            SizedBox(width: 8.w),
                            Expanded(flex: 2, child: _previewCard(maxHeight: constraints.maxHeight, expandPreview: true)),
                          ],
                        );
                      }

                      if (!sideBySide) {
                        return SingleChildScrollView(
                          child: Column(
                            children: <Widget>[
                              _formCard(),
                              SizedBox(height: 12.h),
                              _previewCard(),
                              SizedBox(height: 12.h),
                              _bottomCard(),
                            ],
                          ),
                        );
                      }

                      return Column(
                        children: <Widget>[
                          Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                Expanded(flex: 2, child: _formCard()),
                                SizedBox(width: 12.w),
                                Expanded(child: _previewCard(maxHeight: constraints.maxHeight, expandPreview: true)),
                              ],
                            ),
                          ),
                          SizedBox(height: 10.h),
                          _bottomCard(),
                        ],
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

  Widget _card({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(_cardPadding),
      decoration: BoxDecoration(
        color: _containerColor,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(
          color: _isDark ? Colors.white24 : Colors.black12,
        ),
      ),
      child: DefaultTextStyle(
        style: TextStyle(color: _textColor, fontSize: 14.sp),
        child: IconTheme(
          data: IconThemeData(color: _textColor),
          child: child,
        ),
      ),
    );
  }

  Widget _sectionLabel(String text) {
    return Text(
      text,
      style: TextStyle(fontSize: _sectionFontSize, color: _textColor),
    );
  }

  Widget _formCard() {
    return _card(
      child: SingleChildScrollView(
        physics: _isLandscape ? const NeverScrollableScrollPhysics() : const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _sectionLabel('Select The Type'),
            _radioRowType(),
            SizedBox(height: _isLandscape ? 4.h : 8.h),
            _sectionLabel('Select The Mode'),
            _radioRowMode(),
            SizedBox(height: _isLandscape ? 4.h : 8.h),
            _sectionLabel('Card Name'),
            SizedBox(height: 4.h),
            Container(
              height: (_isLandscape ? 30 : 38).h,
              decoration: BoxDecoration(
                color: _fieldColor,
                borderRadius: BorderRadius.circular(4.r),
                border: Border.all(
                  color: _isDark ? Colors.white24 : Colors.black12,
                ),
              ),
            ),
            SizedBox(height: _isLandscape ? 6.h : 12.h),
            _sectionLabel(
              _selectedMode == EditorMode.recording ? 'Record A Voice' : 'Spoken Message',
            ),
            SizedBox(height: 4.h),
            if (_selectedMode == EditorMode.recording)
              _recordingRow()
            else
              Container(
                height: (_isLandscape ? 52 : 80).h,
                decoration: BoxDecoration(
                  color: _fieldColor,
                  borderRadius: BorderRadius.circular(4.r),
                  border: Border.all(
                    color: _isDark ? Colors.white24 : Colors.black12,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _radioRowType() {
    return Wrap(
      spacing: 4.w,
      children: <Widget>[
        Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Radio<EditorType>(
              visualDensity: _isLandscape ? VisualDensity.compact : VisualDensity.standard,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              value: EditorType.folder,
              groupValue: _selectedType,
              onChanged: (EditorType? v) => setState(() => _selectedType = v ?? EditorType.folder),
            ),
            Text('Folder', style: TextStyle(color: _textColor, fontSize: _sectionFontSize)),
          ],
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Radio<EditorType>(
              visualDensity: _isLandscape ? VisualDensity.compact : VisualDensity.standard,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              value: EditorType.card,
              groupValue: _selectedType,
              onChanged: (EditorType? v) => setState(() => _selectedType = v ?? EditorType.card),
            ),
            Text('Card', style: TextStyle(color: _textColor, fontSize: _sectionFontSize)),
          ],
        ),
      ],
    );
  }

  Widget _radioRowMode() {
    Widget mode(EditorMode m, String t) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Radio<EditorMode>(
            visualDensity: _isLandscape ? VisualDensity.compact : VisualDensity.standard,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            value: m,
            groupValue: _selectedMode,
            onChanged: (EditorMode? v) =>
                setState(() => _selectedMode = v ?? EditorMode.communication),
          ),
          Text(t, style: TextStyle(color: _textColor, fontSize: _sectionFontSize)),
        ],
      );
    }

    return Wrap(
      spacing: _isLandscape ? 6.w : 12.w,
      runSpacing: 2.h,
      children: <Widget>[
        mode(EditorMode.communication, 'Communication'),
        mode(EditorMode.recording, 'Recording'),
        mode(EditorMode.video, 'Video'),
        mode(EditorMode.web, 'Web'),
      ],
    );
  }

  Widget _recordingRow() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: (_isLandscape ? 6 : 10).w,
        vertical: (_isLandscape ? 4 : 8).h,
      ),
      decoration: BoxDecoration(
        color: _fieldColor,
        borderRadius: BorderRadius.circular(4.r),
        border: Border.all(
          color: _isDark ? Colors.white24 : Colors.black12,
        ),
      ),
      child: Row(
        children: <Widget>[
          const Icon(Icons.mic, color: Colors.orange),
          SizedBox(width: 8.w),
          Expanded(
            child: Slider(
              value: 0.25,
              activeColor: const Color(0xFF66D5FD),
              onChanged: (_) {},
            ),
          ),
          SizedBox(width: 8.w),
          OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              foregroundColor: _textColor,
              padding: _isLandscape
                  ? EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h)
                  : null,
              minimumSize: _isLandscape ? Size(48.w, 28.h) : null,
              side: BorderSide(color: _isDark ? Colors.white38 : Colors.black26),
            ),
            child: Text('Play', style: TextStyle(fontSize: _isLandscape ? 11.sp : 14.sp)),
          ),
        ],
      ),
    );
  }

  Widget _previewCard({double? maxHeight, bool expandPreview = false}) {
    final double previewHeight = maxHeight != null && _isLandscape
        ? (maxHeight * 0.72).clamp(80.h, 140.h)
        : (_isLandscape ? 110.h : 150.h);
    final double previewWidth = _isLandscape ? 100.w : 130.w;

    final Widget previewBox = Container(
      width: previewWidth,
      height: expandPreview ? null : previewHeight,
      constraints: BoxConstraints(
        maxHeight: previewHeight,
        minHeight: (_isLandscape ? 80 : 120).h,
      ),
      decoration: BoxDecoration(
        color: _previewBg,
        borderRadius: BorderRadius.circular(4.r),
        border: Border.all(
          color: _isDark ? Colors.white24 : Colors.black12,
        ),
      ),
      child: Icon(
        Icons.image,
        color: _mutedTextColor,
        size: (_isLandscape ? 30 : 42).w,
      ),
    );

    return _card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              _sectionLabel('Card Preview'),
              const Spacer(),
              CircleAvatar(
                radius: (_isLandscape ? 10 : 12).r,
                backgroundColor: _isDark ? Colors.white : Colors.black,
                child: Icon(
                  Icons.edit,
                  color: _isDark ? Colors.black : Colors.white,
                  size: (_isLandscape ? 12 : 14).w,
                ),
              ),
            ],
          ),
          SizedBox(height: (_isLandscape ? 6 : 10).h),
          if (expandPreview)
            Expanded(child: Center(child: previewBox))
          else
            Center(child: previewBox),
        ],
      ),
    );
  }

  Widget _bottomCard({bool compact = false}) {
    final double chipSize = compact || _isLandscape ? 11.sp : 14.sp;

    return _card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          _sectionLabel('Card Image'),
          SizedBox(height: compact ? 4.h : 8.h),
          Wrap(
            spacing: compact ? 6.w : 10.w,
            runSpacing: compact ? 4.h : 8.h,
            children: <Widget>[
              _ActionChip(
                icon: Icons.photo_library_outlined,
                text: 'Select image',
                textColor: _textColor,
                borderColor: _isDark ? Colors.white38 : Colors.black26,
                fontSize: chipSize,
                compact: compact || _isLandscape,
              ),
              _ActionChip(
                icon: Icons.image_search_outlined,
                text: 'Choose From',
                textColor: _textColor,
                borderColor: _isDark ? Colors.white38 : Colors.black26,
                fontSize: chipSize,
                compact: compact || _isLandscape,
              ),
              _ActionChip(
                icon: Icons.camera_alt_outlined,
                text: 'Take Photo',
                textColor: _textColor,
                borderColor: _isDark ? Colors.white38 : Colors.black26,
                fontSize: chipSize,
                compact: compact || _isLandscape,
              ),
              _ActionChip(
                icon: Icons.language_outlined,
                text: 'Web image',
                textColor: _textColor,
                borderColor: _isDark ? Colors.white38 : Colors.black26,
                fontSize: chipSize,
                compact: compact || _isLandscape,
              ),
            ],
          ),
          SizedBox(height: compact ? 6.h : 12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              OutlinedButton.icon(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.pinkAccent,
                  padding: compact
                      ? EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h)
                      : null,
                  minimumSize: compact ? Size(64.w, 28.h) : null,
                  side: BorderSide(color: _isDark ? Colors.white38 : Colors.black26),
                ),
                icon: Icon(Icons.close, color: Colors.pinkAccent, size: compact ? 14.w : 16.w),
                label: Text('Close', style: TextStyle(fontSize: chipSize)),
              ),
              SizedBox(width: compact ? 6.w : 10.w),
              FilledButton.icon(
                style: FilledButton.styleFrom(
                  backgroundColor: const Color(0xFF66D5FD),
                  foregroundColor: Colors.black,
                  padding: compact
                      ? EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h)
                      : null,
                  minimumSize: compact ? Size(64.w, 28.h) : null,
                ),
                onPressed: () {},
                icon: Icon(Icons.check, size: compact ? 14.w : 16.w),
                label: Text('Save', style: TextStyle(fontSize: chipSize)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ActionChip extends StatelessWidget {
  const _ActionChip({
    required this.icon,
    required this.text,
    required this.textColor,
    required this.borderColor,
    this.fontSize,
    this.compact = false,
  });

  final IconData icon;
  final String text;
  final Color textColor;
  final Color borderColor;
  final double? fontSize;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final double size = fontSize ?? 14.sp;
    return OutlinedButton.icon(
      onPressed: () {},
      style: OutlinedButton.styleFrom(
        foregroundColor: textColor,
        padding: compact ? EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h) : null,
        minimumSize: compact ? Size(72.w, 28.h) : null,
        side: BorderSide(color: borderColor),
      ),
      icon: Icon(icon, size: compact ? 14.w : 16.w, color: textColor),
      label: Text(text, style: TextStyle(color: textColor, fontSize: size)),
    );
  }
}
