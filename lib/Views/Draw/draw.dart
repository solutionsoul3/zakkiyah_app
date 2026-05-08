import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:zakkiyah_app/widgets/app_menu_drawer.dart';
import 'package:zakkiyah_app/widgets/menu_drawer_button.dart';
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

  static const List<Color> _palette = <Color>[
    Colors.black,
    Color(0xFFB5B5B5),
    Color(0xFFB6003F),
    Color(0xFFFF1224),
    Color(0xFFEC95A3),
    Color(0xFFFF8500),
    Color(0xFFF5E80F),
    Color(0xFF9EE11A),
    Color(0xFF1DA6D2),
    Color(0xFF353FA5),
    Color(0xFF6C3292),
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
              _topBar(),
              Expanded(
                child: Column(
                  children: <Widget>[
                    _actionRow(isLandscape: isLandscape),
                    Expanded(child: _drawingCanvas()),
                    _bottomTools(isLandscape: isLandscape),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _topBar() {
    return Container(
      height: 58.h,
      color: Colors.black,
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Row(
        children: <Widget>[
          _crumb(Icons.home, 'Home'),
          SizedBox(width: 18.w),
          _crumb(Icons.brush, 'Draw'),
          const Spacer(),
          const MenuDrawerButton(),
        ],
      ),
    );
  }

  Widget _crumb(IconData icon, String text) {
    return Row(
      children: <Widget>[
        Icon(icon, color: Colors.white, size: 20.w),
        SizedBox(width: 6.w),
        Text(text, style: TextStyle(color: Colors.white, fontSize: 20.sp)),
      ],
    );
  }

  Widget _bottomTools({required bool isLandscape}) {
    return Container(
      height: (isLandscape ? 82 : 112).h,
      color: const Color(0xFFD9D9D9),
      child: Row(
        children: <Widget>[
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
              scrollDirection: Axis.horizontal,
              itemCount: _palette.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                mainAxisSpacing: 8.w,
              ),
              itemBuilder: (_, int index) => _colorDot(_palette[index]),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: <Widget>[
                  _toolCircle(
                    icon: Icons.pan_tool_alt_outlined,
                    selected: !_eraserMode,
                    onTap: () => setState(() => _eraserMode = false),
                    isLandscape: isLandscape,
                  ),
                  SizedBox(width: 8.w),
                  _toolCircle(
                    icon: Icons.edit,
                    selected: !_eraserMode,
                    onTap: () => setState(() {
                      _eraserMode = false;
                      _strokeWidth = 5;
                    }),
                    isLandscape: isLandscape,
                  ),
                  SizedBox(width: 8.w),
                  _toolCircle(
                    icon: Icons.auto_fix_normal,
                    selected: _eraserMode,
                    onTap: () => setState(() {
                      _eraserMode = true;
                      _strokeWidth = 18;
                    }),
                    isLandscape: isLandscape,
                  ),
                  SizedBox(width: 8.w),
                  _toolCircle(icon: Icons.undo, onTap: _undoStroke, isLandscape: isLandscape),
                  SizedBox(width: 8.w),
                  _toolCircle(icon: Icons.clear, onTap: _clearAll, isLandscape: isLandscape),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _colorDot(Color color) {
    final bool selected = !_eraserMode && _selectedColor == color;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedColor = color;
          _eraserMode = false;
          _strokeWidth = 5;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
          border: Border.all(
            color: selected ? Colors.white : Colors.transparent,
            width: 3,
          ),
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
    return Container(
      height: (isLandscape ? 118 : 94).h,
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      color: isDark ? const Color(0xFF1B1B1B) : const Color(0xFFD3D3D3),
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final bool compact = constraints.maxHeight < 96.h;
          final double firstRowHeight = compact ? 40.h : (isLandscape ? 54.h : 46.h);
          final double gap = compact ? 4.h : (isLandscape ? 8.h : 6.h);

          return Column(
            children: <Widget>[
              SizedBox(
                height: firstRowHeight,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    _actionChip(
                      icon: Icons.add,
                      text: 'Add Image',
                      onTap: _addImage,
                      isLandscape: isLandscape || compact,
                    ),
                    SizedBox(width: 8.w),
                    _actionChip(
                      icon: Icons.edit_outlined,
                      text: 'Edit Image',
                      onTap: _editImage,
                      isLandscape: isLandscape || compact,
                    ),
                    SizedBox(width: 8.w),
                    _actionChip(
                      icon: Icons.delete_outline,
                      text: 'Remove Image',
                      onTap: _removeImage,
                      isLandscape: isLandscape || compact,
                    ),
                  ],
                ),
              ),
              SizedBox(height: gap),
              Flexible(
                child: Row(
                  children: <Widget>[
                    const Spacer(),
                    _textAction(
                      icon: Icons.close,
                      text: 'Close',
                      color: const Color(0xFFFF3360),
                      onTap: _cancelChanges,
                      isLandscape: isLandscape || compact,
                    ),
                    SizedBox(width: 8.w),
                    _textAction(
                      icon: Icons.check,
                      text: 'Save',
                      color: const Color(0xFF66C8F6),
                      onTap: _saveChanges,
                      isLandscape: isLandscape || compact,
                    ),
                  ],
                ),
              ),
            ],
          );
        },
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
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8.r),
      child: Container(
        constraints: BoxConstraints(
          minWidth: (isLandscape ? 108 : 120).w,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: (isLandscape ? 12 : 12).w,
          vertical: (isLandscape ? 9 : 8).h,
        ),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF2A2A2A) : const Color(0xFFEDEDED),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Row(
          children: <Widget>[
            Icon(
              icon,
              size: (isLandscape ? 18 : 18).w,
              color: isDark ? Colors.white : Colors.black54,
            ),
            SizedBox(width: (isLandscape ? 6 : 6).w),
            Text(
              text,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: (isLandscape ? 13 : 15).sp,
                color: isDark ? Colors.white : Colors.black,
              ),
              softWrap: false,
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
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8.r),
      child: Container(
        constraints: BoxConstraints(
          minWidth: (isLandscape ? 92 : 100).w,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: (isLandscape ? 12 : 12).w,
          vertical: (isLandscape ? 9 : 8).h,
        ),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF2A2A2A) : Colors.white,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Row(
          children: <Widget>[
            Icon(icon, color: color, size: (isLandscape ? 18 : 20).w),
            SizedBox(width: (isLandscape ? 6 : 4).w),
            Text(
              text,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: (isLandscape ? 13 : 16).sp, color: color),
              softWrap: false,
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
