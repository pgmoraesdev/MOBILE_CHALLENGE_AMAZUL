import 'package:flutter/material.dart';
import 'package:lucide_flutter/lucide_flutter.dart';

// importa o arquivo da home para poder usar o header e o menu aqui também, mais pra frente a gente faz virarem componentes
import 'home_screen.dart';

// importa o quiz para poder abrir ele daqui
import 'game_quiz_screen.dart';

// JOGOS DISPONÍVEIS
class Game {
  final String name;
  final String description;
  final IconData icon;
  final bool available; // true = já dá pra jogar, false = em breve, ainda vamos analisar como desenvolver

  const Game({
    required this.name,
    required this.description,
    required this.icon,
    required this.available,
  });
}

const games = [
  Game(
    name: 'Quiz',
    description: '5 perguntas com explicação',
    icon: LucideIcons.brain,
    available: true,
  ),
  Game(
    name: 'Jogo da memória',
    description: 'Encontre os pares',
    icon: LucideIcons.puzzle,
    available: false,
  ),
  Game(
    name: 'Raspadinha',
    description: 'Raspe e descubra curiosidades',
    icon: LucideIcons.ticket,
    available: false,
  ),
  Game(
    name: 'Fato ou Mito',
    description: 'Desvende os mitos',
    icon: LucideIcons.bomb,
    available: false,
  ),
];

// TELA JOGOS
class GamesScreen extends StatelessWidget {
  const GamesScreen({super.key});

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
              'Jogos',
              style: Theme.of(context).textTheme.headlineMedium,
            ),

            const SizedBox(height: 8),

            const Text('Escolha um jogo e aprenda brincando:'),

            const SizedBox(height: 16),

            // LISTA DOS JOGOS 
            // esse GridView.count é um ListView em colunas e o crossAxisCount diz quantas colunas
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                children: games.map((game) {
                  return Card(
                    // InkWell deixa o card com efeito bonitinho ao clicar nele
                    child: InkWell(
                      // se o jogo não estiver disponível, esse efeito nao vai funcionar ao clicar e nao vai clicar
                      onTap: game.available
                          ? () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const QuizScreen(),
                                ),
                              );
                            }
                          : null,

                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              game.icon,
                              size: 40,
                              color: game.available ? const Color.fromARGB(255, 39, 31, 150): Colors.grey,),

                            const SizedBox(height: 8),

                            Text(
                              game.name,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            const SizedBox(height: 4),

                            // se não estiver disponível, mostra "Em breve" no lugar da descrição
                            Text(
                              game.available ? game.description : 'Em breve',
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),

      // atual: 1 deixa a aba "Jogos" marcada no menu
      bottomNavigationBar: const Menu(atual: 1),
    );
  }
}