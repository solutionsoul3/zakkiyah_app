import 'package:flutter/material.dart';
import 'package:zakkiyah_app/Views/home/tile_items_screen.dart';
import 'package:zakkiyah_app/constants/images/images.dart';

class ConversationalPhrasesScreen extends StatelessWidget {
  const ConversationalPhrasesScreen({super.key});

  static const List<TileItemData> _conversationalItems = <TileItemData>[
    TileItemData(title: 'Yes', imagePath: AppImages.conversationalYes),
    TileItemData(title: 'No', imagePath: AppImages.conversationalNo),
    TileItemData(title: 'Break Time', imagePath: AppImages.conversationalBreakTime),
    TileItemData(title: 'Deep Breath', imagePath: AppImages.conversationalDeepBreath),
    TileItemData(title: 'Excuse Me', imagePath: AppImages.conversationalExcuseMe),
    TileItemData(title: 'Finished', imagePath: AppImages.conversationalFinished),
    TileItemData(title: 'Go', imagePath: AppImages.conversationalGo),
    TileItemData(title: 'Good Morning', imagePath: AppImages.conversationalGoodMorning),
    TileItemData(title: 'Good Afternoon', imagePath: AppImages.conversationalGoodAfternoon),
    TileItemData(title: 'Goodbye', imagePath: AppImages.conversationalGoodbye),
    TileItemData(title: 'Happy Birthday', imagePath: AppImages.conversationalHappyBirthday),
    TileItemData(title: 'Hello', imagePath: AppImages.conversationalHello),
    TileItemData(title: 'How Are You?', imagePath: AppImages.conversationalHowAreYou),
    TileItemData(title: 'How Was School?', imagePath: AppImages.conversationalHowWasSchool),
    TileItemData(title: 'How Was Work?', imagePath: AppImages.conversationalHowWasWork),
    TileItemData(title: 'I Understand', imagePath: AppImages.conversationalIUnderstand),
    TileItemData(title: "I Don't Understand", imagePath: AppImages.conversationalIDontUnderstand),
    TileItemData(title: "I Don't Know", imagePath: AppImages.conversationalIDontKnow),
    TileItemData(title: 'I Have Something to Say', imagePath: AppImages.conversationalIHaveSomethingToSay),
    TileItemData(title: "I'm Hungry", imagePath: AppImages.conversationalImHungry),
    TileItemData(title: 'I Missed You', imagePath: AppImages.conversationalIMissedYou),
    TileItemData(title: "I'm Not Feeling Well", imagePath: AppImages.conversationalImNotFeelingWell),
    TileItemData(title: "I'm Sad", imagePath: AppImages.conversationalImSad),
    TileItemData(title: "I'm Tired", imagePath: AppImages.conversationalImTired),
    TileItemData(title: "It's Good to See You", imagePath: AppImages.conversationalItsGoodToSeeYou),
    TileItemData(title: 'Line Up', imagePath: AppImages.conversationalLineUp),
    TileItemData(title: 'My Turn', imagePath: AppImages.conversationalMyTurn),
    TileItemData(title: 'Your Turn', imagePath: AppImages.conversationalYourTurn),
    TileItemData(title: 'Please', imagePath: AppImages.conversationalPlease),
    TileItemData(title: 'Please Ask Question', imagePath: AppImages.conversationalPleaseAskQuestion),
    TileItemData(title: 'Raise Hand', imagePath: AppImages.conversationalRaiseHand),
    TileItemData(title: 'Repeat That Please', imagePath: AppImages.conversationalRepeatThatPlease),
    TileItemData(title: 'Sit', imagePath: AppImages.conversationalSit),
    TileItemData(title: 'Speak Slowly Please', imagePath: AppImages.conversationalSpeakSlowlyPlease),
    TileItemData(title: 'Stand', imagePath: AppImages.conversationalStand),
    TileItemData(title: 'Stop', imagePath: AppImages.conversationalStop),
    TileItemData(title: 'Talk to Teacher', imagePath: AppImages.conversationalTalkToTeacher),
    TileItemData(title: 'Thank You', imagePath: AppImages.conversationalThankYou),
    TileItemData(title: 'Wait', imagePath: AppImages.conversationalWait),
    TileItemData(title: "You're Welcome", imagePath: AppImages.conversationalYoureWelcome),
  ];

  @override
  Widget build(BuildContext context) {
    return const TileItemsScreen(
      title: 'Conversational Phrases',
      defaultAddImagePath: AppImages.conversationalPhrases,
      initialItems: _conversationalItems,
    );
  }
}
