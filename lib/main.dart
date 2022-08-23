import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const AppWight());
}

final dados = FirebaseFirestore.instance.collection('tb');

String? dados_tb = '';

buscaBanco() async {
  await dados.doc('1').get().then((snapshot) async {
    dados_tb = snapshot.data()!['Nome'];
  });
}

class AppWight extends StatelessWidget {
  const AppWight({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.black,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => Home(),
        '/p_banco': (context) => PuxarBanco(),
        '/cadastro': (context) => Cadastro(),
        '/desafio2': (context) => Segundo(),
        '/editar': (context) => Editar(),
      },
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  double largura = 40;
  double altura = 40;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        leading: Icon(Icons.home),
      ),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Container(
              width: 100,
              height: 70,
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/cadastro');
                },
                child: const Text(
                  'Desafio 1',
                  style: TextStyle(color: Colors.white),
                ),
                style: TextButton.styleFrom(
                    backgroundColor: Colors.blue,
                    elevation: 15,
                    shadowColor: Colors.blueAccent),
              ),
            ),
          ),
          Container(
            width: 100,
            height: 70,
            child: TextButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/desafio2');
              },
              child: const Text(
                'Desafio 2',
                style: TextStyle(color: Colors.white),
              ),
              style: TextButton.styleFrom(
                  backgroundColor: Colors.blue,
                  elevation: 15,
                  shadowColor: Colors.blueAccent),
            ),
          ),
        ]),
      ),
    );
  }
}

class Segundo extends StatefulWidget {
  const Segundo({Key? key}) : super(key: key);

  @override
  State<Segundo> createState() => _SegundoState();
}

class _SegundoState extends State<Segundo> {
  int aux = 0;
  int aux2 = 0;
  int aux3 = 0;
  List<String> uni = [
    "Zero",
    "Um",
    "Dois",
    "Tres",
    "Quatro",
    "Cinco",
    "Seis",
    "Sete",
    "Oito",
    "Nove"
  ];
  List<String> dec = [
    "Dez",
    "Onze",
    "Doze",
    "Treze",
    "Quatorze",
    "Quinze",
    "Dezeseis",
    "Dezesete",
    "Dezoito",
    "Dezenove"
  ];
  List<String> dez = [
    "Vinte",
    "Trinta",
    "Quarenta",
    "Cinquenta",
    "Sessenta",
    "Setenta",
    "Oitenta",
    "Noventa",
    "Cem"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Desafio 2"),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 5),
            child: TextButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/');
              },
              child: const Text(
                'Home',
                style: TextStyle(color: Colors.white),
              ),
              style: TextButton.styleFrom(
                  backgroundColor: Colors.blue,
                  elevation: 15,
                  shadowColor: Colors.blueAccent),
            ),
          ),
        ],
      ),
      body: SizedBox(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text('Digite um numero(0-100) :'),
            SizedBox(height: 20),
            TextField(
              onChanged: (text) {
                aux = int.parse(text);
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    20.0,
                  ),
                ),
                fillColor: Colors.white,
                filled: true,
              ),
            ),
            SizedBox(height: 20),
            TextButton(
              onPressed: () {
                if (aux < 10) {
                  print(uni[aux]);
                } else if (aux < 20 && aux >= 10) {
                  print(dec[aux - 10]);
                } else if (aux <= 100) {
                  aux2 = (aux / 10).floor();
                  aux3 = (aux % 10);
                  if (aux3 > 0) {
                    print(dez[aux2 - 2] + ' e ' + uni[aux3]);
                  } else
                    print(dez[aux2 - 2]);
                } else if (aux > 100) {
                  print('valor não cadastrado');
                } else {
                  print('valor não cadastrado');
                }
              },
              child: Text('Enter'),
            )
          ]),
        ),
      ),
    );
  }
}

class Editar extends StatefulWidget {
  const Editar({Key? key}) : super(key: key);

  @override
  State<Editar> createState() => _EditarState();
}

