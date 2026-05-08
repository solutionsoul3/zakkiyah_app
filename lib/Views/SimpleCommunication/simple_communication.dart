import 'package:flutter/material.dart';
import 'package:zakkiyah_app/Views/home/tile_items_screen.dart';
import 'package:zakkiyah_app/constants/images/images.dart';

class SimpleCommunicationScreen extends StatelessWidget {
  const SimpleCommunicationScreen({super.key});

  static const List<TileItemData> _simpleItems = <TileItemData>[
    TileItemData(title: 'Go', imagePath: AppImages.simpleGo),
    TileItemData(title: 'Help', imagePath: AppImages.simpleHelp),
    TileItemData(title: "I Don't Know", imagePath: AppImages.simpleIDontKnow),
    TileItemData(title: 'I Have Something to Say', imagePath: AppImages.simpleIHaveSomethingToSay),
    TileItemData(title: 'No', imagePath: AppImages.simpleNo),
    TileItemData(title: 'Slow Down', imagePath: AppImages.simpleSlowDown),
    TileItemData(title: 'Stop', imagePath: AppImages.simpleStop),
    TileItemData(title: 'Yes', imagePath: AppImages.simpleYes),
  ];

  @override
  Widget build(BuildContext context) {
    return const TileItemsScreen(
      title: 'Simple Communication',
      defaultAddImagePath: AppImages.simpleCommunication,
      initialItems: _simpleItems,
    );
  }
}
