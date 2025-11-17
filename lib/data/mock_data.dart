import '../models/category.dart';
import '../models/flashcard.dart';
import '../models/flashcard_set.dart';

// Lista kategorii
List<Category> mockCategories = [
  Category(id: 'c1', name: 'Liceum'),
  Category(id: 'c2', name: 'Studia'),
  Category(id: 'c3', name: 'Inne'),
];

// Lista zestawów fiszek
List<FlashcardSet> mockSets = [
  FlashcardSet(
    id: 's1',
    title: 'Biologia - komórka',
    description: 'Podstawy budowy komórki.',
    categoryId: 'c1',
    flashcards: [
      Flashcard(
        id: 'f1-1',
        question: 'Jakie organella zawiera komórka roślinna?',
        answer:
            '1. Ściana komórkowa\n2. Chloroplasty\n3. Wakuola (duża centralna)\n4. Plastydy (inne niż chloroplasty)',
      ),
      Flashcard(
        id: 'f1-2',
        question:
            'Jakie są trzy główne elementy budowy każdej komórki eukariotycznej?',
        answer: '1. Błona komórkowa\n2. Cytoplazma\n3. Jądro komórkowe',
      ),
      Flashcard(
        id: 'f1-3',
        question: 'Czym jest mitoza?',
        answer: 'Procesem podziału komórki, w wyniku którego powstają dwie komórki potomne o identycznej liczbie chromosomów.',
      ),
    ],
  ),
  FlashcardSet(
    id: 's2',
    title: 'Bazy danych - SQL podstawy',
    description: 'Podstawowe zapytania SQL.',
    categoryId: 'c2',
    flashcards: [
      Flashcard(
        id: 'f2-1',
        question: 'Jakim poleceniem wybierasz dane z tabeli?',
        answer: 'SELECT * FROM nazwa_tabeli;',
      ),
    ],
  ),
];