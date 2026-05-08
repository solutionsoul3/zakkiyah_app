import 'package:flutter/material.dart';
import 'package:zakkiyah_app/Views/home/tile_items_screen.dart';
import 'package:zakkiyah_app/constants/images/images.dart';

class SignLanguageScreen extends StatelessWidget {
  const SignLanguageScreen({super.key});

  static const List<TileItemData> _signLanguageItems = <TileItemData>[
    TileItemData(title: 'A', imagePath: AppImages.signLanguageA),
    TileItemData(title: 'B', imagePath: AppImages.signLanguageB),
    TileItemData(title: 'C', imagePath: AppImages.signLanguageC),
    TileItemData(title: 'D', imagePath: AppImages.signLanguageD),
    TileItemData(title: 'E', imagePath: AppImages.signLanguageE),
    TileItemData(title: 'F', imagePath: AppImages.signLanguageF),
    TileItemData(title: 'G', imagePath: AppImages.signLanguageG),
    TileItemData(title: 'H', imagePath: AppImages.signLanguageH),
    TileItemData(title: 'I', imagePath: AppImages.signLanguageI),
    TileItemData(title: 'J', imagePath: AppImages.signLanguageJ),
    TileItemData(title: 'K', imagePath: AppImages.signLanguageK),
    TileItemData(title: 'L', imagePath: AppImages.signLanguageL),
    TileItemData(title: 'M', imagePath: AppImages.signLanguageM),
    TileItemData(title: 'N', imagePath: AppImages.signLanguageN),
    TileItemData(title: 'O', imagePath: AppImages.signLanguageO),
    TileItemData(title: 'P', imagePath: AppImages.signLanguageP),
    TileItemData(title: 'Q', imagePath: AppImages.signLanguageQ),
    TileItemData(title: 'R', imagePath: AppImages.signLanguageR),
    TileItemData(title: 'S', imagePath: AppImages.signLanguageS),
    TileItemData(title: 'T', imagePath: AppImages.signLanguageT),
    TileItemData(title: 'U', imagePath: AppImages.signLanguageU),
    TileItemData(title: 'V', imagePath: AppImages.signLanguageV),
    TileItemData(title: 'W', imagePath: AppImages.signLanguageW),
    TileItemData(title: 'X', imagePath: AppImages.signLanguageX),
    TileItemData(title: 'Y', imagePath: AppImages.signLanguageY),
    TileItemData(title: 'Z', imagePath: AppImages.signLanguageZ),
  ];

  @override
  Widget build(BuildContext context) {
    return const TileItemsScreen(
      title: 'Sign Language',
      defaultAddImagePath: AppImages.signLanguage,
      initialItems: _signLanguageItems,
    );
  }
}
