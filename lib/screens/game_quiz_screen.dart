import 'package:flutter/material.dart';
import 'home_screen.dart';

// PERGUNTAS DO QUIZ
class QuizQuestion {
  final String question;
  final List<String> options;
  final int correct; // posição da opção certa na lista, incia no 0
  final String explanation;

  const QuizQuestion({
    required this.question,
    required this.options,
    required this.correct,
    required this.explanation,
  });
}

const quizQuestions = [
  QuizQuestion(
    question: 'Qual destes usa tecnologia nuclear para salvar vidas?',
    options: ['Radioterapia contra o câncer', 'Micro-ondas', 'Lâmpada de LED', 'Ventilador'],
    correct: 0,
    explanation: 'A medicina nuclear ajuda a diagnosticar e tratar doenças.',
  ),
  QuizQuestion(
    question: 'Uma usina nuclear produz principalmente…',
    options: ['Gasolina', 'Eletricidade', 'Plástico', 'Água mineral'],
    correct: 1,
    explanation: 'Usinas nucleares, como as de Angra, geram eletricidade.',
  ),
  QuizQuestion(
    question: 'Qual fruta é naturalmente um pouco radioativa?',
    options: ['Maçã', 'Uva', 'Banana', 'Laranja'],
    correct: 2,
    explanation: 'A banana tem potássio-40, em quantidade inofensiva.',
  ),
  QuizQuestion(
    question: 'Onde fica a usina nuclear brasileira?',
    options: ['Angra dos Reis (RJ)', 'Manaus (AM)', 'Porto Alegre (RS)', 'Salvador (BA)'],
    correct: 0,
    explanation: 'Angra 1 e 2 operam no litoral do Rio de Janeiro.',
  ),
  QuizQuestion(
    question: 'A irradiação de alimentos serve para…',
    options: ['Torná-los radioativos', 'Conservar e reduzir microrganismos', 'Mudar a cor', 'Aumentar o açúcar'],
    correct: 1,
    explanation: 'Os alimentos tratados não ficam radioativos.',
  ),
];

// TELA do QUIZ
class QuizScreen extends StatelessWidget {
  const QuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // por enquanto sempre a primeira pergunta mesmo
    final question = quizQuestions[0];

    return Scaffold(
      appBar: AppBar(
        title: const Header(),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Pergunta 1 de ${quizQuestions.length}'),

            const SizedBox(height: 12),

            Text(
              question.question,
              style: Theme.of(context).textTheme.headlineSmall,
            ),

            const SizedBox(height: 16),

            // LISTA das opções sendo chamadas pelo index
            Expanded(
              child: ListView.builder(
                itemCount: question.options.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text(question.options[index]),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),

      bottomNavigationBar: const Menu(atual: 1),
    );
  }
}