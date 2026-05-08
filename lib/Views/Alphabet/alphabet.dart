import 'package:flutter/material.dart';
import 'package:zakkiyah_app/Views/home/tile_items_screen.dart';
import 'package:zakkiyah_app/constants/images/images.dart';

class AlphabetScreen extends StatelessWidget {
  const AlphabetScreen({super.key});

  static const List<TileItemData> _alphabetItems = <TileItemData>[
    TileItemData(title: 'A', imagePath: AppImages.alphabetA),
    TileItemData(title: 'B', imagePath: AppImages.alphabetB),
    TileItemData(title: 'C', imagePath: AppImages.alphabetC),
    TileItemData(title: 'D', imagePath: AppImages.alphabetD),
    TileItemData(title: 'E', imagePath: AppImages.alphabetE),
    TileItemData(title: 'F', imagePath: AppImages.alphabetF),
    TileItemData(title: 'G', imagePath: AppImages.alphabetG),
    TileItemData(title: 'H', imagePath: AppImages.alphabetH),
    TileItemData(title: 'I', imagePath: AppImages.alphabetI),
    TileItemData(title: 'J', imagePath: AppImages.alphabetJ),
    TileItemData(title: 'K', imagePath: AppImages.alphabetK),
    TileItemData(title: 'L', imagePath: AppImages.alphabetL),
    TileItemData(title: 'M', imagePath: AppImages.alphabetM),
    TileItemData(title: 'N', imagePath: AppImages.alphabetN),
    TileItemData(title: 'O', imagePath: AppImages.alphabetO),
    TileItemData(title: 'P', imagePath: AppImages.alphabetP),
    TileItemData(title: 'Q', imagePath: AppImages.alphabetQ),
    TileItemData(title: 'R', imagePath: AppImages.alphabetR),
    TileItemData(title: 'S', imagePath: AppImages.alphabetS),
    TileItemData(title: 'T', imagePath: AppImages.alphabetT),
    TileItemData(title: 'U', imagePath: AppImages.alphabetU),
    TileItemData(title: 'V', imagePath: AppImages.alphabetV),
    TileItemData(title: 'W', imagePath: AppImages.alphabetW),
    TileItemData(title: 'X', imagePath: AppImages.alphabetX),
    TileItemData(title: 'Y', imagePath: AppImages.alphabetY),
    TileItemData(title: 'Z', imagePath: AppImages.alphabetZ),
  ];

  @override
  Widget build(BuildContext context) {
    return const TileItemsScreen(
      title: 'Alphabet',
      defaultAddImagePath: AppImages.alphabet,
      initialItems: _alphabetItems,
    );
  }
}
