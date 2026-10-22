import 'package:flutter/material.dart';
import 'package:projetox_mobile/screens/topic_list_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Início'),
      ),
      body: Center(
        child: ElevatedButton.icon(
          onPressed: () {
            Navigator.push(
              context, 
              MaterialPageRoute(
                builder: (context) => const TopicListScreen(),
              ),
            );
          },
          icon: const Icon(Icons.list),
          label: const Text('Temas cadastrados'),
        )
      )
    );
  }
}
