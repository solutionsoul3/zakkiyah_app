import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:zakkiyah_app/widgets/app_menu_drawer.dart';
import 'package:zakkiyah_app/widgets/app_screen_header.dart';
import 'package:zakkiyah_app/widgets/responsive_frame.dart';

class DrawScreen extends StatefulWidget {
  const DrawScreen({super.key});

  @override
  State<DrawScreen> createState() => _DrawScreenState();
}

class _DrawScreenState extends State<DrawScreen> {
  final ImagePicker _imagePicker = ImagePicker();
  final List<_Stroke> _strokes = <_Stroke>[];
  List<_Stroke> _savedStrokes = <_Stroke>[];
  File? _backgroundImage;
  File? _savedBackgroundImage;
  Color _selectedColor = Colors.black;
  bool _eraserMode = false;
  double _strokeWidth = 5;
  int? _expandedShadeIndex;

  static const List<_PaletteEntry> _palette = <_PaletteEntry>[
    _PaletteEntry(
      Colors.black,
      shades: <Color>[
        Color(0xFF000000),
        Color(0xFF424242),
        Color(0xFF757575),
        Color(0xFFB5B5B5),
      ],
    ),
    _PaletteEntry(
      Color(0xFFB6003F),
      shades: <Color>[
        Color(0xFF5C001F),
        Color(0xFFB6003F),
        Color(0xFFFF1224),
        Color(0xFFEC95A3),
      ],
    ),
    _PaletteEntry(
      Color(0xFFFF8500),
      shades: <Color>[
        Color(0xFF994F00),
        Color(0xFFFF8500),
        Color(0xFFFFB04D),
        Color(0xFFFFD9A3),
      ],
    ),
    _PaletteEntry(
      Color(0xFFF5E80F),
      shades: <Color>[
        Color(0xFF8A8500),
        Color(0xFFF5E80F),
        Color(0xFFFFF44D),
        Color(0xFFFFF9A3),
      ],
    ),
    _PaletteEntry(
      Color(0xFF9EE11A),
      shades: <Color>[
        Color(0xFF4E7000),
        Color(0xFF9EE11A),
        Color(0xFFB8F04D),
        Color(0xFFD4F9A3),
      ],
    ),
    _PaletteEntry(
      Color(0xFF1DA6D2),
      shades: <Color>[
        Color(0xFF0E5A73),
        Color(0xFF1DA6D2),
        Color(0xFF5CC4E8),
        Color(0xFFA3E0F5),
      ],
    ),
    _PaletteEntry(
      Color(0xFF353FA5),
      shades: <Color>[
        Color(0xFF1A2052),
        Color(0xFF353FA5),
        Color(0xFF5C6AD4),
        Color(0xFFA3ABE8),
      ],
    ),
    _PaletteEntry(
      Color(0xFF6C3292),
      shades: <Color>[
        Color(0xFF361849),
        Color(0xFF6C3292),
        Color(0xFF9B5CC4),
        Color(0xFFD4A3E8),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      endDrawer: const AppMenuDrawer(),
      body: SafeArea(
        child: ResponsiveFrame(
          tabletMaxWidth: 1300,
          child: Column(
            children: <Widget>[
              AppScreenHeader(
                topBarHeight: 58,
                topBarPadding: EdgeInsets.symmetric(horizontal: 10.w),
                greetingText: 'Good Morning Zakkiyah',
                titleContent: const AppHeaderTitle(
                  segments: <AppHeaderSegment>[
                    AppHeaderSegment(
                      label: 'Draw',
                      icon: Icons.brush,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    _leftToolsPanel(isLandscape: isLandscape),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          _actionRow(isLandscape: isLandscape),
                          if (_expandedShadeIndex != null)
                            _shadeBar(isLandscape: isLandscape),
                          Expanded(child: _drawingCanvas()),
                        ],
                      ),
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

  Widget _leftToolsPanel({required bool isLandscape}) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final double dotSize = (isLandscape ? 28 : 34).w;
    return Container(
      width: (isLandscape ? 72 : 84).w,
      margin: EdgeInsets.only(left: 8.w, bottom: 8.h),
      padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 6.w),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF2A2A2A) : const Color(0xFFD9D9D9),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            ...List<Widget>.generate(_palette.length, (int index) {
              final _PaletteEntry entry = _palette[index];
              final bool familySelected = !_eraserMode &&
                  (entry.color == _selectedColor || entry.shades.contains(_selectedColor));
              final bool expanded = _expandedShadeIndex == index;

              return Padding(
                padding: EdgeInsets.only(bottom: 8.h),
                child: _colorDot(
                  entry.color,
                  size: dotSize,
                  selected: familySelected,
                  onTap: () {
                    setState(() {
                      _expandedShadeIndex = expanded ? null : index;
                      _selectedColor = entry.color;
                      _eraserMode = false;
                      _strokeWidth = 5;
                    });
                  },
                ),
              );
            }),
            SizedBox(height: 8.h),
            Divider(height: 1, color: isDark ? Colors.white24 : Colors.black26),
            SizedBox(height: 8.h),
            _toolCircle(
              icon: Icons.pan_tool_alt_outlined,
              selected: !_eraserMode,
              onTap: () => setState(() {
                _eraserMode = false;
                _expandedShadeIndex = null;
              }),
              isLandscape: isLandscape,
            ),
            SizedBox(height: 8.h),
            _toolCircle(
              icon: Icons.edit,
              selected: !_eraserMode,
              onTap: () => setState(() {
                _eraserMode = false;
                _strokeWidth = 5;
              }),
              isLandscape: isLandscape,
            ),
            SizedBox(height: 8.h),
            _toolCircle(
              icon: Icons.auto_fix_normal,
              selected: _eraserMode,
              onTap: () => setState(() {
                _eraserMode = true;
                _strokeWidth = 18;
                _expandedShadeIndex = null;
              }),
              isLandscape: isLandscape,
            ),
            SizedBox(height: 8.h),
            _toolCircle(icon: Icons.undo, onTap: _undoStroke, isLandscape: isLandscape),
            SizedBox(height: 8.h),
            _toolCircle(icon: Icons.clear, onTap: _clearAll, isLandscape: isLandscape),
          ],
        ),
      ),
    );
  }

  Widget _shadeBar({required bool isLandscape}) {
    final int? index = _expandedShadeIndex;
    if (index == null || index < 0 || index >= _palette.length) {
      return const SizedBox.shrink();
    }

    final _PaletteEntry entry = _palette[index];
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final double dotSize = (isLandscape ? 36 : 44).w;

    return Container(
      margin: EdgeInsets.fromLTRB(8.w, 0, 8.w, 8.h),
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF2A2A2A) : const Color(0xFFE8E8E8),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: <Widget>[
          Text(
            'Shades',
            style: TextStyle(
              fontSize: (isLandscape ? 12 : 14).sp,
              fontWeight: FontWeight.w600,
              color: isDark ? Colors.white70 : Colors.black54,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: entry.shades.map((Color shade) {
                  return Padding(
                    padding: EdgeInsets.only(right: 10.w),
                    child: _colorDot(
                      shade,
                      size: dotSize,
                      selected: !_eraserMode && _selectedColor == shade,
                      onTap: () {
                        setState(() {
                          _selectedColor = shade;
                          _eraserMode = false;
                          _strokeWidth = 5;
                        });
                      },
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          IconButton(
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
            onPressed: () => setState(() => _expandedShadeIndex = null),
            icon: Icon(
              Icons.close,
              size: 18.w,
              color: isDark ? Colors.white54 : Colors.black45,
            ),
          ),
        ],
      ),
    );
  }

  Widget _colorDot(
    Color color, {
    required double size,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
          border: Border.all(
            color: selected ? Colors.white : Colors.transparent,
            width: 3,
          ),
          boxShadow: selected
              ? <BoxShadow>[
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.25),
                    blurRadius: 4,
                  ),
                ]
              : null,
        ),
      ),
    );
  }

  Widget _toolCircle({
    required IconData icon,
    required VoidCallback onTap,
    bool selected = false,
    required bool isLandscape,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: (isLandscape ? 32 : 42).w,
        height: (isLandscape ? 32 : 42).w,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          border: Border.all(
            color: selected ? Colors.blueAccent : Colors.transparent,
            width: 2,
          ),
        ),
        child: Icon(icon, color: Colors.black87, size: (isLandscape ? 17 : 25).w),
      ),
    );
  }

  Widget _actionRow({required bool isLandscape}) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final double screenHeight = MediaQuery.sizeOf(context).height;
    // Use percentage of screen height with larger range
    final double actionRowHeight = (screenHeight * 0.17).clamp(100.0, 140.0);
    
    return Container(
      height: actionRowHeight,
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0), // Reduced vertical padding
      color: isDark ? const Color(0xFF1B1B1B) : const Color(0xFFD3D3D3),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          SizedBox(
            height: actionRowHeight * 0.46, // Reduced from 0.48 to 0.46
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                _actionChip(
                  icon: Icons.add,
                  text: 'Add Image',
                  onTap: _addImage,
                  isLandscape: isLandscape,
                ),
                const SizedBox(width: 8.0),
                _actionChip(
                  icon: Icons.edit_outlined,
                  text: 'Edit Image',
                  onTap: _editImage,
                  isLandscape: isLandscape,
                ),
                const SizedBox(width: 8.0),
                _actionChip(
                  icon: Icons.delete_outline,
                  text: 'Remove Image',
                  onTap: _removeImage,
                  isLandscape: isLandscape,
                ),
              ],
            ),
          ),
          SizedBox(
            height: actionRowHeight * 0.40, // Reduced from 0.42 to 0.40
            child: Row(
              children: <Widget>[
                const Spacer(),
                _textAction(
                  icon: Icons.close,
                  text: 'Close',
                  color: const Color(0xFFFF3360),
                  onTap: _cancelChanges,
                  isLandscape: isLandscape,
                ),
                const SizedBox(width: 8.0),
                _textAction(
                  icon: Icons.check,
                  text: 'Save',
                  color: const Color(0xFF66C8F6),
                  onTap: _saveChanges,
                  isLandscape: isLandscape,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _actionChip({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
    required bool isLandscape,
  }) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final double screenWidth = MediaQuery.sizeOf(context).width;
    // Responsive sizing based on screen width
    final double iconSize = (screenWidth * 0.022).clamp(16.0, 22.0);
    final double textSize = (screenWidth * 0.018).clamp(13.0, 16.0);
    final double horizontalPadding = (screenWidth * 0.015).clamp(10.0, 14.0);
    final double verticalPadding = (screenWidth * 0.014).clamp(10.0, 14.0); // Increased padding
    
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8.0),
      child: Container(
        constraints: BoxConstraints(
          minWidth: (screenWidth * 0.15).clamp(100.0, 130.0),
          minHeight: (screenWidth * 0.10).clamp(40.0, 50.0), // Added minimum height
        ),
        padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding,
          vertical: verticalPadding,
        ),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF2A2A2A) : const Color(0xFFEDEDED),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              icon,
              size: iconSize,
              color: isDark ? Colors.white : Colors.black54,
            ),
            const SizedBox(width: 6.0),
            Flexible(
              child: Text(
                text,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: textSize,
                  color: isDark ? Colors.white : Colors.black,
                  height: 1.3, // Added proper line height
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _textAction({
    required IconData icon,
    required String text,
    required Color color,
    required VoidCallback onTap,
    required bool isLandscape,
  }) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final double screenWidth = MediaQuery.sizeOf(context).width;
    // Responsive sizing based on screen width
    final double iconSize = (screenWidth * 0.024).clamp(18.0, 24.0);
    final double textSize = (screenWidth * 0.020).clamp(14.0, 18.0);
    final double horizontalPadding = (screenWidth * 0.015).clamp(10.0, 14.0);
    final double verticalPadding = (screenWidth * 0.014).clamp(10.0, 14.0); // Increased padding
    
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8.0),
      child: Container(
        constraints: BoxConstraints(
          minWidth: (screenWidth * 0.13).clamp(90.0, 110.0),
          minHeight: (screenWidth * 0.10).clamp(40.0, 50.0), // Added minimum height
        ),
        padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding,
          vertical: verticalPadding,
        ),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF2A2A2A) : Colors.white,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(icon, color: color, size: iconSize),
            const SizedBox(width: 6.0),
            Flexible(
              child: Text(
                text,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: textSize,
                  color: color,
                  height: 1.3, // Added proper line height
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _drawingCanvas() {
    return Container(
      margin: EdgeInsets.all(8.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14.r),
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return GestureDetector(
              onPanStart: (DragStartDetails details) {
                final Offset point = _clampOffset(details.localPosition, constraints.biggest);
                setState(() {
                  _strokes.add(
                    _Stroke(
                      points: <Offset>[point],
                      color: _eraserMode ? Colors.white : _selectedColor,
                      strokeWidth: _strokeWidth,
                    ),
                  );
                });
              },
              onPanUpdate: (DragUpdateDetails details) {
                if (_strokes.isEmpty) return;
                final Offset point = _clampOffset(details.localPosition, constraints.biggest);
                setState(() => _strokes.last.points.add(point));
              },
              child: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  if (_backgroundImage != null)
                    Image.file(
                      _backgroundImage!,
                      fit: BoxFit.contain,
                    ),
                  CustomPaint(
                    painter: _DrawPainter(strokes: _strokes),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Offset _clampOffset(Offset point, Size size) {
    final double dx = point.dx.clamp(0, size.width).toDouble();
    final double dy = point.dy.clamp(0, size.height).toDouble();
    return Offset(dx, dy);
  }

  Future<void> _addImage() async {
    final XFile? file = await _imagePicker.pickImage(source: ImageSource.gallery);
    if (file == null) return;
    setState(() => _backgroundImage = File(file.path));
  }

  Future<void> _editImage() async {
    if (_backgroundImage == null) {
      _showMessage('No image selected. Add image first.');
      return;
    }
    final XFile? file = await _imagePicker.pickImage(source: ImageSource.gallery);
    if (file == null) return;
    setState(() => _backgroundImage = File(file.path));
  }

  void _removeImage() {
    if (_backgroundImage == null) {
      _showMessage('No image to remove.');
      return;
    }
    setState(() => _backgroundImage = null);
  }

  void _undoStroke() {
    if (_strokes.isEmpty) return;
    setState(() => _strokes.removeLast());
  }

  void _clearAll() {
    setState(() => _strokes.clear());
  }

  void _saveChanges() {
    _savedStrokes = _strokes.map((_Stroke stroke) => stroke.copy()).toList();
    _savedBackgroundImage = _backgroundImage;
    _showMessage('Drawing saved.');
  }

  void _cancelChanges() {
    setState(() {
      _strokes
        ..clear()
        ..addAll(_savedStrokes.map((_Stroke stroke) => stroke.copy()));
      _backgroundImage = _savedBackgroundImage;
    });
    _showMessage('Changes canceled.');
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }
}

class _PaletteEntry {
  const _PaletteEntry(this.color, {this.shades = const <Color>[]});

  final Color color;
  final List<Color> shades;
}

class _Stroke {
  _Stroke({
    required this.points,
    required this.color,
    required this.strokeWidth,
  });

  final List<Offset> points;
  final Color color;
  final double strokeWidth;

  _Stroke copy() {
    return _Stroke(
      points: List<Offset>.from(points),
      color: color,
      strokeWidth: strokeWidth,
    );
  }
}

class _DrawPainter extends CustomPainter {
  _DrawPainter({required this.strokes});

  final List<_Stroke> strokes;

  @override
  void paint(Canvas canvas, Size size) {
    for (final _Stroke stroke in strokes) {
      if (stroke.points.length < 2) continue;
      final Paint paint = Paint()
        ..color = stroke.color
        ..strokeWidth = stroke.strokeWidth
        ..strokeCap = StrokeCap.round
        ..style = PaintingStyle.stroke;

      for (int i = 0; i < stroke.points.length - 1; i++) {
        canvas.drawLine(stroke.points[i], stroke.points[i + 1], paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant _DrawPainter oldDelegate) => true;
}
