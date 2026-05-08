import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:zakkiyah_app/constants/images/images.dart';
import 'package:zakkiyah_app/widgets/app_menu_drawer.dart';
import 'package:zakkiyah_app/widgets/app_screen_header.dart';
import 'package:zakkiyah_app/widgets/responsive_frame.dart';
import 'package:virtual_keyboard_multi_language/virtual_keyboard_multi_language.dart';

class TypeScreen extends StatefulWidget {
  const TypeScreen({super.key});

  @override
  State<TypeScreen> createState() => _TypeScreenState();
}

class _TypeScreenState extends State<TypeScreen> {
  final TextEditingController _messageController = TextEditingController();
  final FocusNode _messageFocusNode = FocusNode();
  final FlutterTts _flutterTts = FlutterTts();
  final SpeechToText _speechToText = SpeechToText();
  bool _isSpeaking = false;
  bool _isListening = false;
  bool _speechEnabled = false;

  @override
  void initState() {
    super.initState();
    _setupTts();
    _initSpeechToText();
  }

  Future<void> _setupTts() async {
    await _flutterTts.setSpeechRate(0.45);
    await _flutterTts.setPitch(1.0);
    await _flutterTts.setVolume(1.0);
    _flutterTts.setStartHandler(() {
      if (!mounted) return;
      setState(() => _isSpeaking = true);
    });
    _flutterTts.setCompletionHandler(() {
      if (!mounted) return;
      setState(() => _isSpeaking = false);
    });
    _flutterTts.setCancelHandler(() {
      if (!mounted) return;
      setState(() => _isSpeaking = false);
    });
    _flutterTts.setErrorHandler((_) {
      if (!mounted) return;
      setState(() => _isSpeaking = false);
    });
  }

  Future<void> _initSpeechToText() async {
    _speechEnabled = await _speechToText.initialize();
    if (!mounted) return;
    setState(() {});
  }

  @override
  void dispose() {
    _flutterTts.stop();
    _speechToText.stop();
    _messageController.dispose();
    _messageFocusNode.dispose();
    super.dispose();
  }

  Future<void> _speakMessage() async {
    final String text = _messageController.text.trim();
    if (text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please type a message first.')),
      );
      return;
    }
    await _flutterTts.speak(text);
  }

  Future<void> _stopSpeaking() async {
    await _flutterTts.stop();
    if (!mounted) return;
    setState(() => _isSpeaking = false);
  }

  Future<void> _toggleListening() async {
    if (_isListening) {
      await _speechToText.stop();
      if (!mounted) return;
      setState(() => _isListening = false);
      return;
    }

    if (!_speechEnabled) {
      _speechEnabled = await _speechToText.initialize();
    }

    if (!_speechEnabled) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Speech recognition is not available.')),
      );
      return;
    }

    await _speechToText.listen(
      partialResults: true,
      onResult: (result) {
        if (!mounted) return;
        _messageController.text = result.recognizedWords;
        _messageController.selection =
            TextSelection.collapsed(offset: _messageController.text.length);
        setState(() {});
      },
      onSoundLevelChange: (_) {},
      listenMode: ListenMode.dictation,
    );

    if (!mounted) return;
    setState(() => _isListening = true);
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
                greetingText: 'Good Morning Zakkiyah',
                titleContent: Row(
                  children: <Widget>[
                    _topBreadcrumb(
                      icon: Icons.home,
                      label: 'Home',
                      isActive: false,
                    ),
                    SizedBox(width: 2.w),
                    _topBreadcrumb(
                      icon: Icons.text_fields,
                      label: 'Type',
                      isActive: true,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Type Your Message',
                        style: TextStyle(fontSize: 30.sp, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(height: 14.h),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              height: 170.h,
                              padding: EdgeInsets.all(12.w),
                              decoration: BoxDecoration(
                                color: const Color(0xFFDCDCDC),
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              child: TextField(
                                controller: _messageController,
                                focusNode: _messageFocusNode,
                                readOnly: true,
                                showCursor: true,
                                maxLines: null,
                                expands: true,
                                style: TextStyle(fontSize: 22.sp, color: Colors.black87),
                                decoration: InputDecoration(
                                  hintText: 'Write here..............',
                                  hintStyle: TextStyle(fontSize: 20.sp, color: Colors.black45),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 12.w),
                          _speakTile(),
                        ],
                      ),
                      SizedBox(height: 18.h),
                      Expanded(
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(14.w),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE5E5E5),
                            borderRadius: BorderRadius.circular(18.r),
                          ),
                          child: _keyboardPreview(),
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

  Widget _topBreadcrumb({
    required IconData icon,
    required String label,
    required bool isActive,
  }) {
    return Container(
      height: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      color: isActive ? const Color(0xFF1C1C1C) : Colors.transparent,
      child: Row(
        children: <Widget>[
          Icon(icon, color: Colors.white, size: 20.w),
          SizedBox(width: 6.w),
          Text(
            label,
            style: TextStyle(color: Colors.white, fontSize: 24.sp),
          ),
        ],
      ),
    );
  }

  Widget _speakTile() {
    return Container(
      width: 80.w,
      height: 170.h,
      padding: EdgeInsets.all(8.w),
      decoration: BoxDecoration(
        color: const Color(0xFFDCDCDC),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 75.h,
            child: Image.asset(
              AppImages.speak,
              fit: BoxFit.contain,
              errorBuilder: (_, __, ___) =>
                  Icon(Icons.record_voice_over, size: 30.w, color: Colors.blueGrey),
            ),
          ),
          InkWell(
            onTap: _isSpeaking ? _stopSpeaking : _speakMessage,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 4.h),
              child: Text(
                _isSpeaking ? 'Stop' : 'Speak',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: const Color(0xFF2563EB),
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          InkWell(
            onTap: _toggleListening,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 4.h),
              child: Text(
                _isListening ? 'Stop Mic' : 'Voice Type',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: _isListening ? const Color(0xFFEA4335) : const Color(0xFF16A34A),
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _keyboardPreview() {
    return Column(
      children: <Widget>[
        Container(
          height: 46.h,
          alignment: Alignment.centerLeft,
          child: Text(
            'Keyboard',
            style: TextStyle(fontSize: 24.sp, color: Colors.black54),
          ),
        ),
        SizedBox(height: 6.h),
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(14.r),
            child: Material(
              color: const Color(0xFFE5E5E5),
              child: VirtualKeyboard(
                type: VirtualKeyboardType.Alphanumeric,
                textController: _messageController,
                textColor: Colors.black87,
                fontSize: 22.sp,
                alwaysCaps: false,
                reverseLayout: false,
                defaultLayouts: const <VirtualKeyboardDefaultLayouts>[
                  VirtualKeyboardDefaultLayouts.English,
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
