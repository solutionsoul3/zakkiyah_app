import 'package:flutter/material.dart';
import 'package:zakkiyah_app/constants/images/images.dart';
import 'package:zakkiyah_app/Views/auth/verification.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool _acceptedTerms = false;

  @override
  Widget build(BuildContext context) {
    final bool isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final Color themeTextColor = isDark ? Colors.white : Colors.black;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: AnimatedPadding(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOut,
            padding: EdgeInsets.fromLTRB(24, 20, 24, isKeyboardOpen ? 55 : 20),
            child: Column(
              children: <Widget>[
                const SizedBox(height: 36),
                Text(
                  'Sign in',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w500,
                    color: themeTextColor,
                  ),
                ),
                const SizedBox(height: 18),
                Text(
                  'Hi! Welcome back, you have been missed',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: themeTextColor, fontSize: 14),
                ),
                const SizedBox(height: 28),
                TextField(
                  style: const TextStyle(color: Colors.black),
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    hintText: 'Email address',
                    hintStyle: const TextStyle(color: Colors.black54),
                    prefixIcon: const Icon(
                      Icons.email_outlined,
                      color: Colors.black,
                    ),
                    filled: true,
                    fillColor: const Color(0xFFF2F5F8),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 14),

                Row(
                  children: <Widget>[
                    Checkbox(
                      value: _acceptedTerms,
                      shape: const CircleBorder(),
                      onChanged: (bool? value) {
                        setState(() {
                          _acceptedTerms = value ?? false;
                        });
                      },
                    ),
                    Expanded(
                      child: Text(
                        'By continuing, you agree to Lingo [Terms of Use] and [Privacy Policy].',
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: themeTextColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 22),
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
                    onPressed: _acceptedTerms
                        ? () {
                      Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                          builder: (_) => const VerificationScreen(),
                        ),
                      );
                    }
                        : null,
                    child: const Text(
                      'Continue',
                      style: TextStyle(fontWeight: FontWeight.w400, fontSize: 22),
                    ),
                  ),
                ),
                const SizedBox(height: 26),
                const _SocialTile(
                  imagePath: AppImages.google,
                  text: 'Sign in with Google',
                ),
                const SizedBox(height: 10),
                const _SocialTile(
                  imagePath: AppImages.microsoft,
                  text: 'Sign in with Microsoft',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SocialTile extends StatelessWidget {
  const _SocialTile({required this.imagePath, required this.text});

  final String imagePath;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFF2F5F8),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            imagePath,
            width: 22,
            height: 22,
            errorBuilder: (_, __, ___) => const Icon(
              Icons.image_not_supported_outlined,
              size: 22,
              color: Color(0xFF5D6A78),
            ),
          ),
          const SizedBox(width: 10),
          Text(
            text,
            style: const TextStyle(
              fontSize: 18,
              color: Color(0xFF5D6A78),
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
