import 'package:flutter/material.dart';
import 'package:zakkiyah_app/Views/home/tile_items_screen.dart';
import 'package:zakkiyah_app/constants/images/images.dart';

class MentalHealthScreen extends StatelessWidget {
  const MentalHealthScreen({super.key});

  static const List<TileItemData> _mentalHealthItems = <TileItemData>[
    TileItemData(title: 'Angry', imagePath: AppImages.mentalAngry),
    TileItemData(title: 'Confused', imagePath: AppImages.mentalConfused),
    TileItemData(title: 'Dissapointed', imagePath: AppImages.mentalDissapointed),
    TileItemData(title: 'Embarassed', imagePath: AppImages.mentalEmbarassed),
    TileItemData(title: 'Hurt', imagePath: AppImages.mentalHurt),
    TileItemData(title: 'Lonely', imagePath: AppImages.mentalLonely),
    TileItemData(title: 'Upset', imagePath: AppImages.mentalUpset),
    TileItemData(title: 'Worried', imagePath: AppImages.mentalWorried),
  ];

  @override
  Widget build(BuildContext context) {
    return const TileItemsScreen(
      title: 'Mental Health',
      defaultAddImagePath: AppImages.mentalHealth,
      initialItems: _mentalHealthItems,
    );
  }
}
