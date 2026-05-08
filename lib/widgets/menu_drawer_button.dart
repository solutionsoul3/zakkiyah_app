import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MenuDrawerButton extends StatelessWidget {
  const MenuDrawerButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final ScaffoldState? scaffold = Scaffold.maybeOf(context);
        if (scaffold != null && scaffold.hasEndDrawer) {
          scaffold.openEndDrawer();
        }
      },
      child: Icon(Icons.menu, size: 24.w, color: Colors.white),
    );
  }
}
