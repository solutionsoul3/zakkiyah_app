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

bool isTabletLayout(BuildContext context) =>
    MediaQuery.sizeOf(context).shortestSide >= 600;

bool isLandscapeLayout(BuildContext context) =>
    MediaQuery.orientationOf(context) == Orientation.landscape;

int responsiveCrossAxisCount(BuildContext context, {double? width}) {
  return kTileCrossAxisCount;
}

double responsiveTileSpacing(BuildContext context) {
  final double screenWidth = MediaQuery.sizeOf(context).width;
  // 1.5% of screen width, clamped between 10-16px
  return (screenWidth * 0.015).clamp(10.0, 16.0);
}

/// Get responsive size based on screen width percentage
double responsiveSize(BuildContext context, double percentage) {
  final double screenWidth = MediaQuery.sizeOf(context).width;
  return screenWidth * (percentage / 100);
}

/// Get responsive height based on screen height percentage
double responsiveHeight(BuildContext context, double percentage) {
  final double screenHeight = MediaQuery.sizeOf(context).height;
  return screenHeight * (percentage / 100);
}

/// Safe padding for screens - scales with screen size
EdgeInsets responsivePadding(BuildContext context) {
  final double width = MediaQuery.sizeOf(context).width;
  final double padding = width * 0.025; // 2.5% of screen width
  return EdgeInsets.all(padding.clamp(10.0, 16.0));
}

/// Aspect ratio calculation for grid tiles
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
  
  final double ratio = cellWidth / cellHeight;
  return ratio.clamp(0.7, 1.4);
}

// ─────────────────────────────────────────────
//  LEFT RAIL HELPERS - Scale with screen size
// ─────────────────────────────────────────────

/// Left-rail width - responsive based on device and orientation
double railWidth(BuildContext context) {
  final double screenWidth = MediaQuery.sizeOf(context).width;
  final bool isTablet = isTabletLayout(context);
  final bool isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;
  
  if (isTablet) {
    // Tablets: smaller in landscape, normal in portrait
    if (isLandscape) {
      return (screenWidth * 0.045).clamp(55.0, 70.0); // Small when rotated
    } else {
      return (screenWidth * 0.065).clamp(75.0, 90.0); // Normal size
    }
  } else {
    // Phones: slightly smaller in landscape
    if (isLandscape) {
      return (screenWidth * 0.08).clamp(65.0, 80.0); // Small when rotated
    } else {
      return (screenWidth * 0.10).clamp(80.0, 95.0); // Normal size
    }
  }
}

/// Icon button container - 70% of rail width
double railIconContainerW(BuildContext context) {
  final double railW = railWidth(context);
  return railW * 0.70;
}

/// Icon size - 35% of container width
double railIconSize(BuildContext context) {
  final double containerW = railIconContainerW(context);
  return containerW * 0.35;
}

/// Label font size - 1.5% of screen width
double railLabelSp(BuildContext context) {
  final double screenWidth = MediaQuery.sizeOf(context).width;
  return (screenWidth * 0.015).clamp(10.0, 13.0);
}

/// Vertical padding - 1% of screen height
double railVerticalPadding(BuildContext context) {
  final double screenHeight = MediaQuery.sizeOf(context).height;
  return (screenHeight * 0.01).clamp(7.0, 10.0);
}

// ─────────────────────────────────────────────
//  TEXT SIZE HELPERS - Scale with screen size
// ─────────────────────────────────────────────

/// Responsive text size based on screen width percentage
double responsiveTextSize(BuildContext context, double basePercentage) {
  final double screenWidth = MediaQuery.sizeOf(context).width;
  return (screenWidth * (basePercentage / 100)).clamp(10.0, 50.0);
}

/// Header text (2.5% of width)
double headerTextSize(BuildContext context) {
  return responsiveTextSize(context, 2.5);
}

/// Body text (2% of width)
double bodyTextSize(BuildContext context) {
  return responsiveTextSize(context, 2.0);
}

/// Small text (1.5% of width)
double smallTextSize(BuildContext context) {
  return responsiveTextSize(context, 1.5);
}

// ─────────────────────────────────────────────
//  ICON SIZE HELPERS - Scale with screen size
// ─────────────────────────────────────────────

/// Responsive icon size based on screen width percentage
double responsiveIconSize(BuildContext context, double basePercentage) {
  final double screenWidth = MediaQuery.sizeOf(context).width;
  return (screenWidth * (basePercentage / 100)).clamp(16.0, 40.0);
}

/// Standard icon (3% of width)
double standardIconSize(BuildContext context) {
  return responsiveIconSize(context, 3.0);
}

/// Large icon (4% of width)
double largeIconSize(BuildContext context) {
  return responsiveIconSize(context, 4.0);
}

/// Small icon (2.5% of width)
double smallIconSize(BuildContext context) {
  return responsiveIconSize(context, 2.5);
}

// ─────────────────────────────────────────────
//  IMAGE SIZE HELPERS
// ─────────────────────────────────────────────

/// Responsive image size for tiles (65% of available width)
double responsiveTileImageSize(BuildContext context, double availableWidth) {
  return (availableWidth * 0.65).clamp(50.0, 100.0);
}

// ─────────────────────────────────────────────
//  SAFE SIZING HELPERS
// ─────────────────────────────────────────────

/// Safe button size (5% of width)
double safeButtonSize(BuildContext context, double baseSize) {
  final double screenWidth = MediaQuery.sizeOf(context).width;
  return (screenWidth * 0.05).clamp(baseSize * 0.8, baseSize * 1.2);
}

/// Safe icon size (4% of width)
double safeIconSize(BuildContext context, double baseSize) {
  final double screenWidth = MediaQuery.sizeOf(context).width;
  return (screenWidth * 0.04).clamp(baseSize * 0.9, baseSize * 1.1);
}

/// Safe text size (2.5% of width)
double safeTextSize(BuildContext context, double baseSize) {
  final double screenWidth = MediaQuery.sizeOf(context).width;
  return (screenWidth * 0.025).clamp(baseSize * 0.85, baseSize * 1.15);
}