class _EditarState extends State<Editar> {
  String nome = '';
  String cpf = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Editar"),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 5),
            child: TextButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/p_banco');
              },
              child: const Text(
                'Buscar',
                style: TextStyle(color: Colors.white),
              ),
              style: TextButton.styleFrom(
                  backgroundColor: Colors.blue,
                  elevation: 15,
                  shadowColor: Colors.blueAccent),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 5),
            child: TextButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/');
              },
              child: const Text(
                'Home',
                style: TextStyle(color: Colors.white),
              ),
              style: TextButton.styleFrom(
                  backgroundColor: Colors.blue,
                  elevation: 15,
                  shadowColor: Colors.blueAccent),
            ),
          ),
        ],
      ),
      body: Center(
        child: (Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text('Digite seu nome: '),
          SizedBox(height: 30),
          TextField(
            decoration: InputDecoration(
              labelText: 'Nome',
              filled: true,
            ),
            onChanged: (text) {
              nome = text;
            },
          ),
          SizedBox(height: 30),
          Text('Digite seu cpf: '),
          SizedBox(height: 30),
          TextField(
            decoration: InputDecoration(
              labelText: 'CPF',
              filled: true,
            ),
            onChanged: (text) {
              cpf = text;
            },
          ),
          SizedBox(height: 30),
          TextButton(
              onPressed: () {
                FirebaseFirestore.instance
                    .collection('tb')
                    .doc('1')
                    .set({"Nome": nome, "CPF": cpf});
              },
              child: Text('Editar')),
        ])),
      ),
    );
  }
}

class Cadastro extends StatefulWidget {
  const Cadastro({Key? key}) : super(key: key);

  @override
  State<Cadastro> createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  String nome = '';
  String cpf = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Salvar"),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 5),
            child: TextButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/p_banco');
              },
              child: const Text(
                'Buscar',
                style: TextStyle(color: Colors.white),
              ),
              style: TextButton.styleFrom(
                  backgroundColor: Colors.blue,
                  elevation: 15,
                  shadowColor: Colors.blueAccent),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 5),
            child: TextButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/');
              },
              child: const Text(
                'Home',
                style: TextStyle(color: Colors.white),
              ),
              style: TextButton.styleFrom(
                  backgroundColor: Colors.blue,
                  elevation: 15,
                  shadowColor: Colors.blueAccent),
            ),
          ),
        ],
      ),
      body: Center(
        child: (Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text('Digite seu nome: '),
          SizedBox(height: 30),
          TextField(
            decoration: InputDecoration(
              labelText: 'Nome',
              filled: true,
            ),
            onChanged: (text) {
              nome = text;
            },
          ),
          SizedBox(height: 30),
          Text('Digite seu cpf: '),
          SizedBox(height: 30),
          TextField(
            decoration: InputDecoration(
              labelText: 'CPF',
              filled: true,
            ),
            onChanged: (text) {
              cpf = text;
            },
          ),
          SizedBox(height: 30),
          TextButton(
              onPressed: () {
                FirebaseFirestore.instance
                    .collection('tb')
                    .doc('1')
                    .set({"Nome": nome, "CPF": cpf});
              },
              child: Text('Salvar')),
        ])),
      ),
    );
  }
}

class PuxarBanco extends StatelessWidget {
  const PuxarBanco({Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    String nome = '';
    String cpf = '';
    return Scaffold(
      appBar: AppBar(
        title: Text("Dados Banco"),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 5),
            child: TextButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/');
              },
              child: const Text(
                'Home',
                style: TextStyle(color: Colors.white),
              ),
              style: TextButton.styleFrom(
                  backgroundColor: Colors.blue,
                  elevation: 15,
                  shadowColor: Colors.blueAccent),
            ),
          ),
        ],
      ),
      body: Container(
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(
                  "Buscar",
                  style: TextStyle(fontSize: 30),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 220),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 20,
                        ),
                        Text('Nome: ${dados_tb.toString()}',
                            style: TextStyle(fontSize: 20)),
                        SizedBox(height: 30),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: 70,
                                height: 40,
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pushNamed('/editar');
                                  },
                                  child: const Text(
                                    'Editar',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  style: TextButton.styleFrom(
                                      backgroundColor: Colors.blue,
                                      elevation: 15,
                                      shadowColor: Colors.blueAccent),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 10, right: 10),
                                child: Container(
                                  width: 70,
                                  height: 40,
                                  child: TextButton(
                                    onPressed: () {
                                      buscaBanco();
                                    },
                                    child: Text(
                                      'Buscar',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    style: TextButton.styleFrom(
                                        backgroundColor: Colors.blue,
                                        elevation: 15,
                                        shadowColor: Colors.blueAccent),
                                  ),
                                ),
                              ),
                              Material(
                                child: Container(
                                  width: 70,
                                  height: 40,
                                  child: TextButton(
                                    onPressed: () {
                                      FirebaseFirestore.instance
                                          .collection("tb")
                                          .doc('1')
                                          .delete();
                                    },
                                    child: const Text(
                                      'Deletar',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    style: TextButton.styleFrom(
                                        backgroundColor: Colors.blue,
                                        elevation: 15,
                                        shadowColor: Colors.blueAccent),
                                  ),
                                ),
                              ),
                            ])
                      ]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
