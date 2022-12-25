import 'package:flutter_riverpod/flutter_riverpod.dart';

///Contains the actual bible text
class ContradictionResult {
  List<int> verse = [];
  List<String> content = [];
  List<int> highlight = [];
}

/// Class contains the list of contradictions to be populated in the dropdown.
/// Doesn't contain the body of the bible text
class Contradictions {
  List<int> id = [];
  List<int> itemCount = [];
  List<String> header = [];
  List<String> comment = [];
  List<List<int>> bibleId = [];
  List<List<String>> books = [];
  List<List<int>> chapters = [];
  List<List<int>> startingVerses = [];
  List<List<int>> numberOfVerses = [];
}

///Class contains the contradiction selected from the dropdown.
///rowCount holds the number of references in the selected contradiction
///SelectedReferenceIndex holds the index of the currently shown bible text
///References holds the bible chapter and verse references
class SelectedContradiction {
  final int rowCount;
  final List<ReferenceClass> references;
  final int selectedReferenceIndex;

  SelectedContradiction({
    required this.rowCount,
    required this.references,
    required this.selectedReferenceIndex,
  });

  SelectedContradiction copyWith(
      {int? newIndex, List<ReferenceClass>? newReference, int? newRowCount}) {
    return SelectedContradiction(
      selectedReferenceIndex: newIndex ?? selectedReferenceIndex,
      references: newReference ?? references,
      rowCount: newRowCount ?? rowCount,
    );
  }
}

class ReferenceClass {
  final String reference;
  final String book;
  final int chapter;
  final int startingId;
  final int verseCount;

  ReferenceClass({
    required this.reference,
    required this.book,
    required this.chapter,
    required this.startingId,
    required this.verseCount,
  });
}

class SelectedContradictionNotifier
    extends StateNotifier<SelectedContradiction> {
  SelectedContradictionNotifier()
      : super(
          SelectedContradiction(
            references: [
              ReferenceClass(
                  reference: "Luke 3:23-38",
                  book: "Luke",
                  chapter: 3,
                  startingId: 25008,
                  verseCount: 16),
              ReferenceClass(
                  reference: "Matt 1:2-16",
                  book: "Matt",
                  chapter: 1,
                  startingId: 23108,
                  verseCount: 15)
            ],
            rowCount: 2,
            selectedReferenceIndex: 0,
          ),
        );

  updateSelectedContradiction(
          {int? index, List<ReferenceClass>? references, int? rowCount}) =>
      state = state.copyWith(
          newIndex: index, newReference: references, newRowCount: rowCount);
}

final StateNotifierProvider<SelectedContradictionNotifier,
        SelectedContradiction> selectedContradictionProvider =
    StateNotifierProvider<SelectedContradictionNotifier, SelectedContradiction>(
        (ref) {
  return SelectedContradictionNotifier();
});
