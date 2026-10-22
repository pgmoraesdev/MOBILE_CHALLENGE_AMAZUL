import 'package:flutter/material.dart';
import 'package:projetox_mobile/screens/details_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> tarefas = [];

  void adicionarTarefa() {
    setState(() {
      tarefas.add('Nova atividade ${tarefas.length + 1}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Projeto X',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SecondScreen(),
              )
            );
          },
          child: const Text('Ir para a outra tela'),
        )        
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: adicionarTarefa,
        icon: const Icon(Icons.add),
        label: const Text('Nova tarefa'),
      ),
    );
  }
}
