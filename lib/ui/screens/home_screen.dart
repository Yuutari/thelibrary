import 'package:flutter/material.dart';
import '../../data/characters_repository.dart';
import '../../data/open_library_service.dart';
import 'characters_list_screen.dart';
import 'settings_screen.dart';

class HomeScreen extends StatefulWidget {
  final CharactersRepository charactersRepository;
  final OpenLibraryService openLibraryService;
  final VoidCallback onLogout;

  const HomeScreen({
    super.key,
    required this.charactersRepository,
    required this.openLibraryService,
    required this.onLogout,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  void _onSelectDrawer(int index) {
    setState(() {
      _selectedIndex = index;
    });
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    Widget body;
    String title;

    switch (_selectedIndex) {
      case 0:
        title = 'Главная';
        body = _buildDashboard();
        break;
      case 1:
        title = 'Грешники Limbus Company';
        body = CharactersListScreen(
          repository: widget.charactersRepository,
          openLibraryService: widget.openLibraryService,
        );
        break;
      case 2:
        title = 'Настройки';
        body = SettingsScreen(onLogout: widget.onLogout);
        break;
      default:
        title = 'Главная';
        body = _buildDashboard();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFF141217),
              ),
              child: Center(
                child: Text(
                  'Library of Limbus',
                  style: TextStyle(
                    color: Color(0xFFE4C07A),
                    fontSize: 20,
                    letterSpacing: 2,
                  ),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Главная'),
              selected: _selectedIndex == 0,
              onTap: () => _onSelectDrawer(0),
            ),
            ListTile(
              leading: const Icon(Icons.people),
              title: const Text('Грешники'),
              selected: _selectedIndex == 1,
              onTap: () => _onSelectDrawer(1),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Настройки'),
              selected: _selectedIndex == 2,
              onTap: () => _onSelectDrawer(2),
            ),
          ],
        ),
      ),
      body: body,
    );
  }

  Widget _buildDashboard() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF0B0A0D),
            Color(0xFF141217),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            Center(
              child: Column(
                children: [
                  const Text(
                    'Library of Limbus',
                    style: TextStyle(
                      color: Color(0xFFE4C07A),
                      fontSize: 24,
                      letterSpacing: 2,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Неофициальная вики по ProjectMoon',
                    style: TextStyle(
                      color: Colors.grey[300],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Card(
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: ListTile(
                leading: const Icon(Icons.people),
                title: const Text('Грешники Limbus Company'),
                subtitle:
                    const Text('13 грешников, основанных на классической литературе.'),
                onTap: () => _onSelectDrawer(1),
              ),
            ),
            Card(
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: const ListTile(
                leading: Icon(Icons.menu_book),
                title: Text('Литературные источники'),
                subtitle: Text(
                  'Внизу страниц персонажей показаны книги из OpenLibrary.',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}