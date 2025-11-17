import 'package:flutter/material.dart';
import '../data/mock_data.dart';
import '../models/category.dart';
import '../models/flashcard_set.dart';
import 'create_set_screen_1.dart';
import 'learn_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Funkcja do usuwania zestawu
  void _deleteSet(String setId) {
    setState(() {
      mockSets.removeWhere((set) => set.id == setId);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Zestaw usunięty')),
    );
  }

  // Funkcja do dodawania nowej kategorii (wywoływana z okna dialogowego)
  void _addCategory(String name) {
    setState(() {
      mockCategories.add(Category(id: 'c${mockCategories.length + 1}', name: name));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cognito'),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Filtr kategorii
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'Kategoria',
                border: OutlineInputBorder(),
              ),
              value: null,
              items: mockCategories.map((category) {
                return DropdownMenuItem(
                  value: category.id,
                  child: Text(category.name),
                );
              }).toList(),
              onChanged: (value) {
                // TODO: Logika filtrowania
              },
            ),
            const SizedBox(height: 10),
            // Wyszukiwarka
            const TextField(
              decoration: InputDecoration(
                labelText: 'Wyszukaj fiszkę',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            // Przyciski Ulubione / Moje / Zapisane
            ToggleButtons(
              isSelected: const [true, false, false], // Przykładowe zaznaczenie
              onPressed: (index) {
                // TODO: Logika przełączania
              },
              children: const [
                Padding(padding: EdgeInsets.symmetric(horizontal: 16), child: Text('Ulubione')),
                Padding(padding: EdgeInsets.symmetric(horizontal: 16), child: Text('Moje')),
                Padding(padding: EdgeInsets.symmetric(horizontal: 16), child: Text('Zapisane')),
              ],
            ),
            const SizedBox(height: 20),
            // Lista zestawów
            Expanded(
              child: ListView.builder(
                itemCount: mockSets.length,
                itemBuilder: (context, index) {
                  final set = mockSets[index];
                  // Znajdź nazwę kategorii
                  final categoryName = mockCategories
                      .firstWhere((cat) => cat.id == set.categoryId, orElse: () => Category(id: '?', name: 'Brak'))
                      .name;

                  return Card(
                    color: Colors.grey[200],
                    elevation: 0,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      title: Text(set.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text('Kategoria: $categoryName\n${set.flashcards.length} pytania'),
                      isThreeLine: true,
                      onTap: () {
                        // Przejdź do ekranu nauki
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LearnScreen(flashcardSet: set),
                          ),
                        );
                      },
                      // Menu do usuwania/edycji
                      trailing: PopupMenuButton(
                        itemBuilder: (context) => [
                          const PopupMenuItem(value: 'edit', child: Text('Edytuj')),
                          const PopupMenuItem(value: 'delete', child: Text('Usuń')),
                        ],
                        onSelected: (value) {
                          if (value == 'delete') {
                            _deleteSet(set.id);
                          } else if (value == 'edit') {
                            // TODO: Nawigacja do ekranu edycji
                          }
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          // Przejdź do ekranu tworzenia zestawu
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CreateSetScreen1(
                onCategoryAdded: _addCategory, // Przekaż funkcję
              ),
            ),
          ).then((_) {
            // Odśwież widok po powrocie, gdyby dodano nowy zestaw
            setState(() {});
          });
        },
      ),
    );
  }
}