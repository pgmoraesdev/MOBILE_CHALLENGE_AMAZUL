import 'package:flutter/material.dart';

import '../models/topic_model.dart';
import 'home_screen.dart';

class CategoryForm extends StatefulWidget {
  final Topic? topic;

  const CategoryForm({super.key, this.topic});

  @override
  State<CategoryForm> createState() => _CategoryFormState();
}

class _CategoryFormState extends State<CategoryForm> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.topic?.titulo ?? '';
    _descriptionController.text = widget.topic?.descricao ?? '';
  }

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
      appBar: AppBar(
        title: const Header(),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(28),
          child: Padding(
            padding: const EdgeInsets.only(left: 16, bottom: 8),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                widget.topic == null ? 'Criar um novo tema' : 'Editar tema',
              ),
            ),
          ),
        ),
      ),
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
                child: Text(widget.topic == null ? 'Salvar tema' : 'Salvar alterações'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
