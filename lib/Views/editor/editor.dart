import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ResponsiveFrame(
          tabletMaxWidth: 1200,
          child: Column(
            children: <Widget>[
              Container(
                height: 64.h,
                color: Colors.black,
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Row(
                  children: <Widget>[
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Icon(Icons.arrow_back, color: Colors.white, size: 20.w),
                    ),
                    SizedBox(width: 8.w),
                    Text('Editor', style: TextStyle(color: Colors.white, fontSize: 22.sp)),
                    const Spacer(),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Icon(Icons.close, color: Colors.white, size: 22.w),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  color: const Color(0xFFF4F4F4),
                  padding: EdgeInsets.all(12.w),
                  child: LayoutBuilder(
                    builder: (_, BoxConstraints constraints) {
                      final bool wide = constraints.maxWidth >= 760;
                      if (!wide) {
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Expanded(flex: 2, child: _formCard()),
                                SizedBox(width: 12.w),
                                Expanded(child: _previewCard()),
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

  Widget _formCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8.r)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Select The Type', style: TextStyle(fontSize: 16.sp)),
          _radioRowType(),
          SizedBox(height: 8.h),
          Text('Select The Mode', style: TextStyle(fontSize: 16.sp)),
          _radioRowMode(),
          SizedBox(height: 8.h),
          Text('Card Name', style: TextStyle(fontSize: 16.sp)),
          SizedBox(height: 6.h),
          Container(height: 38.h, color: const Color(0xFFF3F3F3)),
          SizedBox(height: 12.h),
          Text(
            _selectedMode == EditorMode.recording ? 'Record A Voice' : 'Spoken Message',
            style: TextStyle(fontSize: 16.sp),
          ),
          SizedBox(height: 6.h),
          if (_selectedMode == EditorMode.recording)
            _recordingRow()
          else
            Container(height: 80.h, color: const Color(0xFFF3F3F3)),
        ],
      ),
    );
  }

  Widget _radioRowType() {
    return Row(
      children: <Widget>[
        Radio<EditorType>(
          value: EditorType.folder,
          groupValue: _selectedType,
          onChanged: (EditorType? v) => setState(() => _selectedType = v ?? EditorType.folder),
        ),
        const Text('Folder'),
        Radio<EditorType>(
          value: EditorType.card,
          groupValue: _selectedType,
          onChanged: (EditorType? v) => setState(() => _selectedType = v ?? EditorType.card),
        ),
        const Text('Card'),
      ],
    );
  }

  Widget _radioRowMode() {
    Widget mode(EditorMode m, String t) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Radio<EditorMode>(
            value: m,
            groupValue: _selectedMode,
            onChanged: (EditorMode? v) => setState(() => _selectedMode = v ?? EditorMode.communication),
          ),
          Text(t),
        ],
      );
    }

    return Wrap(
      spacing: 12.w,
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
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
      color: const Color(0xFFF3F3F3),
      child: Row(
        children: <Widget>[
          const Icon(Icons.mic, color: Colors.orange),
          SizedBox(width: 8.w),
          Expanded(child: Slider(value: 0.25, onChanged: (_) {})),
          SizedBox(width: 8.w),
          OutlinedButton(onPressed: () {}, child: const Text('Play')),
        ],
      ),
    );
  }

  Widget _previewCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8.r)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Text('Card Preview', style: TextStyle(fontSize: 16.sp)),
              const Spacer(),
              const CircleAvatar(
                radius: 12,
                backgroundColor: Colors.black,
                child: Icon(Icons.edit, color: Colors.white, size: 14),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          Center(
            child: Container(
              width: 130.w,
              height: 150.h,
              color: const Color(0xFFEDEDED),
              child: const Icon(Icons.image, color: Colors.grey, size: 42),
            ),
          ),
        ],
      ),
    );
  }

  Widget _bottomCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8.r)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Card Image', style: TextStyle(fontSize: 16.sp)),
          SizedBox(height: 8.h),
          Wrap(
            spacing: 10.w,
            runSpacing: 8.h,
            children: const <Widget>[
              _ActionChip(icon: Icons.photo_library_outlined, text: 'Select image'),
              _ActionChip(icon: Icons.image_search_outlined, text: 'Choose From'),
              _ActionChip(icon: Icons.camera_alt_outlined, text: 'Take Photo'),
              _ActionChip(icon: Icons.language_outlined, text: 'Web image'),
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.close, color: Colors.pinkAccent, size: 16),
                label: const Text('Close'),
              ),
              SizedBox(width: 10.w),
              FilledButton.icon(
                style: FilledButton.styleFrom(backgroundColor: const Color(0xFF66D5FD)),
                onPressed: () {},
                icon: const Icon(Icons.check, size: 16),
                label: const Text('Save'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ActionChip extends StatelessWidget {
  const _ActionChip({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: () {},
      icon: Icon(icon, size: 16),
      label: Text(text),
    );
  }
}
