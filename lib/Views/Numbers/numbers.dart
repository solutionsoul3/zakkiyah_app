import 'package:flutter/material.dart';
import 'package:zakkiyah_app/Views/home/tile_items_screen.dart';
import 'package:zakkiyah_app/constants/images/images.dart';

class NumbersScreen extends StatelessWidget {
  const NumbersScreen({super.key});

  static const List<TileItemData> _numberItems = <TileItemData>[
    TileItemData(title: '0', imagePath: AppImages.number0),
    TileItemData(title: '1', imagePath: AppImages.number1),
    TileItemData(title: '2', imagePath: AppImages.number2),
    TileItemData(title: '3', imagePath: AppImages.number3),
    TileItemData(title: '4', imagePath: AppImages.number4),
    TileItemData(title: '5', imagePath: AppImages.number5),
    TileItemData(title: '6', imagePath: AppImages.number6),
    TileItemData(title: '7', imagePath: AppImages.number7),
    TileItemData(title: '8', imagePath: AppImages.number8),
    TileItemData(title: '9', imagePath: AppImages.number9),
    TileItemData(title: 'Plus', imagePath: AppImages.numberPlus),
    TileItemData(title: 'Minus', imagePath: AppImages.numberMinus),
    TileItemData(title: 'Multiply', imagePath: AppImages.numberMultiply),
    TileItemData(title: 'Division', imagePath: AppImages.numberDivision),
    TileItemData(title: 'Equal', imagePath: AppImages.numberEqual),
  ];

  @override
  Widget build(BuildContext context) {
    return const TileItemsScreen(
      title: 'Numbers',
      defaultAddImagePath: AppImages.numbers,
      initialItems: _numberItems,
    );
  }
}
