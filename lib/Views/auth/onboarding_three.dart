import 'package:flutter/material.dart';
import 'package:zakkiyah_app/Routes/routes.dart';
import 'package:zakkiyah_app/Views/auth/onboarding_template.dart';
import 'package:zakkiyah_app/constants/images/images.dart';

class OnboardingScreenThree extends StatelessWidget {
  const OnboardingScreenThree({super.key});

  @override
  Widget build(BuildContext context) {
    return OnboardingTemplate(
      title: 'Control Every Step of Your Logic',
      subtitle:
          'Monitor execution, debug issues, and fine-tune system behavior with real-time insights into each actor’s response.',
      imagePath: AppImages.onboarding3,
      currentIndex: 2,
      onBack: () => Navigator.pop(context),
      nextText: 'Get Started',
      onNext: () {
        Navigator.pushNamed(context, AppRoutes.home);
      },
    );
  }
}
