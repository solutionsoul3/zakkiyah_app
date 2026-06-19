import 'package:flutter/material.dart';

class MenuDrawerButton extends StatelessWidget {
  const MenuDrawerButton({super.key, this.size});

  final double? size;

  @override
  Widget build(BuildContext context) {
    final bool isTablet = MediaQuery.sizeOf(context).shortestSide >= 600;
    final double iconSize = size ?? (isTablet ? 26.0 : 24.0);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          final ScaffoldState? scaffold = Scaffold.maybeOf(context);
          if (scaffold != null && scaffold.hasEndDrawer) {
            scaffold.openEndDrawer();
          }
        },
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
          child: Icon(Icons.menu, size: iconSize, color: Colors.white),
        ),
      ),
    );
  }
}
