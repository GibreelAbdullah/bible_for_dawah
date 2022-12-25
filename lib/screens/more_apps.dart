import 'package:bible_for_dawah/constants/app_constants.dart';
import 'package:flutter/material.dart';
import '../constants/app_constants.dart';
import '../common/drawer.dart';
import 'package:url_launcher/url_launcher.dart';

class MoreApps extends StatelessWidget {
  const MoreApps({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 56,
        title: Text(
          moreApps,
          style: Theme.of(context).textTheme.headline6,
        ),
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        iconTheme: Theme.of(context).iconTheme,
      ),
      drawer:const CommonDrawer(currentScreen: moreApps),
      body: Column(
        children: [
          const Padding(padding: EdgeInsets.all(8)),
          ListTile(
            title: Text(
              'Hans Wehr Dictionary',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            leading: Image.asset("assets/hans.png", fit: BoxFit.cover),
            subtitle: Text(
              'A concise Arabic English dictionary',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            onTap: () {
              launch(hansWehrAndroidLink);
            },
          ),
          const Padding(padding: EdgeInsets.all(8)),
          ListTile(
            title: Text(
              'Lane\'s Lexicon',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            leading: Image.asset("assets/lane.png", fit: BoxFit.cover),
            subtitle: Text(
              'A comprehensive Arabic English dictionary',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            onTap: () {
              launch(lanesLexiconAndroidLink);
            },
          ),
        ],
      ),
    );
  }
}
