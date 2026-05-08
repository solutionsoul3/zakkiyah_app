import 'package:flutter/material.dart';
import 'package:zakkiyah_app/Views/auth/onboarding_one.dart';

class VerificationScreen extends StatelessWidget {
  const VerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final Color themeTextColor = isDark ? Colors.white : Colors.black;
    final Size size = MediaQuery.of(context).size;
    final bool isLandscape = size.width > size.height;
    final bool isTablet = size.shortestSide >= 600;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: isTablet ? 560 : 420),
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              child: Column(
                children: <Widget>[
                  SizedBox(height: isLandscape ? 8 : 40),
                  Text(
                    'Verify Your Code',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: isLandscape ? 30 : 40,
                      fontWeight: FontWeight.w500,
                      color: themeTextColor,
                    ),
                  ),
                  SizedBox(height: isLandscape ? 12 : 20),
                  Text(
                    'Please enter 4 digit code sent to your number',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: themeTextColor,
                      fontSize: isLandscape ? 14 : 16,
                    ),
                  ),
                  SizedBox(height: isLandscape ? 16 : 28),
                  const _CodeRow(),
                  SizedBox(height: isLandscape ? 16 : 24),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      style: FilledButton.styleFrom(
                        backgroundColor: const Color(0xFF64D2F5),
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: isLandscape ? 12 : 14),
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
                      child: Text(
                        'Verify & Continue',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: isLandscape ? 18 : 22,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: isLandscape ? 8 : 12),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'Resend Code',
                      style: TextStyle(
                        color: themeTextColor,
                        fontWeight: FontWeight.w400,
                        fontSize: isLandscape ? 18 : 22,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _CodeRow extends StatefulWidget {
  const _CodeRow();

  @override
  State<_CodeRow> createState() => _CodeRowState();
}

class _CodeRowState extends State<_CodeRow> {
  final List<FocusNode> _focusNodes =
  List.generate(4, (_) => FocusNode());

  final List<TextEditingController> _controllers =
  List.generate(4, (_) => TextEditingController());

  @override
  void dispose() {
    for (var node in _focusNodes) {
      node.dispose();
    }
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _onChanged(String value, int index) {
    if (value.isNotEmpty) {
      // Move to next field
      if (index < 3) {
        FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
      } else {
        FocusScope.of(context).unfocus();
      }
    } else {
      // Move back on delete
      if (index > 0) {
        FocusScope.of(context).requestFocus(_focusNodes[index - 1]);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(4, (index) {
        return Row(
          children: [
            SizedBox(
              width: 54,
              height: 54,
              child: TextField(
                controller: _controllers[index],
                focusNode: _focusNodes[index],
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                maxLength: 1,
                cursorColor: Colors.black,
                style: const TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  counterText: '',
                  filled: true,
                  fillColor: const Color(0xFFF2F5F8),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
                onChanged: (value) => _onChanged(value, index),
              ),
            ),
            if (index != 3) const SizedBox(width: 8),
          ],
        );
      }),
    );
  }
}
