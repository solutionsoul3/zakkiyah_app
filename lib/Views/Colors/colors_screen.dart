import 'package:flutter/material.dart';
import 'package:zakkiyah_app/Views/home/tile_items_screen.dart';
import 'package:zakkiyah_app/constants/images/images.dart';

class ColorsCategoryScreen extends StatelessWidget {
  const ColorsCategoryScreen({super.key});

  static const List<TileItemData> _colorItems = <TileItemData>[
    TileItemData(title: 'Black', imagePath: AppImages.colorBlack),
    TileItemData(title: 'Blue', imagePath: AppImages.colorBlue),
    TileItemData(title: 'Green', imagePath: AppImages.colorGreen),
    TileItemData(title: 'Orange', imagePath: AppImages.colorOrange),
    TileItemData(title: 'Pink', imagePath: AppImages.colorPink),
    TileItemData(title: 'Purple', imagePath: AppImages.colorPurple),
    TileItemData(title: 'Red', imagePath: AppImages.colorRed),
    TileItemData(title: 'Yellow', imagePath: AppImages.colorYellow),
  ];

  @override
  Widget build(BuildContext context) {
    return const TileItemsScreen(
      title: 'Colors',
      defaultAddImagePath: AppImages.colors,
      initialItems: _colorItems,
    );
  }
}
