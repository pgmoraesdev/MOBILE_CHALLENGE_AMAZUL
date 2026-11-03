import 'package:flutter/material.dart';
import 'package:lucide_flutter/lucide_flutter.dart';
import 'home_screen.dart';

// PERGUNTAS DO QUIZ
class QuizQuestion {
  final String question;
  final List<String> options;
  final int correct; // posição da opção certa na lista
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

// TELA QUIZ
class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

// guarda as infos que mudam durante o quiz
class _QuizScreenState extends State<QuizScreen> {
  int current = 0; // posição da pergunta atual
  int selected = -1; // opção escolhida (-1 = ainda não escolheu nada)
  int score = 0; 
  bool finished = false; // mostra o resultado quando acaba o quiz

  // QUANDO A PESSOA TOCA EM UMA OPÇÃO
  void answer(int index) {
    // se já respondeu ignora
    if (selected != -1) return;

    setState(() {
      selected = index;
      // se a opção tocada for a certa, soma 1 ponto
      if (index == quizQuestions[current].correct) {
        score++;
      }
    });
  }

  // PASSA PARA A PRÓXIMA PERGUNTA (ou termina, se era a última)
  void next() {
    setState(() {
      if (current == quizQuestions.length - 1) {
        finished = true;
      } else {
        current++;
        selected = -1; // reseta a opcao escolhida ja que a pessoa n escolheu ainda
      }
    });
  }

  //RESET QUIZ: 
  void restart() {
    setState(() {
      current = 0;
      selected = -1;
      score = 0;
      finished = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    // SE ACABOU, MOSTRA A TELA DE RESULTADO
    if (finished) {
      return Scaffold(
        appBar: AppBar(
          title: const Header(),
        ),

        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Você acertou'),

                Text(
                  '$score de ${quizQuestions.length}',
                  style: Theme.of(context).textTheme.displayLarge,
                ),

                const SizedBox(height: 8),

                // mensagem diferente dependendo da pontuação
                Text(
                  score >= 4
                      ? 'Você já manda bem no assunto!'
                      : 'Continue explorando, o assunto está em tudo!',
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 24),

                ElevatedButton(
                  onPressed: restart,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 39, 31, 150),
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Jogar de novo'),
                ),

                const SizedBox(height: 12),

                OutlinedButton(
                  // pop: fecha o quiz e volta para a tela de jogos
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Voltar aos jogos'),
                ),
              ],
            ),
          ),
        ),

        bottomNavigationBar: const Menu(atual: 1),
      );
    }

    // SE NÃO ACABOU, MOSTRA A PERGUNTA
    final question = quizQuestions[current];
    final answered = selected != -1; // true se já respondeu

    return Scaffold(
      appBar: AppBar(
        title: const Header(),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // progresso à esquerda, pontuação à direita
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Pergunta ${current + 1} de ${quizQuestions.length}'),
                Text('Acertos: $score'),
              ],
            ),

            const SizedBox(height: 12),

            Text(
              question.question,
              style: Theme.of(context).textTheme.headlineSmall,
            ),

            const SizedBox(height: 16),

            // LISTA DAS OPÇÕES
            Expanded(
              child: ListView.builder(
                itemCount: question.options.length,
                itemBuilder: (context, index) {
                  final isCorrect = index == question.correct;
                  final isChosen = index == selected;

                  return Card(
                    // antes de responder: cor normal
                    // depois: a certa fica verde, a errada escolhida fica vermelha
                    color: !answered
                        ? null
                        : isCorrect
                            ? Colors.green.shade100
                            : isChosen
                                ? Colors.red.shade100
                                : null,

                    child: ListTile(
                      title: Text(question.options[index]),

                      // ícone de certo ou errado depois de responder
                      trailing: answered && isCorrect
                          ? const Icon(LucideIcons.circleCheck, color: Colors.green)
                          : answered && isChosen
                              ? const Icon(LucideIcons.circleX, color: Colors.red)
                              : null,

                      // ao tocar, chama o answer passando a posição da opção
                      onTap: () {
                        answer(index);
                      },
                    ),
                  );
                },
              ),
            ),

            // EXPLICAÇÃO: só aparece depois de responder
            answered
                ? Card(
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Text(question.explanation),
                    ),
                  )
                : const SizedBox(),

            const SizedBox(height: 12),

            Center(
              child: ElevatedButton(
                // desativado até a pessoa responder
                onPressed: answered ? next : null,

                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 39, 31, 150),
                  foregroundColor: Colors.white,
                ),

                // na última pergunta o texto muda
                child: Text(
                  current == quizQuestions.length - 1 ? 'Ver resultado' : 'Próxima',
                ),
              ),
            ),
          ],
        ),
      ),

      bottomNavigationBar: const Menu(atual: 1),
    );
  }
}