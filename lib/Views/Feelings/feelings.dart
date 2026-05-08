import 'package:flutter/material.dart';
import 'package:zakkiyah_app/Views/home/tile_items_screen.dart';
import 'package:zakkiyah_app/constants/images/images.dart';

class FeelingsScreen extends StatelessWidget {
  const FeelingsScreen({super.key});

  static const List<TileItemData> _feelingItems = <TileItemData>[
    TileItemData(title: 'Angry', imagePath: AppImages.feelingAngry),
    TileItemData(title: 'Confused', imagePath: AppImages.feelingConfused),
    TileItemData(title: 'Content', imagePath: AppImages.feelingContent),
    TileItemData(title: 'Excited', imagePath: AppImages.feelingExcited),
    TileItemData(title: 'Happy', imagePath: AppImages.feelingHappy),
    TileItemData(title: 'Hurt', imagePath: AppImages.feelingHurt),
    TileItemData(title: 'Sad', imagePath: AppImages.feelingSad),
    TileItemData(title: 'Scared', imagePath: AppImages.feelingScared),
    TileItemData(title: 'Silly', imagePath: AppImages.feelingSilly),
    TileItemData(title: 'Tired', imagePath: AppImages.feelingTired),
    TileItemData(title: 'Very Happy', imagePath: AppImages.feelingVeryHappy),
    TileItemData(title: 'Worried', imagePath: AppImages.feelingWorried),
  ];

  @override
  Widget build(BuildContext context) {
    return const TileItemsScreen(
      title: 'Feelings',
      defaultAddImagePath: AppImages.feelings,
      initialItems: _feelingItems,
    );
  }
}
