import 'package:flutter/material.dart';
import '../data/mock_data.dart';
import '../models/flashcard.dart';
import '../models/flashcard_set.dart';
import 'create_set_success_screen.dart';

// Klasa pomocnicza do zarządzania kontrolerami fiszek
class FlashcardControllers {
  final TextEditingController questionController = TextEditingController();
  final TextEditingController answerController = TextEditingController();
}

class CreateSetScreen2 extends StatefulWidget {
  final FlashcardSet draftSet;
  const CreateSetScreen2({Key? key, required this.draftSet}) : super(key: key);

  @override
  _CreateSetScreen2State createState() => _CreateSetScreen2State();
}

class _CreateSetScreen2State extends State<CreateSetScreen2> {
  // Lista kontrolerów dla dynamicznie dodawanych fiszek
  List<FlashcardControllers> _flashcardControllers = [];

  @override
  void initState() {
    super.initState();
    // Zacznij z jedną pustą fiszką
    _addFlashcardFields();
  }

  void _addFlashcardFields() {
    setState(() {
      _flashcardControllers.add(FlashcardControllers());
    });
  }

  void _finishCreatingSet() {
    // 1. Stwórz listę fiszek z kontrolerów
    List<Flashcard> newFlashcards = [];
    for (int i = 0; i < _flashcardControllers.length; i++) {
      final q = _flashcardControllers[i].questionController.text;
      final a = _flashcardControllers[i].answerController.text;

      if (q.isNotEmpty && a.isNotEmpty) {
        newFlashcards.add(
          Flashcard(id: 'f${mockSets.length + 1}-$i', question: q, answer: a),
        );
      }
    }

    if (newFlashcards.isEmpty) {
      // Nie pozwól na zapisanie pustego zestawu
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Dodaj przynajmniej jedną fiszkę')),
      );
      return;
    }

    // 2. Stwórz finalny obiekt zestawu
    final newSet = FlashcardSet(
      id: 's${mockSets.length + 1}', // Nowe ID
      title: widget.draftSet.title,
      description: widget.draftSet.description,
      categoryId: widget.draftSet.categoryId,
      flashcards: newFlashcards,
    );

    // 3. Dodaj go do "bazy danych"
    mockSets.add(newSet);

    // 4. Przejdź do ekranu sukcesu
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => CreateSetSuccessScreen(createdSet: newSet)),
      (route) => route.isFirst, // Wyczyść stos nawigacji do ekranu głównego
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.draftSet.title)),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: _flashcardControllers.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Fiszka ${index + 1}', style: const TextStyle(fontWeight: FontWeight.bold)),
                        TextFormField(
                          controller: _flashcardControllers[index].questionController,
                          decoration: const InputDecoration(labelText: 'Pytanie'),
                          maxLines: 2,
                        ),
                        TextFormField(
                          controller: _flashcardControllers[index].answerController,
                          decoration: const InputDecoration(labelText: 'Odpowiedź'),
                          maxLines: 3,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextButton.icon(
                  icon: const Icon(Icons.add),
                  label: const Text('Dodaj kolejną fiszkę'),
                  onPressed: _addFlashcardFields,
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: _finishCreatingSet,
                  child: const Text('Zakończ'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}