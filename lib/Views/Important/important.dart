import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:zakkiyah_app/Views/home/tile_items_screen.dart';
import 'package:zakkiyah_app/constants/images/images.dart';
import 'package:zakkiyah_app/widgets/app_menu_drawer.dart';
import 'package:zakkiyah_app/widgets/app_screen_header.dart';
import 'package:zakkiyah_app/widgets/responsive_frame.dart';

class ImportantScreen extends StatefulWidget {
  const ImportantScreen({super.key});

  @override
  State<ImportantScreen> createState() => _ImportantScreenState();
}

class _ImportantScreenState extends State<ImportantScreen> {
  bool _isEditing = false;

  static const List<_ImportantCategoryData> _categories = <_ImportantCategoryData>[
    _ImportantCategoryData(
      label: 'Animal',
      imagePath: AppImages.animalCat,
      labelColor: Color(0xFFFFB6C1),
      items: <TileItemData>[
        TileItemData(title: 'Rhino', imagePath: AppImages.animalRhino),
        TileItemData(title: 'Fox', imagePath: AppImages.animalFox),
        TileItemData(title: 'Deer', imagePath: AppImages.animalDeer),
        TileItemData(title: 'Snail', imagePath: AppImages.animalSnail),
        TileItemData(title: 'Hamster', imagePath: AppImages.animalHamster),
        TileItemData(title: 'Alpaca', imagePath: AppImages.animalAlpaca),
        TileItemData(title: 'Bat', imagePath: AppImages.animalBat),
        TileItemData(title: 'Tiger', imagePath: AppImages.animalTiger),
        TileItemData(title: 'Cat', imagePath: AppImages.animalCat),
        TileItemData(title: 'Cheetah', imagePath: AppImages.animalCheetah),
        TileItemData(title: 'Elephant', imagePath: AppImages.animalElephant),
        TileItemData(title: 'Mouse', imagePath: AppImages.animalMouse),
        TileItemData(title: 'Wolf', imagePath: AppImages.animalWolf),
        TileItemData(title: 'Stork', imagePath: AppImages.animalStork),
        TileItemData(title: 'Giraffe', imagePath: AppImages.animalGiraffe),
        TileItemData(title: 'Raccoon', imagePath: AppImages.animalRaccoon),
        TileItemData(title: 'Kiwi', imagePath: AppImages.animalKiwi),
        TileItemData(title: 'Lion', imagePath: AppImages.animalLion),
        TileItemData(title: 'Bear', imagePath: AppImages.animalBear),
        TileItemData(title: 'Turtle', imagePath: AppImages.animalTurtle),
        TileItemData(title: 'Koala', imagePath: AppImages.animalKoala),
        TileItemData(title: 'Owl', imagePath: AppImages.animalOwl),
        TileItemData(title: 'Rabbit', imagePath: AppImages.animalRabbit),
        TileItemData(title: 'Zebra', imagePath: AppImages.animalZebra),
      ],
    ),
    _ImportantCategoryData(
      label: 'Fruits',
      imagePath: AppImages.fruitPineapple,
      labelColor: Color(0xFFFFCF70),
      items: <TileItemData>[
        TileItemData(title: 'Apple', imagePath: AppImages.fruitApple),
        TileItemData(title: 'Avocado', imagePath: AppImages.fruitAvocado),
        TileItemData(title: 'Banana', imagePath: AppImages.fruitBanana),
        TileItemData(title: 'Blueberry', imagePath: AppImages.fruitBlueberry),
        TileItemData(title: 'Cherry', imagePath: AppImages.fruitCherry),
        TileItemData(title: 'Coconut', imagePath: AppImages.fruitCoconut),
        TileItemData(title: 'Grape', imagePath: AppImages.fruitGrape),
        TileItemData(title: 'Kiwi', imagePath: AppImages.fruitKiwi),
        TileItemData(title: 'Lemon', imagePath: AppImages.fruitLemon),
        TileItemData(title: 'Mango', imagePath: AppImages.fruitMango),
        TileItemData(title: 'Melon', imagePath: AppImages.fruitMelon),
        TileItemData(title: 'Orange', imagePath: AppImages.fruitOrange),
        TileItemData(title: 'Pear', imagePath: AppImages.fruitPear),
        TileItemData(title: 'Peach', imagePath: AppImages.fruitPeach),
        TileItemData(title: 'Pineapple', imagePath: AppImages.fruitPineapple),
        TileItemData(title: 'Watermelon', imagePath: AppImages.fruitWatermelon),
      ],
    ),
    _ImportantCategoryData(
      label: 'Vegetable',
      imagePath: AppImages.vegetableBroccoli,
      labelColor: Color(0xFFA9EA9A),
      items: <TileItemData>[
        TileItemData(title: 'Potato', imagePath: AppImages.vegetablePotato),
        TileItemData(title: 'Tomato', imagePath: AppImages.vegetableTomato),
        TileItemData(title: 'Onion', imagePath: AppImages.vegetableOnion),
        TileItemData(title: 'Carrot', imagePath: AppImages.vegetableCarrot),
        TileItemData(title: 'Cabbage', imagePath: AppImages.vegetableCabbage),
        TileItemData(title: 'Cucumber', imagePath: AppImages.vegetableCucumber),
        TileItemData(title: 'Broccoli', imagePath: AppImages.vegetableBroccoli),
        TileItemData(title: 'Spinach', imagePath: AppImages.vegetableSpinach),
        TileItemData(title: 'Eggplant', imagePath: AppImages.vegetableEggplant),
        TileItemData(title: 'Garlic', imagePath: AppImages.vegetableGarlic),
        TileItemData(title: 'Lettuce', imagePath: AppImages.vegetableLettuce),
        TileItemData(title: 'Paprika', imagePath: AppImages.vegetablePaprika),
      ],
    ),
    _ImportantCategoryData(
      label: 'Seasons',
      imagePath: AppImages.seasonSummer,
      labelColor: Color(0xFF87E0EA),
      items: <TileItemData>[
        TileItemData(title: 'Spring', imagePath: AppImages.seasonSpring),
        TileItemData(title: 'Summer', imagePath: AppImages.seasonSummer),
        TileItemData(title: 'Autumn', imagePath: AppImages.seasonAutumn),
        TileItemData(title: 'Winter', imagePath: AppImages.seasonWinter),
      ],
    ),
    _ImportantCategoryData(
      label: 'Weather',
      imagePath: AppImages.weatherSunny,
      labelColor: Color(0xFF80D4F5),
      items: <TileItemData>[
        TileItemData(title: 'Sunny', imagePath: AppImages.weatherSunny),
        TileItemData(title: 'Cloudy', imagePath: AppImages.weatherCloudy),
        TileItemData(title: 'Rainy', imagePath: AppImages.weatherRainy),
        TileItemData(title: 'Snowy', imagePath: AppImages.weatherSnowy),
        TileItemData(title: 'Windy', imagePath: AppImages.weatherWindy),
        TileItemData(title: 'Foggy', imagePath: AppImages.weatherFoggy),
        TileItemData(title: 'Lightning', imagePath: AppImages.weatherLightning),
        TileItemData(title: 'Partly Cloudy', imagePath: AppImages.weatherPartlyCloudy),
        TileItemData(title: 'Tornado', imagePath: AppImages.weatherTornado),
        TileItemData(title: 'Hot', imagePath: AppImages.weatherHot),
        TileItemData(title: 'Cold', imagePath: AppImages.weatherCold),
        TileItemData(title: 'Foresty', imagePath: AppImages.weatherForesty),
      ],
    ),
    _ImportantCategoryData(
      label: 'Months',
      imagePath: AppImages.month,
      labelColor: Color(0xFFB7A5F7),
      items: <TileItemData>[
        TileItemData(title: 'January', imagePath: AppImages.monthJanuary),
        TileItemData(title: 'February', imagePath: AppImages.monthFebruary),
        TileItemData(title: 'March', imagePath: AppImages.monthMarch),
        TileItemData(title: 'April', imagePath: AppImages.monthApril),
        TileItemData(title: 'May', imagePath: AppImages.monthMay),
        TileItemData(title: 'June', imagePath: AppImages.monthJune),
        TileItemData(title: 'July', imagePath: AppImages.monthJuly),
        TileItemData(title: 'August', imagePath: AppImages.monthAugust),
        TileItemData(title: 'September', imagePath: AppImages.monthSeptember),
        TileItemData(title: 'October', imagePath: AppImages.monthOctober),
        TileItemData(title: 'November', imagePath: AppImages.monthNovember),
        TileItemData(title: 'December', imagePath: AppImages.monthDecember),
      ],
    ),
    _ImportantCategoryData(
      label: 'Body Parts',
      imagePath: AppImages.bodyparts,
      labelColor: Color(0xFFFFB590),
      items: <TileItemData>[
        TileItemData(title: 'Body', imagePath: AppImages.bodyPartBody),
        TileItemData(title: 'Head', imagePath: AppImages.bodyPartHead),
        TileItemData(title: 'Hair', imagePath: AppImages.bodyPartHair),
        TileItemData(title: 'Ear', imagePath: AppImages.bodyPartEar),
        TileItemData(title: 'Cheeks', imagePath: AppImages.bodyPartCheeks),
        TileItemData(title: 'Chin', imagePath: AppImages.bodyPartChin),
        TileItemData(title: 'Neck', imagePath: AppImages.bodyPartNeck),
        TileItemData(title: 'Shoulder', imagePath: AppImages.bodyPartShoulder),
        TileItemData(title: 'Chest', imagePath: AppImages.bodyPartChest),
        TileItemData(title: 'Stomach', imagePath: AppImages.bodyPartStomach),
        TileItemData(title: 'Hips', imagePath: AppImages.bodyPartHips),
        TileItemData(title: 'Buttocks', imagePath: AppImages.bodyPartButtocks),
        TileItemData(title: 'Eyes', imagePath: AppImages.bodyPartEyes),
        TileItemData(title: 'Nose', imagePath: AppImages.bodyPartNose),
        TileItemData(title: 'Mouth', imagePath: AppImages.bodyPartMouth),
        TileItemData(title: 'Arm', imagePath: AppImages.bodyPartArm),
        TileItemData(title: 'Elbow', imagePath: AppImages.bodyPartElbow),
        TileItemData(title: 'Hand', imagePath: AppImages.bodyPartHand),
        TileItemData(title: 'Fingers', imagePath: AppImages.bodyPartFingers),
        TileItemData(title: 'Leg', imagePath: AppImages.bodyPartLeg),
        TileItemData(title: 'Knee', imagePath: AppImages.bodyPartKnee),
        TileItemData(title: 'Foot', imagePath: AppImages.bodyPartFoot),
        TileItemData(title: 'Ankle', imagePath: AppImages.bodyPartAnkle),
        TileItemData(title: 'Toes', imagePath: AppImages.bodyPartToes),
      ],
    ),
    _ImportantCategoryData(
      label: 'Sports',
      imagePath: AppImages.sports,
      labelColor: Color(0xFFC6AAFF),
      items: <TileItemData>[
        TileItemData(title: 'American Football', imagePath: AppImages.sportAmericanFootball),
        TileItemData(title: 'Soccer', imagePath: AppImages.sportSoccer),
        TileItemData(title: 'Basket ball', imagePath: AppImages.sportBasketball),
        TileItemData(title: 'Tennis', imagePath: AppImages.sportTennis),
        TileItemData(title: 'Volley ball', imagePath: AppImages.sportVolleyball),
        TileItemData(title: 'Golf', imagePath: AppImages.sportGolf),
        TileItemData(title: 'Hockey', imagePath: AppImages.sportHockey),
        TileItemData(title: 'Karate', imagePath: AppImages.sportKarate),
      ],
    ),
    _ImportantCategoryData(
      label: 'Birds',
      imagePath: AppImages.birds,
      labelColor: Color(0xFFFFCB6B),
      items: <TileItemData>[
        TileItemData(title: 'Parrot', imagePath: AppImages.birdParrot),
        TileItemData(title: 'Eagle', imagePath: AppImages.birdEagle),
        TileItemData(title: 'Pigeon', imagePath: AppImages.birdPigeon),
        TileItemData(title: 'Owl', imagePath: AppImages.birdOwl),
        TileItemData(title: 'Duck', imagePath: AppImages.birdDuck),
        TileItemData(title: 'Flamingo', imagePath: AppImages.birdFlamingo),
        TileItemData(title: 'Humming bird', imagePath: AppImages.birdHummingbird),
        TileItemData(title: 'Wood pecker', imagePath: AppImages.birdWoodpecker),
      ],
    ),
    _ImportantCategoryData(
      label: 'Jobs',
      imagePath: AppImages.jobs,
      labelColor: Color(0xFFBEE08B),
      items: <TileItemData>[
        TileItemData(title: 'Teacher', imagePath: AppImages.jobTeacher),
        TileItemData(title: 'Doctor', imagePath: AppImages.jobDoctor),
        TileItemData(title: 'Fire fighter', imagePath: AppImages.jobFirefighter),
        TileItemData(title: 'Astronaut', imagePath: AppImages.jobAstronaut),
        TileItemData(title: 'Flight Attendant', imagePath: AppImages.jobFlightAttendant),
        TileItemData(title: 'Hair dresser', imagePath: AppImages.jobHairdresser),
        TileItemData(title: 'Journalist', imagePath: AppImages.jobJournalist),
        TileItemData(title: 'Scientist', imagePath: AppImages.jobScientist),
      ],
    ),
    _ImportantCategoryData(
      label: 'Sentences',
      imagePath: AppImages.sentences,
      labelColor: Color(0xFF82D9F5),
      items: <TileItemData>[
        TileItemData(title: 'Please', imagePath: AppImages.sentencePlease),
        TileItemData(title: 'Help', imagePath: AppImages.sentenceHelp),
        TileItemData(title: 'Stop', imagePath: AppImages.sentenceStop),
        TileItemData(title: 'Yes', imagePath: AppImages.sentenceYes),
        TileItemData(title: 'No', imagePath: AppImages.sentenceNo),
        TileItemData(title: 'I Love You', imagePath: AppImages.sentenceILoveYou),
        TileItemData(title: 'More', imagePath: AppImages.sentenceMore),
        TileItemData(title: 'Clean', imagePath: AppImages.sentenceClean),
      ],
    ),
    _ImportantCategoryData(
      label: 'Important',
      imagePath: AppImages.importanttt,
      labelColor: Color(0xFFFF9CB6),
      items: <TileItemData>[
        TileItemData(title: 'Help Me', imagePath: AppImages.importantHelpMe),
        TileItemData(title: 'I am Happy', imagePath: AppImages.importantImHappy),
        TileItemData(title: 'I am Sad', imagePath: AppImages.importantImSad),
        TileItemData(title: 'Later', imagePath: AppImages.importantLater),
        TileItemData(title: "Let's Play", imagePath: AppImages.importantLetsPlay),
        TileItemData(title: 'Thank You', imagePath: AppImages.importantThankYou),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      endDrawer: const AppMenuDrawer(),
      body: SafeArea(
        child: ResponsiveFrame(
          tabletMaxWidth: 1300,
          child: Column(
            children: <Widget>[
              AppScreenHeader(
                topBarHeight: 56,
                topBarPadding: EdgeInsets.symmetric(horizontal: 8.w),
                titleContent: const AppHeaderTitle(
                  segments: <AppHeaderSegment>[
                    AppHeaderSegment(
                      label: 'Important',
                      icon: Icons.star_outline,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      _leftRail(context),
                      const SizedBox(width: 12.0),
                      Expanded(
                        child: LayoutBuilder(
                          builder: (BuildContext context, BoxConstraints constraints) {
                            final int crossAxisCount =
                                responsiveCrossAxisCount(context, width: constraints.maxWidth);
                            final bool isTablet = isTabletLayout(context);
                            final double spacing = isTablet ? 14.0 : 16.0; // Increased spacing for mobile
                            
                            // Calculate to fit all 12 categories in 6 rows (2x6 grid)
                            final int itemCount = _categories.length;
                            final int targetRows = (itemCount / crossAxisCount).ceil();
                            
                            final double availableWidth = constraints.maxWidth;
                            final double availableHeight = constraints.maxHeight;
                            
                            final double totalHorizontalSpacing = spacing * (crossAxisCount - 1);
                            final double totalVerticalSpacing = spacing * (targetRows - 1);
                            
                            final double cellHeight = (availableHeight - totalVerticalSpacing) / targetRows;
                            final double cellWidth = (availableWidth - totalHorizontalSpacing) / crossAxisCount;
                            final double aspectRatio = cellWidth / cellHeight;
                            
                            return GridView.builder(
                              itemCount: itemCount,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: crossAxisCount,
                                crossAxisSpacing: spacing,
                                mainAxisSpacing: spacing,
                                childAspectRatio: aspectRatio,
                              ),
                              itemBuilder: (_, int index) {
                                final _ImportantCategoryData category = _categories[index];
                                return _categoryCard(category);
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _leftRail(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      width: railWidth(context),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1A1A1A) : const Color(0xFFE3E3E3),
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(height: railVerticalPadding(context)),
            _railIcon(
              context: context,
              icon: Icons.arrow_back,
              label: 'Back',
              onTap: () => Navigator.pop(context),
            ),
            SizedBox(height: railVerticalPadding(context)),
            _railIcon(
              context: context,
              icon: Icons.add_box_outlined,
              label: 'Add',
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Add action is available in category items')),
                );
              },
            ),
            SizedBox(height: railVerticalPadding(context)),
            _railIcon(
              context: context,
              icon: _isEditing ? Icons.check_circle_outline : Icons.edit_note_outlined,
              label: _isEditing ? 'Done' : 'Edit',
              onTap: () {
                setState(() => _isEditing = !_isEditing);
              },
            ),
            SizedBox(height: railVerticalPadding(context) * 2.5),
            _railIcon(
              context: context,
              icon: Icons.undo,
              label: 'Undo',
              onTap: () {},
            ),
            SizedBox(height: railVerticalPadding(context) * 2.5),
            _railIcon(
              context: context,
              icon: Icons.redo,
              label: 'Redo',
              onTap: () {},
            ),
            SizedBox(height: railVerticalPadding(context) * 1.5),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.chevron_left, size: railIconSize(context) * 0.9, color: Colors.black54),
                SizedBox(width: 6.0),
                Text(
                  '1/1',
                  style: TextStyle(
                    fontSize: railLabelSp(context),
                    color: isDark ? Colors.white : Colors.black,
                  ),
                ),
                SizedBox(width: 6.0),
                Icon(Icons.chevron_right, size: railIconSize(context) * 0.9, color: Colors.black54),
              ],
            ),
            SizedBox(height: railVerticalPadding(context)),
          ],
        ),
      ),
    );
  }

  Widget _railIcon({
    required BuildContext context,
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8.r),
      child: Container(
        width: railIconContainerW(context),
        padding: EdgeInsets.symmetric(vertical: railVerticalPadding(context)),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF2A2A2A) : const Color(0xFFF2F2F2),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Column(
          children: <Widget>[
            Icon(icon, size: railIconSize(context), color: isDark ? Colors.white70 : Colors.black54),
            SizedBox(height: 3.0),
            Text(
              label,
              style: TextStyle(
                fontSize: railLabelSp(context),
                color: isDark ? Colors.white : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _categoryCard(_ImportantCategoryData data) {
    final Color lightTileBackground = Color.lerp(data.labelColor, Colors.white, 0.82)!;
    
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final bool isTablet = isTabletLayout(context);
        final double tileHeight = constraints.maxHeight;
        final double tileWidth = constraints.maxWidth;
        
        // Sizes based on actual tile dimensions
        final double borderRadius = isTablet ? 20.0 : 24.0;
        final double innerRadius = isTablet ? 18.0 : 22.0;
        
        // SMALLER ribbon sizes - takes less space
        final double ribbonTop = 16.0; // Reduced from 20px to 16px
        final double ribbonHeight = 28.0; // Reduced from 32px to 28px
        final double ribbonWidth = (tileWidth * 0.65).clamp(90.0, 135.0);
        final double ribbonPaddingLeft = 8.0;
        final double ribbonPaddingRight = 22.0;
        final double ribbonTextSize = (tileHeight * 0.090).clamp(10.0, 15.0);
        
        // Image - MORE space allocated
        final double availableImageHeight = tileHeight - ribbonTop - 2.0;
        final double imagePadding = 3.0; // Minimal padding
        // Image fills MORE available space - 80% instead of 70%
        final double imageSize = (availableImageHeight * 0.80).clamp(35.0, 120.0);
        final double iconSize = imageSize * 0.45;
        
        return InkWell(
          onTap: () {
            Get.to(
              () => TileItemsScreen(
                title: data.label,
                defaultAddImagePath: data.imagePath,
                initialItems: data.items,
                breadcrumbTitles: <String>['Home', 'Important', data.label],
              ),
            );
          },
          borderRadius: BorderRadius.circular(borderRadius),
          child: Stack(
            clipBehavior: Clip.none,
            children: <Widget>[
              Positioned.fill(
                top: ribbonTop,
                child: Container(
                  decoration: BoxDecoration(
                    color: lightTileBackground,
                    borderRadius: BorderRadius.circular(innerRadius),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(imagePadding),
                    child: Center(
                      child: Image.asset(
                        data.imagePath,
                        width: imageSize,
                        height: imageSize,
                        fit: BoxFit.contain,
                        errorBuilder: (_, __, ___) =>
                            Icon(Icons.image_outlined, size: iconSize, color: Colors.blueGrey),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 0,
                left: 0,
                child: ClipPath(
                  clipper: _RibbonClipper(),
                  child: Container(
                    width: ribbonWidth,
                    height: ribbonHeight,
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(left: ribbonPaddingLeft, right: ribbonPaddingRight),
                    color: data.labelColor,
                    child: Text(
                      data.label,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: ribbonTextSize,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _ImportantCategoryData {
  const _ImportantCategoryData({
    required this.label,
    required this.imagePath,
    required this.labelColor,
    required this.items,
  });

  final String label;
  final String imagePath;
  final Color labelColor;
  final List<TileItemData> items;
}

class _RibbonClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final Path path = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width - 20, 0)
      ..lineTo(size.width, size.height / 2)
      ..lineTo(size.width - 20, size.height)
      ..lineTo(0, size.height)
      ..close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
