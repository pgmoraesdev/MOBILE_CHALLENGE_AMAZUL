import 'package:flutter/material.dart';

import '../models/topic_model.dart';
import 'home_screen.dart';
import 'topic_form_screen.dart';

class TopicListScreen extends StatefulWidget {
  const TopicListScreen({super.key});

  @override
  State<TopicListScreen> createState() => _TopicListScreenState();
}

class _TopicListScreenState extends State<TopicListScreen> {
  final List<Topic> topics = [];

  Future<void> _createTopic() async {
    final topic = await Navigator.push<Topic>(
      context,
      MaterialPageRoute(builder: (context) => const CategoryForm()),
    );

    if (topic != null && mounted) {
      setState(() => topics.add(topic));
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(content: Text('Tema "${topic.titulo}" criado com sucesso.')),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Temas')),
      body: topics.isEmpty
          ? const Center(child: Text('Nenhum tema criado ainda.'))
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: topics.length,
              separatorBuilder: (context, index) => const SizedBox(height: 8),
              itemBuilder: (context, index) {
                final topic = topics[index];
                return Card(
                  child: ListTile(
                    title: Text(topic.titulo),
                    subtitle: Text(topic.descricao),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _createTopic,
        icon: const Icon(Icons.add),
        label: const Text('Novo tema'),
      ),
      bottomNavigationBar: const Menu(atual: 3),
    );
  }
}
