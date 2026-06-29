import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zakkiyah_app/constants/images/images.dart';
import 'package:zakkiyah_app/services/voice_service.dart';
import 'package:zakkiyah_app/widgets/menu_drawer_button.dart';

class AppHeaderSegment {
  const AppHeaderSegment({
    required this.label,
    this.icon,
    this.imagePath,
  });

  final String label;
  final IconData? icon;
  final String? imagePath;
}

class AppHeaderTitle extends StatelessWidget {
  const AppHeaderTitle({
    super.key,
    this.segments = const <AppHeaderSegment>[],
    this.fontSize,
    this.onHomeTap,
    this.showBackButton = true,
  });

  AppHeaderTitle.breadcrumbs({
    super.key,
    required List<String> titles,
    String? Function(String title)? assetForTitle,
    this.fontSize,
    this.onHomeTap,
    this.showBackButton = true,
  }) : segments = _segmentsFromTitles(titles, assetForTitle);

  final List<AppHeaderSegment> segments;
  final double? fontSize;
  final VoidCallback? onHomeTap;
  final bool showBackButton;

  static List<AppHeaderSegment> _segmentsFromTitles(
    List<String> titles,
    String? Function(String title)? assetForTitle,
  ) {
    final List<AppHeaderSegment> result = <AppHeaderSegment>[];
    for (final String title in titles) {
      if (title.toLowerCase() == 'home') continue;
      result.add(
        AppHeaderSegment(
          label: title,
          imagePath: assetForTitle?.call(title),
        ),
      );
    }
    return result;
  }

  void _goHome(BuildContext context) {
    if (onHomeTap != null) {
      onHomeTap!();
      return;
    }
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    }
  }

  double _resolveTextSize(BuildContext context) {
    if (fontSize != null) return fontSize!;
    final bool isTablet = MediaQuery.sizeOf(context).shortestSide >= 600;
    if (isTablet) return 20.sp;
    return segments.length > 1 ? 17.sp : 19.sp;
  }

  @override
  Widget build(BuildContext context) {
    final bool canPop = Navigator.canPop(context);
    final bool showBack = showBackButton && canPop;
    final bool homeTappable = onHomeTap != null || (canPop && showBackButton);
    final bool isTablet = MediaQuery.sizeOf(context).shortestSide >= 600;
    final double textSize = _resolveTextSize(context);
    final double gap = isTablet ? 10.w : 8.w;
    final double iconGap = isTablet ? 6.w : 5.w;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        if (showBack) ...<Widget>[
          _headerTap(
            context: context,
            onTap: () => _goHome(context),
            announceText: 'Back',
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.h),
              child: Icon(Icons.arrow_back_ios_new, size: textSize * 0.85),
            ),
          ),
          SizedBox(width: 2.w),
        ],
        _headerTap(
          context: context,
          onTap: homeTappable ? () => _goHome(context) : null,
          announceText: 'Home',
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.h),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(Icons.home, size: textSize * 0.95),
                SizedBox(width: iconGap),
                Text(
                  'Home',
                  maxLines: 1,
                  style: TextStyle(fontSize: textSize, height: 1.1),
                ),
              ],
            ),
          ),
        ),
        for (final AppHeaderSegment segment in segments) ...<Widget>[
          SizedBox(width: gap),
          _segment(segment, textSize, iconGap),
        ],
      ],
    );
  }

  Widget _headerTap({
    required BuildContext context,
    required String announceText,
    required Widget child,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap == null
          ? null
          : () async {
              await VoiceService.instance.speak(announceText);
              if (!context.mounted) return;
              onTap();
            },
      borderRadius: BorderRadius.circular(8.r),
      child: child,
    );
  }

  Widget _segment(AppHeaderSegment segment, double textSize, double iconGap) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        if (segment.imagePath != null)
          Image.asset(
            segment.imagePath!,
            width: textSize * 0.95,
            height: textSize * 0.95,
            fit: BoxFit.contain,
            errorBuilder: (_, __, ___) => Icon(
              segment.icon ?? Icons.label_outline,
              size: textSize * 0.95,
            ),
          )
        else
          Icon(segment.icon ?? Icons.label_outline, size: textSize * 0.95),
        SizedBox(width: iconGap),
        Text(
          segment.label,
          maxLines: 1,
          style: TextStyle(fontSize: textSize, height: 1.1),
        ),
      ],
    );
  }
}

