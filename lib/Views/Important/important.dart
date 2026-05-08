import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:zakkiyah_app/Views/home/tile_items_screen.dart';
import 'package:zakkiyah_app/constants/images/images.dart';
import 'package:zakkiyah_app/widgets/app_menu_drawer.dart';
import 'package:zakkiyah_app/widgets/app_screen_header.dart';
import 'package:zakkiyah_app/widgets/responsive_frame.dart';

class ImportantScreen extends StatelessWidget {
  const ImportantScreen({super.key});

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
                titleContent: Row(
                  children: <Widget>[
                    Icon(Icons.home, size: 18.w),
                    SizedBox(width: 6.w),
                    Text('Home', style: TextStyle(fontSize: 20.sp)),
                    SizedBox(width: 12.w),
                    Icon(Icons.label_outline, size: 18.w),
                    SizedBox(width: 6.w),
                    Text('Important', style: TextStyle(fontSize: 20.sp)),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(10.w),
                  child: Row(
                    children: <Widget>[
                      _leftRail(context),
                      SizedBox(width: 10.w),
                      Expanded(
                        child: LayoutBuilder(
                          builder: (BuildContext context, BoxConstraints constraints) {
                            final int crossAxisCount = constraints.maxWidth > 900 ? 3 : 2;
                            return GridView.builder(
                              itemCount: _categories.length,
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: crossAxisCount,
                                crossAxisSpacing: 14.w,
                                mainAxisSpacing: 14.h,
                                childAspectRatio: 1.0,
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
      width: 92.w,
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1A1A1A) : const Color(0xFFE3E3E3),
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Column(
        children: <Widget>[
          SizedBox(height: 8.h),
          _railIcon(
            context: context,
            icon: Icons.arrow_back,
            label: 'Back',
            onTap: () => Navigator.pop(context),
          ),
          SizedBox(height: 8.h),
          _railIcon(
            context: context,
            icon: Icons.search,
            label: 'Search',
            onTap: () {},
          ),
          SizedBox(height: 8.h),
          _railIcon(
            context: context,
            icon: Icons.menu_book,
            label: 'Tutorial',
            onTap: () {},
          ),
          const Spacer(),
          _railIcon(
            context: context,
            icon: Icons.arrow_back_ios,
            label: 'Prev',
            onTap: () {},
          ),
          SizedBox(height: 8.h),
          _railIcon(
            context: context,
            icon: Icons.arrow_forward_ios,
            label: 'Next',
            onTap: () {},
          ),
          SizedBox(height: 8.h),
        ],
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
        width: 64.w,
        padding: EdgeInsets.symmetric(vertical: 8.h),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF2A2A2A) : const Color(0xFFF2F2F2),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Column(
          children: <Widget>[
            Icon(icon, size: 22.w, color: isDark ? Colors.white70 : Colors.black54),
            SizedBox(height: 3.h),
            Text(
              label,
              style: TextStyle(
                fontSize: 10.sp,
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
      borderRadius: BorderRadius.circular(20.r),
      child: Stack(
        clipBehavior: Clip.none,
        children: <Widget>[
          Positioned.fill(
            top: 24.h,
            child: Container(
              decoration: BoxDecoration(
                color: lightTileBackground,
                borderRadius: BorderRadius.circular(18.r),
              ),
              child: Padding(
                padding: EdgeInsets.fromLTRB(10.w, 10.h, 10.w, 8.h),
                child: Center(
                  child: Image.asset(
                    data.imagePath,
                    width: 65.w,
                    height: 65.h,
                    fit: BoxFit.contain,
                    errorBuilder: (_, __, ___) =>
                        Icon(Icons.image_outlined, size: 28.w, color: Colors.blueGrey),
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
                width: 120.w,
                height: 38.h,
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(left: 14.w, right: 26.w),
                color: data.labelColor,
                child: Text(
                  data.label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
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
