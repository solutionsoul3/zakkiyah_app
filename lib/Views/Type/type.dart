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
    final double screenHeight = MediaQuery.sizeOf(context).height;
    
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
                      label: 'Type',
                      icon: Icons.text_fields,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.all((isLandscape ? 8 : 12).w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Type Your Message',
                        style: TextStyle(
                          fontSize: responsiveTextSize(context, 3.5).clamp(18.0, 28.0),
                          fontWeight: FontWeight.w500,
                          height: 1.2,
                        ),
                      ),
                      SizedBox(height: (isLandscape ? 6 : 8).h),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            child: _messageInputBox(isLandscape: isLandscape),
                          ),
                          SizedBox(width: 10.w),
                          _speakTile(isLandscape: isLandscape),
                        ],
                      ),
                      SizedBox(height: (isLandscape ? 6 : 10).h),
                      // Larger keyboard container to prevent overflow - extra padding added
                      SizedBox(
                        height: (screenHeight * 0.56).clamp(360.0, 560.0),
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(10.w),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE5E5E5),
                            borderRadius: BorderRadius.circular(18.r),
                          ),
                          child: _keyboardPreview(),
                        ),
                      ),
                      SizedBox(height: 16.h), // Bottom padding for scrolling
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

  Widget _messageInputBox({required bool isLandscape}) {
    final double screenHeight = MediaQuery.sizeOf(context).height;
    final double screenWidth = MediaQuery.sizeOf(context).width;
    
    // Further reduced height to maximize keyboard space
    final double boxHeight = (screenHeight * 0.15).clamp(100.0, 140.0);
    final double textFontSize = (screenWidth * 0.022).clamp(15.0, 22.0);
    final double hintFontSize = (screenWidth * 0.018).clamp(13.0, 18.0);
    
    return Container(
      height: boxHeight,
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: const Color(0xFFDCDCDC),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: TextField(
        controller: _messageController,
        focusNode: _messageFocusNode,
        readOnly: true,
        showCursor: true,
        maxLines: null,
        expands: true,
        textAlignVertical: TextAlignVertical.top,
        style: TextStyle(
          fontSize: textFontSize,
          color: Colors.black87,
          height: 1.3,
        ),
        decoration: InputDecoration(
          hintText: 'Write here..............',
          hintStyle: TextStyle(
            fontSize: hintFontSize,
            color: Colors.black45,
            height: 1.3,
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.zero,
        ),
      ),
    );
  }

  Widget _speakTile({required bool isLandscape}) {
    final double screenWidth = MediaQuery.sizeOf(context).width;
    final double screenHeight = MediaQuery.sizeOf(context).height;
    
    // Reduced to match message box
    final double tileWidth = (screenWidth * 0.11).clamp(65.0, 90.0);
    final double tileHeight = (screenHeight * 0.15).clamp(100.0, 140.0);
    final double textFontSize = (screenWidth * 0.018).clamp(13.0, 18.0);
    
    return Container(
      width: tileWidth,
      height: tileHeight,
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: const Color(0xFFDCDCDC),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Image.asset(
              AppImages.speak,
              fit: BoxFit.contain,
              errorBuilder: (_, __, ___) =>
                  const Icon(Icons.record_voice_over, size: 28, color: Colors.blueGrey),
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
                      fontSize: textFontSize,
                      fontWeight: FontWeight.w400,
                      height: 1.2,
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
                      fontSize: textFontSize,
                      fontWeight: FontWeight.w400,
                      height: 1.2,
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
    final double screenHeight = MediaQuery.sizeOf(context).height;
    final double screenWidth = MediaQuery.sizeOf(context).width;
    
    // Minimal title size to maximize keyboard space
    final double titleHeight = (screenHeight * 0.04).clamp(30.0, 40.0);
    final double titleFontSize = (screenWidth * 0.024).clamp(16.0, 22.0);
    final double keyboardFontSize = (screenWidth * 0.020).clamp(14.0, 20.0);
    
    return Column(
      children: <Widget>[
        SizedBox(
          height: titleHeight,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Keyboard',
              style: TextStyle(
                fontSize: titleFontSize,
                color: Colors.black54,
                height: 1.1,
              ),
            ),
          ),
        ),
        const SizedBox(height: 4.0),
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(14.0),
            child: Material(
              color: const Color(0xFFE5E5E5),
              child: VirtualKeyboard(
                type: VirtualKeyboardType.Alphanumeric,
                textController: _messageController,
                textColor: Colors.black87,
                fontSize: keyboardFontSize,
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
