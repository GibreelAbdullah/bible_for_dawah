import 'dart:math';

import 'package:bible_for_dawah/classes/contradictions.dart';
import 'package:bible_for_dawah/common/drawer.dart';
import 'package:bible_for_dawah/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class ComparisonScreen extends ConsumerWidget {
  const ComparisonScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return Scaffold(
      drawer: const CommonDrawer(currentScreen: 'ComparisonScreen'),
      appBar: AppBar(
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: Icon(Icons.settings),
          ),
        ],
        title: FutureBuilder<Contradictions>(
          future: databaseObject.getContradictions(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return DropDown(
                snapshot: snapshot.data,
              );
            }
            return const Text('Loading...');
          },
        ),
      ),
      body: Stack(
        children: [
          PageView(
            // controller: _pageController,
            onPageChanged: (value) {
              context
                  .read(selectedContradictionProvider.notifier)
                  .updateSelectedContradiction(index: value);
            },
            children: getBibleChapter(
                watch(selectedContradictionProvider).references),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              color: const Color(0XEE292c31),
              height: 60,
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: watch(selectedContradictionProvider).rowCount,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      style: ButtonStyle(
                          overlayColor: watch(selectedContradictionProvider)
                                      .selectedReferenceIndex ==
                                  index
                              ? MaterialStateProperty.all(
                                  const Color(0XFFE0C097))
                              : MaterialStateProperty.all(
                                  const Color(0XFF3b3e45)),
                          backgroundColor: watch(selectedContradictionProvider)
                                      .selectedReferenceIndex ==
                                  index
                              ? MaterialStateProperty.all(
                                  const Color(0XFFE0C097))
                              : MaterialStateProperty.all(
                                  const Color(0XFF3b3e45)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40.0),
                          ))),
                      onPressed: () {},
                      child: Text(
                        watch(selectedContradictionProvider)
                            .references[index]
                            .reference,
                        style: const TextStyle(color: Color(0XFFe74c2d)),
                      ),
                    ),
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

///To get all the chapters which have the selected contradiction
List<Widget> getBibleChapter(List<ReferenceClass> references) {
  List<Widget> contradictionScreeen = [];

  for (ReferenceClass reference in references) {
    contradictionScreeen.add(
      FutureBuilder<ContradictionResult>(
        future: databaseObject.getChapter(reference.startingId,
            reference.verseCount, reference.book, reference.chapter),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Padding(
              padding: const EdgeInsets.only(left: 8, right: 8),
              child: BibleText(
                snapshot: snapshot.data,
              ),
            );
          }
          return const Text('Loading...');
        },
      ),
    );
  }

  return contradictionScreeen;
}

//The main body of the contradiction screen. Contains the verses of the chapter selected.
class BibleText extends StatefulWidget {
  const BibleText({
    Key? key,
    required this.snapshot,
  }) : super(key: key);
  final ContradictionResult? snapshot;

  @override
  _BibleTextState createState() => _BibleTextState();
}

class _BibleTextState extends State<BibleText> {
  @override
  Widget build(BuildContext context) {
    ItemScrollController _itemScrollController = ItemScrollController();
    int scrollIndex = 500;
    SchedulerBinding.instance!.addPostFrameCallback(
      (_) {
        if (_itemScrollController.isAttached) {
          _itemScrollController.scrollTo(
              index: max(scrollIndex - 2, 0),
              duration: const Duration(milliseconds: 300));
        }
      },
    );
    return ScrollablePositionedList.builder(
      itemScrollController: _itemScrollController,
      itemCount: widget.snapshot!.verse.length,
      itemBuilder: (context, index) {
        if (widget.snapshot!.highlight[index] == 1) {
          scrollIndex = min(scrollIndex, index);
        }
        return Table(
          columnWidths: const {
            0: FlexColumnWidth(1),
            1: FlexColumnWidth(15),
          },
          children: [
            TableRow(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 2.5, right: 8.0),
                  child: Text(
                    widget.snapshot!.verse[index].toString(),
                    textAlign: TextAlign.end,
                    style: TextStyle(
                      color: widget.snapshot!.highlight[index] == 1
                          ? Theme.of(context).textTheme.bodyText1!.color
                          : Colors.grey,
                    ),
                  ),
                ),
                SelectableText(
                  index == widget.snapshot!.verse.length - 1
                      ? widget.snapshot!.content[index] + "\n\n\n\n\n\n\n\n"
                      : widget.snapshot!.content[index] + '\n',
                  style: TextStyle(
                    fontSize: 22,
                    color: widget.snapshot!.highlight[index] == 1
                        ? Theme.of(context).textTheme.bodyText1!.color
                        : null,
                  ),
                ),
              ],
            )
          ],
        );
      },
    );
  }
}

class DropDown extends StatefulWidget {
  const DropDown({Key? key, this.snapshot}) : super(key: key);
  final Contradictions? snapshot;
  @override
  _DropDownState createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {
  String dropdownValue = '0';
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      isExpanded: true,
      items: dropDownFromList(widget.snapshot!.header),
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward),
      iconSize: 24,
      style: const TextStyle(color: Colors.white),
      underline: Container(
        height: 2,
        color: Colors.white70,
      ),
      onChanged: (String? newValue) {
        setState(
          () {
            dropdownValue = newValue!;
            context
                .read(selectedContradictionProvider.notifier)
                .updateSelectedContradiction(
                  index: 0,
                  rowCount:
                      widget.snapshot!.itemCount[int.parse(dropdownValue)],
                  references: getReference(
                    widget.snapshot!,
                    int.parse(dropdownValue),
                  ),
                );
          },
        );
      },
    );
  }

  List<DropdownMenuItem<String>> dropDownFromList(List<String> headers) {
    List<DropdownMenuItem<String>> ddm = [];
    for (int i = 0; i < headers.length; i++) {
      ddm.add(
        DropdownMenuItem(
          value: i.toString(),
          child: Text(
            headers[i],
          ),
        ),
      );
    }
    return ddm;
  }

  List<ReferenceClass> getReference(Contradictions cont, int index) {
    int rowCount = cont.books[index].length;
    String ref;
    String b;
    int chap;
    int start;
    int count;

    List<ReferenceClass> r = [];

    for (int i = 0; i < rowCount; i++) {
      start = cont.bibleId[index][i];
      count = cont.numberOfVerses[index][i];
      b = cont.books[index][i];
      chap = cont.chapters[index][i];
      ref = cont.books[index][i] +
          ' ' +
          cont.chapters[index][i].toString() +
          ':' +
          cont.startingVerses[index][i].toString();
      if (count != 1) {
        ref =
            ref + '-' + (cont.startingVerses[index][i] + count - 1).toString();
      }
      r.add(ReferenceClass(
          reference: ref,
          book: b,
          chapter: chap,
          startingId: start,
          verseCount: count));
    }
    return r;
  }
}
