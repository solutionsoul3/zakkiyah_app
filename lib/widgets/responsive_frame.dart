import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
  final bool isTablet = isTabletLayout(context);
  final bool isLandscape = isLandscapeLayout(context);
  if (isTablet && isLandscape) return 12.0;
  if (isTablet) return 14.0;
  if (isLandscape) return 10.0;
  return 12.0;
}

/// Safe padding for screens with notches or system UI
EdgeInsets responsivePadding(BuildContext context) {
  final bool isTablet = isTabletLayout(context);
  final bool isLandscape = isLandscapeLayout(context);
  
  if (isTablet && isLandscape) {
    return EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h);
  } else if (isTablet) {
    return EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h);
  } else if (isLandscape) {
    return EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h);
  }
  return EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h);
}

/// Aspect ratio so [itemCount] tiles fill the grid area without scrolling.
/// Enhanced to prevent overflow on tablet rotation.
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
  // Clamp ratio to reasonable bounds to prevent extreme layouts
  return ratio.clamp(0.7, 1.4);
}

// ─────────────────────────────────────────────
//  Tablet-aware size helpers (Enhanced for rotation)
// ─────────────────────────────────────────────

/// Returns a scaled font size appropriate for the current device / orientation.
/// [phone] base in sp, [tabletPortrait] for tablet portrait, [tabletLandscape]
/// for tablet landscape. Falls back to [phone] when values are omitted.
double tabletSp(
  BuildContext context,
  double phone, {
  double? tabletPortrait,
  double? tabletLandscape,
}) {
  final bool isTablet = isTabletLayout(context);
  final bool isLandscape = isLandscapeLayout(context);
  if (isTablet && isLandscape && tabletLandscape != null) return tabletLandscape.sp;
  if (isTablet && tabletPortrait != null) return tabletPortrait.sp;
  return phone.sp;
}

/// Returns a pixel size (width/height) appropriate for the current device.
double tabletW(
  BuildContext context,
  double phone, {
  double? tabletPortrait,
  double? tabletLandscape,
}) {
  final bool isTablet = isTabletLayout(context);
  final bool isLandscape = isLandscapeLayout(context);
  if (isTablet && isLandscape && tabletLandscape != null) return tabletLandscape.w;
  if (isTablet && tabletPortrait != null) return tabletPortrait.w;
  return phone.w;
}

/// Same as [tabletW] but for heights.
double tabletH(
  BuildContext context,
  double phone, {
  double? tabletPortrait,
  double? tabletLandscape,
}) {
  final bool isTablet = isTabletLayout(context);
  final bool isLandscape = isLandscapeLayout(context);
  if (isTablet && isLandscape && tabletLandscape != null) return tabletLandscape.h;
  if (isTablet && tabletPortrait != null) return tabletPortrait.h;
  return phone.h;
}

/// Left-rail width for screens that have an action rail sidebar.
/// Enhanced for tablet rotation to prevent layout overflow.
double railWidth(BuildContext context) {
  final bool isTablet = isTabletLayout(context);
  final bool isLandscape = isLandscapeLayout(context);
  if (isTablet && isLandscape) return 80.0;
  if (isTablet) return 90.0;
  if (isLandscape) return 75.0;
  return 92.w;
}

/// Icon button size inside the left rail.
double railIconContainerW(BuildContext context) {
  final bool isTablet = isTabletLayout(context);
  final bool isLandscape = isLandscapeLayout(context);
  if (isTablet && isLandscape) return 56.0;
  if (isTablet) return 64.0;
  if (isLandscape) return 52.0;
  return 64.w;
}

double railIconSize(BuildContext context) {
  final bool isTablet = isTabletLayout(context);
  final bool isLandscape = isLandscapeLayout(context);
  if (isTablet && isLandscape) return 22.0;
  if (isTablet) return 24.0;
  if (isLandscape) return 20.0;
  return 22.w;
}

double railLabelSp(BuildContext context) {
  final bool isTablet = isTabletLayout(context);
  final bool isLandscape = isLandscapeLayout(context);
  if (isTablet && isLandscape) return 11.0;
  if (isTablet) return 12.0;
  if (isLandscape) return 9.0;
  return 10.sp;
}

double railVerticalPadding(BuildContext context) {
  final bool isTablet = isTabletLayout(context);
  final bool isLandscape = isLandscapeLayout(context);
  if (isTablet && isLandscape) return 8.0;
  if (isTablet) return 10.0;
  if (isLandscape) return 6.0;
  return 8.h;
}

// ─────────────────────────────────────────────
//  Additional rotation-safe helpers
// ─────────────────────────────────────────────

/// Get safe button size that works in all orientations
double safeButtonSize(BuildContext context, double baseSize) {
  final bool isTablet = isTabletLayout(context);
  final bool isLandscape = isLandscapeLayout(context);
  
  if (isTablet && isLandscape) {
    return baseSize * 1.0;
  } else if (isTablet) {
    return baseSize * 1.1;
  } else if (isLandscape) {
    return baseSize * 0.9;
  }
  return baseSize;
}

/// Get safe icon size that works in all orientations
double safeIconSize(BuildContext context, double baseSize) {
  final bool isTablet = isTabletLayout(context);
  final bool isLandscape = isLandscapeLayout(context);
  
  if (isTablet && isLandscape) {
    return baseSize * 1.05;
  } else if (isTablet) {
    return baseSize * 1.1;
  } else if (isLandscape) {
    return baseSize * 0.95;
  }
  return baseSize;
}

/// Get safe text size that prevents overflow
double safeTextSize(BuildContext context, double baseSize) {
  final bool isTablet = isTabletLayout(context);
  final bool isLandscape = isLandscapeLayout(context);
  
  if (isTablet && isLandscape) {
    return baseSize * 1.0;
  } else if (isTablet) {
    return baseSize * 1.05;
  } else if (isLandscape) {
    return baseSize * 0.9;
  }
  return baseSize;
}
