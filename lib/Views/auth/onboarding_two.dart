import 'package:flutter/material.dart';
import 'package:zakkiyah_app/Views/auth/onboarding_template.dart';
import 'package:zakkiyah_app/constants/images/images.dart';

import 'onboarding_three.dart';

class OnboardingScreenTwo extends StatelessWidget {
  const OnboardingScreenTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return OnboardingTemplate(
      title: 'Create Pipelines That Think',
      subtitle:
          'Drag, connect, and configure intelligent nodes to build structured conversations, logic branches, loops, and decision flows in minutes.',
      imagePath: AppImages.onboarding2,
      currentIndex: 1,
      onBack: () => Navigator.pop(context),
      onNext: () {
        Navigator.push(
          context,
          MaterialPageRoute<void>(
            builder: (_) => const OnboardingScreenThree(),
          ),
        );
      },
    );
  }
}
