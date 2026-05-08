import 'package:flutter/material.dart';
import 'package:zakkiyah_app/Views/home/tile_items_screen.dart';
import 'package:zakkiyah_app/constants/images/images.dart';

class EmergencyResponseScreen extends StatelessWidget {
  const EmergencyResponseScreen({super.key});

  static const List<TileItemData> _emergencyItems = <TileItemData>[
    TileItemData(title: 'Allergy', imagePath: AppImages.emergencyAllergy),
    TileItemData(title: 'Blood Pressure', imagePath: AppImages.emergencyBloodPressure),
    TileItemData(title: 'Depression Medication', imagePath: AppImages.emergencyDepressionMedication),
    TileItemData(title: "I Can't Breath", imagePath: AppImages.emergencyICantBreath),
    TileItemData(title: 'I Have Belly Pain', imagePath: AppImages.emergencyIHaveBellyPain),
    TileItemData(title: 'Something is Wrong', imagePath: AppImages.emergencySomethingIsWrong),
    TileItemData(title: 'Swallowing', imagePath: AppImages.emergencySwallowing),
    TileItemData(title: 'Weakness', imagePath: AppImages.emergencyWeakness),
  ];

  @override
  Widget build(BuildContext context) {
    return const TileItemsScreen(
      title: 'Emergency Response',
      defaultAddImagePath: AppImages.emergencyResponse,
      initialItems: _emergencyItems,
    );
  }
}
