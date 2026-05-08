import 'package:flutter/material.dart';
import 'package:zakkiyah_app/Views/home/tile_items_screen.dart';
import 'package:zakkiyah_app/constants/images/images.dart';

class ICUCommunicationScreen extends StatelessWidget {
  const ICUCommunicationScreen({super.key});

  static const List<TileItemData> _icuItems = <TileItemData>[
    TileItemData(title: 'Afraid', imagePath: AppImages.icuAfraid),
    TileItemData(title: 'Anxious', imagePath: AppImages.icuAnxious),
    TileItemData(title: 'Chest Pain', imagePath: AppImages.icuChestPain),
    TileItemData(title: 'I Want a Blanket', imagePath: AppImages.icuIWantABlanket),
    TileItemData(title: 'I Want a Pillow', imagePath: AppImages.icuIWantAPillow),
    TileItemData(title: 'I Want Socks', imagePath: AppImages.icuIWantSocks),
    TileItemData(title: 'Turn Off Light Please', imagePath: AppImages.icuTurnOffLightPlease),
    TileItemData(title: 'Turn On Light Please', imagePath: AppImages.icuTurnOnLightPlease),
  ];

  @override
  Widget build(BuildContext context) {
    return const TileItemsScreen(
      title: 'ICU Communication',
      defaultAddImagePath: AppImages.kidConversation,
      initialItems: _icuItems,
    );
  }
}
