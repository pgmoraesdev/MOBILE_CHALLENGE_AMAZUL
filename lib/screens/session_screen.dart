import 'package:flutter/material.dart';

import 'home_screen.dart';

class SessionScreen extends StatelessWidget {
  const SessionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Header()),
      bottomNavigationBar: const Menu(atual: 2),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Sessão de jogo',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),
            const Text('Comece uma partida e teste seus conhecimentos.'),
          ],
        ),
      ),
    );
  }
}
