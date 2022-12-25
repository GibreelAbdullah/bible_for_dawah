import 'package:bible_for_dawah/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants/app_constants.dart';
import '../common/drawer.dart';

class Donate extends StatelessWidget {
  const Donate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 56,
        title: Text(
          donateScreenTitle,
          style: Theme.of(context).textTheme.headline6,
        ),
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        iconTheme: Theme.of(context).iconTheme,
      ),
      drawer: const CommonDrawer(currentScreen: donateScreenTitle),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(padding: EdgeInsets.all(10)),
            Text(
              'Thanks for considering to donate.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyText1,
            ),
            Text(
              '''There are millions who are facing a devastating decade of crisis and previously unimaginable hardship.
Kindly donate to them.''',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyText1,
            ),
            ElevatedButton(
              onPressed: () {
                launch('https://donations.islamic-relief.com/');
              },
              child: Text(
                'Donate through IslamicRelief',
                style: Theme.of(context).textTheme.bodyText1,
              ),
              style: ElevatedButton.styleFrom(),
            ),
            const Center(
              child: Text('Or any other charity of your choice.'),
            ),
            const Padding(
              padding: EdgeInsets.all(20),
            ),
            Text(
              'مَّن ذَا ٱلَّذِى يُقْرِضُ ٱللَّهَ قَرْضًا حَسَنًۭا فَيُضَـٰعِفَهُۥ لَهُۥٓ أَضْعَافًۭا كَثِيرَةًۭ ۚ وَٱللَّهُ يَقْبِضُ وَيَبْصُۜطُ وَإِلَيْهِ تُرْجَعُونَ',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyText1,
            ),
            Text(
              'Who will lend to Allah a good loan which Allah will multiply many times over? It is Allah alone who decreases and increases wealth. And to Him you will all be returned.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyText1,
            )
          ],
        ),
      ),
    );
  }
}
