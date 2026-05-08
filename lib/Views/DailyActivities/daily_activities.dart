import 'package:flutter/material.dart';
import 'package:zakkiyah_app/Views/home/tile_items_screen.dart';
import 'package:zakkiyah_app/constants/images/images.dart';

class DailyActivitiesScreen extends StatelessWidget {
  const DailyActivitiesScreen({super.key});

  static const List<TileItemData> _dailyActivitiesItems = <TileItemData>[
    TileItemData(title: 'Excuse Me', imagePath: AppImages.dailyActivitiesExcuseMe),
    TileItemData(title: 'Good Afternoon', imagePath: AppImages.dailyActivitiesGoodAfternoon),
    TileItemData(title: 'Goodbye', imagePath: AppImages.dailyActivitiesGoodbye),
    TileItemData(title: 'Help Me Please', imagePath: AppImages.dailyActivitiesHelpMePlease),
    TileItemData(title: "I'm Thirsty", imagePath: AppImages.dailyActivitiesImThirsty),
    TileItemData(title: 'Stop', imagePath: AppImages.dailyActivitiesStop),
    TileItemData(title: 'Wait', imagePath: AppImages.dailyActivitiesWait),
    TileItemData(title: "You're Welcome", imagePath: AppImages.dailyActivitiesYourWelcome),
  ];

  @override
  Widget build(BuildContext context) {
    return const TileItemsScreen(
      title: 'Daily Activities',
      defaultAddImagePath: AppImages.dailyActivities,
      initialItems: _dailyActivitiesItems,
    );
  }
}
