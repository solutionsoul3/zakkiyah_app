import 'package:flutter/material.dart';
import 'package:zakkiyah_app/Views/auth/onboarding_template.dart';
import 'package:zakkiyah_app/constants/images/images.dart';

import 'onboarding_two.dart';

class OnboardingScreenOne extends StatelessWidget {
  const OnboardingScreenOne({super.key});

  @override
  Widget build(BuildContext context) {
    return OnboardingTemplate(
      title: 'Build Smarter AI Workflows',
      subtitle:
          'Design, automate, and optimize your entire LLM pipeline—without friction or complexity',
      imagePath: AppImages.onboarding1,
      currentIndex: 0,
      onNext: () {
        Navigator.push(
          context,
          MaterialPageRoute<void>(builder: (_) => const OnboardingScreenTwo()),
        );
      },
    );
  }
}

