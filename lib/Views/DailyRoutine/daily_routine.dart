import 'package:flutter/material.dart';
import 'package:zakkiyah_app/Views/home/tile_items_screen.dart';
import 'package:zakkiyah_app/constants/images/images.dart';

class DailyRoutineScreen extends StatelessWidget {
  const DailyRoutineScreen({super.key});

  static const List<TileItemData> _dailyRoutineItems = <TileItemData>[
    TileItemData(title: 'Brushing Teeth', imagePath: AppImages.dailyRoutineBrushingTeeth),
    TileItemData(title: 'Drinking Water', imagePath: AppImages.dailyRoutineDrinkingWater),
    TileItemData(title: 'Eating Breakfast', imagePath: AppImages.dailyRoutineEatingBreakfast),
    TileItemData(title: 'Eating Lunch', imagePath: AppImages.dailyRoutineEatingLunch),
    TileItemData(title: 'Getting Dressed', imagePath: AppImages.dailyRoutineGettingDressed),
    TileItemData(title: 'Going for a Walk', imagePath: AppImages.dailyRoutineGoingForAWalk),
    TileItemData(title: 'Going to School', imagePath: AppImages.dailyRoutineGoingToSchool),
    TileItemData(title: 'Listening Music', imagePath: AppImages.dailyRoutineListeningMusic),
    TileItemData(title: 'Making the Bed', imagePath: AppImages.dailyRoutineMakingTheBed),
    TileItemData(title: 'Meditation', imagePath: AppImages.dailyRoutineMeditation),
    TileItemData(title: 'New Bag', imagePath: AppImages.dailyRoutineNewBag),
    TileItemData(title: 'Pasta', imagePath: AppImages.dailyRoutinePasta),
    TileItemData(title: 'Pencil', imagePath: AppImages.dailyRoutinePencil),
    TileItemData(title: 'Playing', imagePath: AppImages.dailyRoutinePlaying),
    TileItemData(title: 'Playing with Friend', imagePath: AppImages.dailyRoutinePlayingWithFriend),
    TileItemData(title: 'Reading', imagePath: AppImages.dailyRoutineReading),
    TileItemData(title: 'Salad', imagePath: AppImages.dailyRoutineSalad),
    TileItemData(title: 'Sleeping', imagePath: AppImages.dailyRoutineSleeping),
    TileItemData(title: 'Studying', imagePath: AppImages.dailyRoutineStudying),
    TileItemData(title: 'Taking a Bath', imagePath: AppImages.dailyRoutineTakingABath),
    TileItemData(title: 'Toys', imagePath: AppImages.dailyRoutineToys),
    TileItemData(title: 'Waking Up', imagePath: AppImages.dailyRoutineWakingUp),
    TileItemData(title: 'Want a Fish', imagePath: AppImages.dailyRoutineWantAFish),
    TileItemData(title: 'Want Fruits', imagePath: AppImages.dailyRoutineWantFruits),
  ];

  @override
  Widget build(BuildContext context) {
    return const TileItemsScreen(
      title: 'Daily Routine',
      defaultAddImagePath: AppImages.dailyRoutine,
      initialItems: _dailyRoutineItems,
    );
  }
}
