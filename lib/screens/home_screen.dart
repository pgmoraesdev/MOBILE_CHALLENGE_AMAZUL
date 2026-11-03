import 'package:flutter/material.dart';
import 'package:lucide_flutter/lucide_flutter.dart';

// importa a tela de jogos para poder abrir ela daqui
import 'games_screen.dart';

// CENÁRIOS DO DIA
class Moment {
  final int id;
  final String text;
  final IconData icon;
  final String tema;
  final String explicacao;


//abaixo é um construtor, ele mostra oq é obrigatório(required) ter pra criar um moment e atribui a cada valor (this.)
  const Moment({
    required this.id,
    required this.text,
    required this.icon,
    required this.tema,
    required this.explicacao,
  });
}

const moments = [
  Moment(
    id: 1,
    text: 'Carreguei o celular',
    icon: LucideIcons.smartphoneCharging,
    tema: 'Energia',
    explicacao: 'A tomada está ligada a uma rede com várias fontes de energia, e as usinas nucleares são uma delas.',
  ),
  Moment(
    id: 2,
    text: 'Acendi a luz',
    icon: LucideIcons.lightbulb,
    tema: 'Energia',
    explicacao: 'Parte da eletricidade do Brasil vem de usinas nucleares, que operam junto com hidrelétricas e outras fontes.',
  ),
  Moment(
    id: 3,
    text: 'Fiz um raio-X ou exame de imagem',
    icon: LucideIcons.bone,
    tema: 'Saúde',
    explicacao: 'Exames de imagem usam radiação para mostrar o interior do corpo sem cirurgia.',
  ),
  Moment(
    id: 4,
    text: 'Fui ao dentista',
    icon: LucideIcons.smile,
    tema: 'Saúde',
    explicacao: 'A radiografia odontológica usa doses muito baixas de radiação para enxergar dentes e raízes.',
  ),
  Moment(
    id: 5,
    text: 'Usei seringa ou curativo embalado',
    icon: LucideIcons.syringe,
    tema: 'Saúde',
    explicacao: 'Muitos materiais médicos descartáveis são esterilizados por radiação, já dentro da embalagem.',
  ),
  Moment(
    id: 6,
    text: 'Comi banana',
    icon: LucideIcons.banana,
    tema: 'Alimentos',
    explicacao: 'A banana contém potássio-40, um isótopo natural. A dose é mínima e inofensiva.',
  ),
  Moment(
    id: 7,
    text: 'Comi algo embalado que dura muito',
    icon: LucideIcons.package,
    tema: 'Alimentos',
    explicacao: 'A irradiação é uma técnica regulamentada para conservar certos alimentos e reduzir microrganismos.',
  ),
  Moment(
    id: 8,
    text: 'Comi arroz, feijão ou verduras',
    icon: LucideIcons.wheat,
    tema: 'Alimentos',
    explicacao: 'Algumas variedades de plantas foram criadas com radiação, que também ajuda a controlar pragas.',
  ),
  Moment(
    id: 9,
    text: 'Tenho detector de fumaça em casa',
    icon: LucideIcons.siren,
    tema: 'Casa',
    explicacao: 'Alguns modelos usam uma fonte radioativa minúscula e selada para detectar fumaça.',
  ),
  Moment(
    id: 10,
    text: 'Vi o mar ou um navio',
    icon: LucideIcons.ship,
    tema: 'Mar',
    explicacao: 'O Programa Nuclear da Marinha desenvolve tecnologia para propulsão naval e para o ciclo do combustível.',
  ),
];

// COMPONENTE HEADER
class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          'web/icons/damyicon.png',
          height: 32, 
        ),

        const SizedBox(width: 8), // espaço entre a logo e o texto

        const Text('Damy'),
      ],
    );
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

      // quando toca numa aba, o Flutter entrega o número dela em "index"
      onDestinationSelected: (index) {
        // se tocou na aba onde já está, não faz nada
        if (index == atual) return;

        if (index == 0) {
          // pushReplacement: vai para a nova tela SUBSTITUINDO a atual
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomeScreen()),
          );
        } else if (index == 1) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const GamesScreen()),
          );
        }
        // index 2 (Palestras) e 3 (Tema): ligar com parte do paulo
      },

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

  // ABRE A TELA DE RESULTADO
  void showResult() {
    // monta a lista só com os cenários que foram marcados
    final List<Moment> selected = [];
    for (final moment in moments) {
      if (selectedMoments.contains(moment.id)) {
        selected.add(moment);
      }
    }
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResultScreen(selected: selected),
      ),
    );
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
                    // se nao tiver nada selecionado o botao fica desativado (null)
                    // se tiver, ele chama o showResult que abre a tela de resultado
                    onPressed: selectedMoments.isEmpty ? null : showResult,

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
                      // vai para a tela de jogos, substituindo a Home
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const GamesScreen(),
                        ),
                      );
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

// TELA RESULTADO DO MEU DIA
// recebe a lista dos cenários que a pessoa marcou na Home.
// é StatelessWidget porque nada muda aqui, ela só mostra os dados
class ResultScreen extends StatelessWidget {
  final List<Moment> selected;

  const ResultScreen({
    super.key,
    required this.selected,
  });

  @override
  Widget build(BuildContext context) {
    // descobre os temas SEM repetir (Energia, Saúde...)
    final List<String> temas = [];
    for (final moment in selected) {
      if (!temas.contains(moment.tema)) {
        temas.add(moment.tema);
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Header(),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Hoje o átomo esteve em'),

            // o número de cenários marcados, bem grande
            Text(
              '${selected.length}',
              style: Theme.of(context).textTheme.displayLarge,
            ),

            // singular ou plural, dependendo da quantidade
            Text(
              selected.length == 1
                  ? 'momento do seu dia'
                  : 'momentos do seu dia',
              style: Theme.of(context).textTheme.headlineSmall,
            ),

            const SizedBox(height: 8),

            // join junta os temas num texto só: "Energia, Saúde"
            Text('Temas: ${temas.join(', ')}'),

            const SizedBox(height: 12),

            // LISTA DOS CENÁRIOS MARCADOS, cada um com sua explicação
            Expanded(
              child: ListView(
                children: selected.map((moment) {
                  return Card(
                    child: ListTile(
                      leading: Icon(moment.icon),
                      title: Text(moment.text),
                      subtitle: Text(moment.explicacao),
                    ),
                  );
                }).toList(),
              ),
            ),

            const SizedBox(height: 20),

            Center(
              child: Column(
                children: [
                  ElevatedButton(
                    // pop: fecha esta tela e volta para a Home
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 39, 31, 150),
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Fazer de novo'),
                  ),

                  const SizedBox(height: 12),

                  OutlinedButton(
                    onPressed: () {
                      // vai para a tela de jogos, substituindo o resultado
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const GamesScreen(),
                        ),
                      );
                    },
                    child: const Text('Ir para os jogos'),
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