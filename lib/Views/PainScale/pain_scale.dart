import 'package:flutter/material.dart';
import 'package:zakkiyah_app/Views/home/tile_items_screen.dart';
import 'package:zakkiyah_app/constants/images/images.dart';

class PainScaleScreen extends StatelessWidget {
  const PainScaleScreen({super.key});

  static const List<TileItemData> _painScaleItems = <TileItemData>[
    TileItemData(title: 'Aching', imagePath: AppImages.painAching),
    TileItemData(title: 'Burning', imagePath: AppImages.painBurning),
    TileItemData(title: 'Mild Pain', imagePath: AppImages.painMild),
    TileItemData(title: 'Moderate Pain', imagePath: AppImages.painModerate),
    TileItemData(title: 'No Pain', imagePath: AppImages.painNone),
    TileItemData(title: 'Severe Pain', imagePath: AppImages.painSevere),
    TileItemData(title: 'Slight Pain', imagePath: AppImages.painSlight),
    TileItemData(title: 'Worst Pain Possible', imagePath: AppImages.painWorstPossible),
  ];

  @override
  Widget build(BuildContext context) {
    return const TileItemsScreen(
      title: 'Pain Scale',
      defaultAddImagePath: AppImages.planSchedule,
      initialItems: _painScaleItems,
    );
  }
}
