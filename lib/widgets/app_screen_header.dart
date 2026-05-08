import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zakkiyah_app/constants/images/images.dart';
import 'package:zakkiyah_app/services/voice_service.dart';
import 'package:zakkiyah_app/widgets/menu_drawer_button.dart';

class AppScreenHeader extends StatelessWidget {
  const AppScreenHeader({
    super.key,
    required this.titleContent,
    this.topBarHeight = 64,
    this.topBarPadding = const EdgeInsets.symmetric(horizontal: 12),
    this.greetingText = 'Good Morning Zakkiyah!',
  });

  final Widget titleContent;
  final double topBarHeight;
  final EdgeInsetsGeometry topBarPadding;
  final String greetingText;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: topBarHeight.h,
          color: Colors.black,
          padding: topBarPadding,
          child: Row(
            children: <Widget>[
              Expanded(
                child: IconTheme(
                  data: const IconThemeData(color: Colors.white),
                  child: DefaultTextStyle.merge(
                    style: const TextStyle(color: Colors.white),
                    child: titleContent,
                  ),
                ),
              ),
              SizedBox(width: 8.w),
              const MenuDrawerButton(),
            ],
          ),
        ),
        Container(
          height: 80.h,
          color: const Color(0xFF63CCF8),
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Row(
            children: <Widget>[
              CircleAvatar(
                radius: 24.r,
                backgroundColor: Colors.white,
                child: ClipOval(
                  child: Image.asset(
                    AppImages.homeAvatar,
                    width: 64.w,
                    height: 64.w,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) =>
                        Icon(Icons.person, size: 16.w, color: Colors.blueGrey),
                  ),
                ),
              ),
              SizedBox(width: 8.w),
              Text(greetingText, style: TextStyle(fontSize: 18.sp, color: Colors.black)),
              const Spacer(),
              ValueListenableBuilder<bool>(
                valueListenable: VoiceService.instance.isMutedNotifier,
                builder: (_, bool isMuted, __) {
                  return InkWell(
                    borderRadius: BorderRadius.circular(20.r),
                    onTap: () async {
                      await VoiceService.instance.toggleMute();
                    },
                    child: Icon(
                      isMuted ? Icons.volume_off_outlined : Icons.volume_up_outlined,
                      size: 30.w,
                      color: Colors.black,
                    ),
                  );
                },
              ),
              SizedBox(width: 8.w),
              Icon(Icons.help_outline, size: 30.w, color: Colors.black),
            ],
          ),
        ),
      ],
    );
  }
}
