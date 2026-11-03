import 'package:flutter/material.dart';

import '../models/topic_model.dart';
import '../repositories/topic_repository.dart';
import 'home_screen.dart';
import 'topic_form_screen.dart';

class TopicListScreen extends StatefulWidget {
  const TopicListScreen({super.key});

  @override
  State<TopicListScreen> createState() => _TopicListScreenState();
}

class _TopicListScreenState extends State<TopicListScreen> {
  final _repository = TopicRepository.instance;

  List<Topic> get topics => _repository.topics;

  Future<void> _createTopic() async {
    final topic = await Navigator.push<Topic>(
      context,
      MaterialPageRoute(builder: (context) => const CategoryForm()),
    );

    if (topic != null && mounted) {
      setState(() => _repository.add(topic));
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(content: Text('Tema "${topic.titulo}" criado com sucesso.')),
        );
    }
  }

  Future<void> _editTopic(int index) async {
    final updatedTopic = await Navigator.push<Topic>(
      context,
      MaterialPageRoute(
        builder: (context) => CategoryForm(topic: topics[index]),
      ),
    );

    if (updatedTopic != null && mounted) {
      setState(() => _repository.update(index, updatedTopic));
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(content: Text('Tema "${updatedTopic.titulo}" atualizado.')),
        );
    }
  }

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
              'Temas',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),
            const Text(
              'Explore temas ligados à tecnologia nuclear. Eles vão orientar '
              'os jogos e outros conteúdos do aplicativo.',
            ),
            const SizedBox(height: 16),
            Expanded(
              child: topics.isEmpty
                  ? const Center(child: Text('Nenhum tema criado ainda.'))
                  : ListView.separated(
                      itemCount: topics.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 8),
                      itemBuilder: (context, index) {
                        final topic = topics[index];
                        return Card(
                          child: ListTile(
                            title: Text(topic.titulo),
                            subtitle: Text(topic.descricao),
                            trailing: IconButton(
                              tooltip: 'Editar tema',
                              icon: const Icon(Icons.edit_outlined),
                              onPressed: () => _editTopic(index),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
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
