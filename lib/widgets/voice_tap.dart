import 'dart:async';

import 'package:flutter/material.dart';
import 'package:zakkiyah_app/services/voice_service.dart';

class VoiceTap extends StatelessWidget {
  const VoiceTap({
    super.key,
    required this.announceText,
    required this.onTap,
    required this.child,
    this.borderRadius,
    this.enabled = true,
  });

  final String announceText;
  final FutureOr<void> Function() onTap;
  final Widget child;
  final BorderRadius? borderRadius;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: borderRadius,
      onTap: enabled
          ? () async {
              await VoiceService.instance.speak(announceText);
              await onTap();
            }
          : null,
      child: child,
    );
  }
}
