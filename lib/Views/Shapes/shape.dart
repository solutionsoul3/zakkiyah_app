import 'package:flutter/material.dart';
import 'package:zakkiyah_app/Views/home/tile_items_screen.dart';
import 'package:zakkiyah_app/constants/images/images.dart';

class ShapeScreen extends StatelessWidget {
  const ShapeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const TileItemsScreen(
      title: 'Shapes',
      defaultAddImagePath: AppImages.shapeSquare,
      initialItems: <TileItemData>[
        TileItemData(title: 'Square', imagePath: AppImages.shapeSquare),
        TileItemData(title: 'Triangle', imagePath: AppImages.shapeTriangle),
        TileItemData(title: 'Octagon', imagePath: AppImages.shapeOctagon),
        TileItemData(title: 'Arrow', imagePath: AppImages.shapeArrow),
        TileItemData(title: 'Ovel', imagePath: AppImages.shapeOval),
        TileItemData(title: 'Hexagon', imagePath: AppImages.shapeHexagon),
        TileItemData(title: 'Rectangle', imagePath: AppImages.shapeRectangle),
        TileItemData(
          title: 'Parallelogram',
          imagePath: AppImages.shapeParallelogram,
        ),
        TileItemData(title: 'Circle', imagePath: AppImages.shapeCircle),
        TileItemData(title: 'Crescent', imagePath: AppImages.shapeCrescent),
        TileItemData(title: 'Cross', imagePath: AppImages.shapeCross),
        TileItemData(title: 'Pentagon', imagePath: AppImages.shapePentagon),
        TileItemData(title: 'Rhombus', imagePath: AppImages.shapeRhombus),
        TileItemData(title: 'Star', imagePath: AppImages.shapeStar),
        TileItemData(title: 'Trapizium', imagePath: AppImages.shapeTrapizium),
        TileItemData(title: 'Tropezoid', imagePath: AppImages.shapeTropezoid),
      ],
    );
  }
}
