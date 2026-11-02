import 'package:flutter/material.dart';
import 'package:lucide_flutter/lucide_flutter.dart';

// CENÁRIOS DO DIA
class Moment {
  final int id;
  final String text;
  final IconData icon;

//abaixo é um construtor, ele mostra oq é obrigatório(required) ter pra criar um moment e atribui a cada valor (this.)
  const Moment({
    required this.id,
    required this.text,
    required this.icon,
  });
}

const moments = [
  Moment(
    id: 1,
    text: 'Usei um celular ou computador',
    icon: LucideIcons.smartphone,
  ),
  Moment(
    id: 2,
    text: 'Fiz um exame ou cuidei da saúde',
    icon: LucideIcons.heartPulse,
  ),
  Moment(
    id: 3,
    text: 'Comi ou preparei alguma coisa',
    icon: LucideIcons.utensils,
  ),
  Moment(
    id: 4,
    text: 'Usei transporte ou algum veículo',
    icon: LucideIcons.car,
  ),
  Moment(
    id: 5,
    text: 'Assisti a algo ou ouvi música',
    icon: LucideIcons.headphones,
  ),
];

// COMPONENTE HEADER
class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text('Damy');
  }
}

// COMPONENTE MENU DE NAVEGAÇÃO
class Menu extends StatelessWidget {
  final int atual;

  const Menu({
    super.key,
    required this.atual,
  });

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      selectedIndex: atual,
      destinations: const [
        NavigationDestination(
          icon: Icon(LucideIcons.sun),
          label: 'Meu dia',
        ),
        NavigationDestination(
          icon: Icon(LucideIcons.gamepad2),
          label: 'Jogos',
        ),
        NavigationDestination(
          icon: Icon(LucideIcons.mic),
          label: 'Palestras',
        ),
        NavigationDestination(
          icon: Icon(LucideIcons.settings),
          label: 'Tema',
        ),
      ],
    );
  }
}

// TELA MEU DIA
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  //aq a gente passa qual objeto que vai ta controlando essas mudanças do homescreen, o objeto será a classe _HomeScreenState
  State<HomeScreen> createState() => _HomeScreenState();
}

//essa classe vai guardar as infos que podem mudar, nesse caso a seleção da lista 
class _HomeScreenState extends State<HomeScreen> {
  final List<int> selectedMoments = []; //declarando a lista

  // SELECIONAR OU DESMARCAR UM CENÁRIO
  void toggleMoment(int id) {
    setState(() {
      if (selectedMoments.contains(id)) {
        selectedMoments.remove(id);
      } else {
        selectedMoments.add(id);
      }
      //aq dise: se ja tem esse id, remove, se nao tem adiciona
    });
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
            // titulo
            Text(
              'Você está vivendo com tecnologia nuclear?',
              style: Theme.of(context).textTheme.headlineMedium,
            ),

            const SizedBox(height: 20),

            // TÍTULO DA LISTA
            const Text(
              'Selecione o que fez hoje:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            // LISTA DE CENÁRIOS
            Expanded( //expande o card pro tamanho da column
              child: ListView(
                //pra cada item da lista moment (.map) ele vai fazer o return CARD
                children: moments.map((moment) {
                  final isSelected =
                      selectedMoments.contains(moment.id);

                  return Card(
                    //se tiver selecionado, o card vai ficar roxinho
                    color: isSelected ? const Color.fromARGB(40, 39, 31, 150) : null,

                    //organiza as infos dentro do item
                    child: ListTile(
                      leading: Icon(
                        moment.icon,
                        color: isSelected ? const Color.fromARGB(255,39,31,150,) : null,
                      ), // aq ta falando que se o item for selecionado o icon vai ficar roxinho, se nao, nao muda de cor

                      title: Text(moment.text),

                      trailing: Icon(
                        isSelected
                            ? LucideIcons.circleCheck
                            : LucideIcons.circle,
                        color: isSelected ? const Color.fromARGB(255,39,31,150,) : Colors.grey,
                      ), // se o item for selecionado o check vai ficar roxinho, se nao ele é cinza 

                      // ao tocar no cartao ele ativa o togglemoment, o setstate
                      onTap: () {
                        toggleMoment(moment.id);
                      },
                    ),
                  );
                }).toList(), //isso aqui vai listar todos os itens q ele percorreu do moment na tela
              ),
            ),

            const SizedBox(height: 20),

            //action buttons
            Center(
              child: Column(
                children: [
                  ElevatedButton(
                    //aq fala se nao tiver anda selecionado, ele nao vai ta ativo. se sim, tenho q fazer depois a tela q mostr ao resultado
                    onPressed: selectedMoments.isEmpty ? null : () {
                            // AÇÃO DE VER MEU DIA - tem q por aq codar isso aq dps 
                            },


                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          const Color.fromARGB(255,39,31,150,),
                      foregroundColor: Colors.white,
                    ),

                    child: const Text('Ver meu dia'),
                  ),

                  const SizedBox(height: 12),

                  OutlinedButton(
                    onPressed: () {
                      // AÇÃO DE IR PARA OS JOGOS
                    },
                    child: const Text(
                      'Pular e ir para os jogos',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      bottomNavigationBar: const Menu(atual: 0),
    );
  }
}