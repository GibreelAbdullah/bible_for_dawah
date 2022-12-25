import 'dart:core';

// import 'package:bible_for_dawah/classes/contradictions.dart';
import 'package:bible_for_dawah/classes/database.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sqflite/sqflite.dart';

// final Contradictions contradictions = Contradictions();

// final selectedContradiction = StateProvider<SelectedContradiction>(
//   (ref) {
//     SelectedContradiction s = SelectedContradiction();
//     s.rowCount = 1;
//     s.reference = ['Select entry for Drop Down'];
//     s.selectedReferenceIndex = 0;
//     return s;
//   },
// );

final DatabaseAccess databaseObject = DatabaseAccess();
final Future<Database> databaseConnection =
    DatabaseAccess().openDatabaseConnection();

const String homeScreenTitle = 'Home';
const String databaseTitle = 'Database';

const String settingsScreenTitle = 'Settings';
const String aboutAppScreenTitle = 'About App';
const String moreApps = 'More Apps';
const String donateScreenTitle = 'Donate';

const String hansWehrAndroidLink =
    'https://play.google.com/store/apps/details?id=com.muslimtechnet.hanswehr';
const String lanesLexiconAndroidLink =
    'https://play.google.com/store/apps/details?id=com.muslimtechnet.lanelexicon';
