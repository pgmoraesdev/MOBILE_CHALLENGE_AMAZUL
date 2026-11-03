import 'package:flutter/material.dart';

import '../models/topic_model.dart';

class CategoryForm extends StatefulWidget {
  const CategoryForm({super.key});

  @override
  State<CategoryForm> createState() => _CategoryFormState();
}

class _CategoryFormState extends State<CategoryForm> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _saveTopic() {
    if (!_formKey.currentState!.validate()) return;

    Navigator.pop(
      context,
      Topic(
        titulo: _titleController.text.trim(),
        descricao: _descriptionController.text.trim(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Criar um novo tema')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Nome do tema'),
                validator: (value) => value == null || value.trim().isEmpty
                    ? 'Informe o nome do tema'
                    : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Descrição'),
                minLines: 3,
                maxLines: 5,
                validator: (value) => value == null || value.trim().isEmpty
                    ? 'Informe uma descrição'
                    : null,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _saveTopic,
                child: const Text('Salvar tema'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
