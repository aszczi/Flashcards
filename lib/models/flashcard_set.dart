import 'flashcard.dart';

class FlashcardSet {
  final String id;
  final String title;
  final String description;
  final String categoryId;
  final List<Flashcard> flashcards;

  FlashcardSet({
    required this.id,
    required this.title,
    required this.description,
    required this.categoryId,
    required this.flashcards,
  });
}