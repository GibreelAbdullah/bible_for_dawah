import 'dart:io';
import 'dart:typed_data';

import 'package:bible_for_dawah/classes/contradictions.dart';
import 'package:bible_for_dawah/constants/app_constants.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// final databaseProvider = Provider<DatabaseAccess>((ref) => DatabaseAccess());

class DatabaseAccess {
  Future<Database> openDatabaseConnection() async {
    var path = join(await getDatabasesPath(), "bible.db");
    var exists = await databaseExists(path);

    if (!exists) {
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {}
      ByteData data = await rootBundle.load(join("assets", "bible.db"));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      await File(path).writeAsBytes(bytes, flush: true);
    }
    Database db = await openDatabase(path);
    return db;
  }

  Future<Contradictions> getContradictions() async {
    final Contradictions contradictions = Contradictions();
    Database db = await databaseConnection;
    List<Map> mapOfWords = await db.rawQuery(
        'select m.meta_id, b.id bible_id, m.header, m.comment , b.book, b.chapter, b.verse starting_verse, l.number_of_verses from bible b inner join links l on l.start_id = b.id inner join links_meta m on l.links_id = m.meta_id');
    int position = -1;
    int itemCount = 1;

    for (Map element in mapOfWords) {
      element.forEach(
        (key, value) {
          if (key == 'meta_id') {
            position = contradictions.id.indexOf(value);
            if (position == -1) {
              itemCount = 1;
              contradictions.id.add(value);
              contradictions.itemCount.add(value);
              contradictions.header.add('');
              contradictions.comment.add('');
              contradictions.bibleId.add([]);
              contradictions.books.add([]);
              contradictions.chapters.add([]);
              contradictions.startingVerses.add([]);
              contradictions.numberOfVerses.add([]);

              position = contradictions.id.length - 1;
            } else {
              contradictions.itemCount[position] = ++itemCount;
            }
          } else if (key == 'header') {
            contradictions.header[position] = value;
          } else if (key == 'comment') {
            contradictions.comment[position] = value;
          } else if (key == 'bible_id') {
            contradictions.bibleId[position].add(value);
          } else if (key == 'book') {
            contradictions.books[position].add(value);
          } else if (key == 'chapter') {
            contradictions.chapters[position].add(value);
          } else if (key == 'starting_verse') {
            contradictions.startingVerses[position].add(value);
          } else if (key == 'number_of_verses') {
            contradictions.numberOfVerses[position].add(value);
          }
        },
      );
    }
    return contradictions;
  }

  Future<ContradictionResult> getChapter(
      int start, int count, String book, int chap) async {
    ContradictionResult contradictionResult = ContradictionResult();
    Database db = await databaseConnection;
    List<Map> mapOfWords = await db.rawQuery(
      'select verse, content, CASE WHEN id >= ? and id<= ? then 1 else 0 end as highlight from bible where book = ? and chapter = ?',
      [
        start,
        start + count,
        book,
        chap,
      ],
    );

    for (Map element in mapOfWords) {
      element.forEach(
        (key, value) {
          if (key == 'verse') {
            contradictionResult.verse.add(value);
          } else if (key == 'content') {
            contradictionResult.content.add(value);
          } else if (key == 'highlight') {
            contradictionResult.highlight.add(value);
          }
          // contradictionResultList.add(contradictionResult);
        },
      );
    }

    // contradictionResultList = mapOfWords.;
    return contradictionResult;
  }
}
