import 'package:flutter/material.dart';
import 'package:lucide_flutter/lucide_flutter.dart';

// componente header
class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text('Damy');
  }
}

// componente menu navigation
class Menu extends StatelessWidget {
  final int atual;

  const Menu({
    super.key,
    required this.atual,
  });

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      selectedIndex: atual,
      destinations: const [
        NavigationDestination(
          icon: Icon(LucideIcons.sun),
          label: 'Meu dia',
        ),
        NavigationDestination(
          icon: Icon(LucideIcons.gamepad2),
          label: 'Jogos',
        ),
        NavigationDestination(
          icon: Icon(LucideIcons.mic),
          label: 'Palestras',
        ),
        NavigationDestination(
          icon: Icon(LucideIcons.settings),
          label: 'Tema',
        ),
      ],
    );
  }
}

// TELA DE FATO
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Header(),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Você está vivendo com tecnologia nuclear?',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),

      bottomNavigationBar: const Menu(atual: 0),
    );
  }
}