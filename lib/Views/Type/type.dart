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
                child: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    return SingleChildScrollView(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(minHeight: constraints.maxHeight),
                        child: Padding(
                          padding: EdgeInsets.all((isLandscape ? 14 : 20).w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Type Your Message',
                                style: TextStyle(
                                  fontSize: (isLandscape ? 18 : 30).sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(height: (isLandscape ? 10 : 14).h),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Expanded(
                                    child: Container(
                                      height: (isLandscape ? 100 : 170).h,
                                      padding: EdgeInsets.all(8.w),
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
                                        style: TextStyle(
                                          fontSize: (isLandscape ? 16 : 22).sp,
                                          color: Colors.black87,
                                        ),
                                        decoration: InputDecoration(
                                          hintText: 'Write here..............',
                                          hintStyle: TextStyle(
                                            fontSize: (isLandscape ? 14 : 20).sp,
                                            color: Colors.black45,
                                          ),
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 12.w),
                                  _speakTile(isLandscape: isLandscape),
                                ],
                              ),
                              SizedBox(height: (isLandscape ? 12 : 18).h),
                              SizedBox(
                                height: (isLandscape ? 500 : 500).h,
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
                    );
                  },
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
    final bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return Container(
      height: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: (isLandscape ? 10 : 16).w),
      color: isActive ? const Color(0xFF1C1C1C) : Colors.transparent,
      child: Row(
        children: <Widget>[
          Icon(icon, color: Colors.white, size: (isLandscape ? 16 : 20).w),
          SizedBox(width: (isLandscape ? 4 : 6).w),
          Text(
            label,
            style: TextStyle(color: Colors.white, fontSize: (isLandscape ? 16 : 24).sp),
          ),
        ],
      ),
    );
  }

  Widget _speakTile({required bool isLandscape}) {
    return Container(
      width: (isLandscape ? 56 : 80).w,
      height: (isLandscape ? 96 : 170).h,
      padding: EdgeInsets.all(8.w),
      decoration: BoxDecoration(
        color: const Color(0xFFDCDCDC),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Image.asset(
              AppImages.speak,
              fit: BoxFit.contain,
              errorBuilder: (_, __, ___) =>
                  Icon(Icons.record_voice_over, size: 24.w, color: Colors.blueGrey),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: _isSpeaking ? _stopSpeaking : _speakMessage,
              child: Center(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    _isSpeaking ? 'Stop' : 'Speak',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: const Color(0xFF2563EB),
                      fontSize: (isLandscape ? 11 : 18).sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: _toggleListening,
              child: Center(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    _isListening ? 'Stop Mic' : 'Voice Type',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: _isListening ? const Color(0xFFEA4335) : const Color(0xFF16A34A),
                      fontSize: (isLandscape ? 11 : 18).sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _keyboardPreview() {
    final bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return Column(
      children: <Widget>[
        SizedBox(
          height: (isLandscape ? 40 : 46).h,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Keyboard',
              style: TextStyle(
                fontSize: (isLandscape ? 16 : 24).sp,
                color: Colors.black54,
              ),
            ),
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
                fontSize: (isLandscape ? 12 : 22).sp,
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
