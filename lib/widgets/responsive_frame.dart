import 'package:flutter/material.dart';

class ResponsiveFrame extends StatelessWidget {
  const ResponsiveFrame({
    super.key,
    required this.child,
    this.mobileMaxWidth = 480,
    this.tabletMaxWidth = 1200,
  });

  final Widget child;
  final double mobileMaxWidth;
  final double tabletMaxWidth;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, BoxConstraints constraints) {
        final double width = constraints.maxWidth;
        double maxWidth;
        if (width < 600) {
          maxWidth = mobileMaxWidth;
        } else if (width < 1024) {
          maxWidth = 760;
        } else {
          maxWidth = tabletMaxWidth;
        }

        return Align(
          alignment: Alignment.topCenter,
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: maxWidth),
            child: child,
          ),
        );
      },
    );
  }
}