class AppScreenHeader extends StatelessWidget {
  const AppScreenHeader({
    super.key,
    required this.titleContent,
    this.topBarHeight = 55,
    this.topBarPadding,
    this.greetingText = 'Good Morning Zakkiyah!',
  });

  final Widget titleContent;
  final double topBarHeight;
  final EdgeInsetsGeometry? topBarPadding;
  final String greetingText;

  @override
  Widget build(BuildContext context) {
    final bool isTablet = MediaQuery.sizeOf(context).shortestSide >= 600;
    final bool isLandscape = MediaQuery.sizeOf(context).width >
        MediaQuery.sizeOf(context).height;
    final double barHeight = isTablet
        ? (isLandscape ? 52.0 : 58.0)
        : (isLandscape ? (topBarHeight - 4).h : topBarHeight.h);
    final EdgeInsetsGeometry resolvedTopPadding = topBarPadding ??
        EdgeInsets.symmetric(
          horizontal: isTablet ? 12.0 : 10.w,
          vertical: isTablet ? 4.0 : 6.h,
        );
    final double menuSize = isTablet ? 26.0 : 24.0;
    final double greetingHeight = isTablet
        ? (isLandscape ? 50.0 : 58.0)
        : (isLandscape ? 56.h : 62.h);

    return Column(
      children: <Widget>[
        Container(
          height: barHeight,
          color: Colors.black,
          padding: resolvedTopPadding,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.centerLeft,
                    child: IconTheme(
                      data: const IconThemeData(color: Colors.white),
                      child: DefaultTextStyle.merge(
                        style: const TextStyle(color: Colors.white),
                        child: titleContent,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 6.w),
              MenuDrawerButton(size: menuSize),
            ],
          ),
        ),
        Container(
          height: greetingHeight,
          clipBehavior: Clip.hardEdge,
          decoration: const BoxDecoration(
            color: Color(0xFF63CCF8),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: isTablet ? 12.w : 10.w,
            vertical: 8.h,
          ),
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              final double contentHeight = constraints.maxHeight;
              final double avatarSize = contentHeight.clamp(34.0, 46.0);
              final double iconSize = (avatarSize * 0.48).clamp(18.0, 24.0);

              return Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    width: avatarSize,
                    height: avatarSize,
                    child: CircleAvatar(
                      radius: avatarSize / 2,
                      backgroundColor: Colors.white,
                      child: ClipOval(
                        child: Image.asset(
                          AppImages.homeAvatar,
                          width: avatarSize,
                          height: avatarSize,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => Icon(
                            Icons.person,
                            size: avatarSize * 0.5,
                            color: Colors.blueGrey,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          greetingText,
                          maxLines: 1,
                          style: TextStyle(
                            fontSize: isTablet ? 18.sp : 16.sp,
                            color: Colors.black,
                            height: 1.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  _greetingIconButton(
                    icon: ValueListenableBuilder<bool>(
                      valueListenable: VoiceService.instance.isMutedNotifier,
                      builder: (_, bool isMuted, __) {
                        return Icon(
                          isMuted ? Icons.volume_off_outlined : Icons.volume_up_outlined,
                          size: iconSize,
                          color: Colors.black,
                        );
                      },
                    ),
                    onTap: () async {
                      await VoiceService.instance.toggleMute();
                    },
                    size: contentHeight,
                  ),
                  _greetingIconButton(
                    icon: Icon(
                      Icons.help_outline,
                      size: iconSize,
                      color: Colors.black,
                    ),
                    size: contentHeight,
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _greetingIconButton({
    required Widget icon,
    required double size,
    VoidCallback? onTap,
  }) {
    final double buttonSize = size.clamp(36.0, 48.0);
    return SizedBox(
      width: buttonSize,
      height: buttonSize,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(buttonSize / 2),
          child: Center(child: icon),
        ),
      ),
    );
  }
}
