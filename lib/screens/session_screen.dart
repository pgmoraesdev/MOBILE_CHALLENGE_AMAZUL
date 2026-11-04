import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../repositories/session_repository.dart';
import 'home_screen.dart';

class SessionScreen extends StatefulWidget {
  const SessionScreen({super.key});

  @override
  State<SessionScreen> createState() => _SessionScreenState();
}

class _SessionScreenState extends State<SessionScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _participantsController = TextEditingController();
  final _repository = SessionRepository.instance;

  @override
  void dispose() {
    _nameController.dispose();
    _participantsController.dispose();
    super.dispose();
  }

  void _createSession() {
    if (!_formKey.currentState!.validate()) return;

    try {
      setState(() {
        _repository.create(
          name: _nameController.text.trim(),
          participants: int.parse(_participantsController.text),
        );
      });
    } on StateError catch (error) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(error.message)));
      return;
    }

    _nameController.clear();
    _participantsController.clear();
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Header()),
      bottomNavigationBar: const Menu(atual: 2),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Sessão de jogo',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 8),
              const Text('Comece uma partida e teste seus conhecimentos.'),
              const SizedBox(height: 24),
              TextFormField(
                controller: _nameController,
                validator: (value) => value == null || value.trim().isEmpty
                    ? 'Informe o nome da sessão'
                    : null,
                decoration: const InputDecoration(labelText: 'Nome da sessão'),
                textCapitalization: TextCapitalization.sentences,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _participantsController,
                validator: (value) {
                  final quantity = int.tryParse(value ?? '');
                  return quantity == null || quantity <= 0
                      ? 'Informe uma quantidade maior que zero'
                      : null;
                },
                decoration: const InputDecoration(
                  labelText: 'Quantidade de participantes',
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                textInputAction: TextInputAction.done,
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _createSession,
                  child: const Text('Gerar partida'),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Partidas criadas',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              if (_repository.sessions.isEmpty)
                const Text('Nenhuma partida criada ainda.'),
              for (final session in _repository.sessions)
                Card(
                  child: ListTile(
                    title: Text(session.name),
                    subtitle: Text(
                      'Participantes: ${session.participants}\n'
                      'Código da sala: ${session.code}',
                    ),
                    isThreeLine: true,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
