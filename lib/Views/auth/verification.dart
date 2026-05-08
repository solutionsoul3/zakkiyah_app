import 'package:flutter/material.dart';
import 'package:zakkiyah_app/Views/auth/onboarding_one.dart';

class VerificationScreen extends StatelessWidget {
  const VerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final Color themeTextColor = isDark ? Colors.white : Colors.black;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            children: <Widget>[
              const SizedBox(height: 40),
              Text(
                'Verify Your Code',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.w500,
                  color: themeTextColor,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Please enter 4 digit code sent to your number',
                textAlign: TextAlign.center,
                style: TextStyle(color: themeTextColor),
              ),
              const SizedBox(height: 28),
              const _CodeRow(),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  style: FilledButton.styleFrom(
                    backgroundColor: const Color(0xFF64D2F5),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                        builder: (_) => const OnboardingScreenOne(),
                      ),
                    );
                  },
                  child: const Text(
                    'Verify & Continue',
                    style: TextStyle(fontWeight: FontWeight.w400,fontSize: 22),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              TextButton(
                onPressed: () {},
                child: Text('Resend Code', style: TextStyle(color: themeTextColor, fontWeight: FontWeight.w400,fontSize: 22),
                ),),
            ],
          ),
        ),
      ),
    );
  }
}

class _CodeRow extends StatelessWidget {
  const _CodeRow();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const <Widget>[
        _CodeBox(),
        SizedBox(width: 8),
        _CodeBox(),
        SizedBox(width: 8),
        _CodeBox(),
        SizedBox(width: 8),
        _CodeBox(),
      ],
    );
  }
}

class _CodeBox extends StatelessWidget {
  const _CodeBox();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 54,
      height: 54,
      decoration: BoxDecoration(
        color: const Color(0xFFF2F5F8),
        borderRadius: BorderRadius.circular(10),
      ),
      child: const TextField(
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        maxLength: 1,
        style: TextStyle(color: Colors.black),
        cursorColor: Colors.black,
        decoration: InputDecoration(
          counterText: '',
          border: InputBorder.none,
        ),
      ),
    );
  }
}
