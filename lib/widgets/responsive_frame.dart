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
        return SizedBox(
          width: constraints.maxWidth,
          child: child,
        );
      },
    );
  }
}

/// Always 2 columns for tile grids (portrait, landscape, phone, tablet).
const int kTileCrossAxisCount = 2;

int responsiveCrossAxisCount(BuildContext context, {double? width}) {
  return kTileCrossAxisCount;
}

/// Aspect ratio so [itemCount] tiles fill the grid area without scrolling.
double gridChildAspectRatioForFit({
  required double maxWidth,
  required double maxHeight,
  required int crossAxisCount,
  required int itemCount,
  double mainAxisSpacing = 15,
  double crossAxisSpacing = 15,
}) {
  if (itemCount <= 0 || crossAxisCount <= 0 || maxHeight <= 0 || maxWidth <= 0) {
    return 1.0;
  }
  final int rowCount = (itemCount + crossAxisCount - 1) ~/ crossAxisCount;
  final double cellWidth =
      (maxWidth - (crossAxisCount - 1) * crossAxisSpacing) / crossAxisCount;
  final double cellHeight =
      (maxHeight - (rowCount - 1) * mainAxisSpacing) / rowCount;
  if (cellHeight <= 0) return 1.0;
  return cellWidth / cellHeight;
}
