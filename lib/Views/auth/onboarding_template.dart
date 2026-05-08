import 'package:flutter/material.dart';

class OnboardingTemplate extends StatelessWidget {
  const OnboardingTemplate({
    super.key,
    required this.title,
    required this.subtitle,
    required this.imagePath,
    required this.currentIndex,
    required this.onNext,
    this.onBack,
    this.nextText = 'Next',
  });

  final String title;
  final String subtitle;
  final String imagePath;
  final int currentIndex;
  final VoidCallback onNext;
  final VoidCallback? onBack;
  final String nextText;

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final Color themeTextColor = isDark ? Colors.white : Colors.black;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
          child: Column(
            children: <Widget>[
              const SizedBox(height: 16),
              Container(
                height: 300,
                width: 500,
                decoration: BoxDecoration(
                  color: const Color(0xFFEFF9FD),
                  borderRadius: BorderRadius.circular(32),
                ),
                child: Center(
                  child: Image.asset(
                    imagePath,
                    fit: BoxFit.contain,
                    errorBuilder: (_, __, ___) =>
                    const Icon(Icons.image_outlined, size: 70),
                  ),
                ),
              ),
              const SizedBox(height: 26),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                  color: themeTextColor,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                subtitle,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  color: themeTextColor,
                  height: 1.5,
                ),
              ),
              const Spacer(),
              _DotsIndicator(currentIndex: currentIndex),
              const SizedBox(height: 20),
              Row(
                children: <Widget>[
                  Expanded(
                    child: OutlinedButton(
                      onPressed: onBack ?? () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: themeTextColor.withOpacity(0.6)),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        'Previous',
                        style: TextStyle(color: themeTextColor),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: FilledButton(
                      onPressed: onNext,
                      style: FilledButton.styleFrom(
                        backgroundColor: const Color(0xFF64D2F5),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(nextText),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DotsIndicator extends StatelessWidget {
  const _DotsIndicator({required this.currentIndex});

  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List<Widget>.generate(3, (int i) {
        final bool isActive = currentIndex == i;
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: isActive ? 22 : 8,
          height: 8,
          decoration: BoxDecoration(
            color: isActive ? const Color(0xFF64D2F5) : const Color(0xFFCFD9E2),
            borderRadius: BorderRadius.circular(30),
          ),
        );
      }),
    );
  }
}
