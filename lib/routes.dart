import 'package:flutter/widgets.dart';
import 'screens/more_apps.dart';
import 'screens/about_app.dart';
// import 'screens/datastore.dart';
import 'screens/comparison_screen.dart';
import './screens/donate.dart';

Map<String, WidgetBuilder> routes = {
  '/home': (context) => const ComparisonScreen(),
  '/aboutus': (context) => const AboutApp(),
  // '/datastore': (context) => const Datastore(),
  '/moreapps': (context) => const MoreApps(),
  '/donate': (context) => const Donate(),
};
