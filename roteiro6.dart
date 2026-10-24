import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MeuApp());
}

class MeuApp extends StatelessWidget {
  const MeuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'App SharedPreferences',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const TelaPrincipal(),
    );
  }
}

class TelaPrincipal extends StatefulWidget {
  const TelaPrincipal({super.key});

  @override
  State<TelaPrincipal> createState() => _TelaPrincipalState();
}

class _TelaPrincipalState extends State<TelaPrincipal> {
  // Controlador para capturar o texto digitado
  final TextEditingController _nomeController = TextEditingController();
  
  // Variável para exibir o nome na tela
  String _nomeSalvo = "Nenhum nome salvo";

  @override
  void initState() {
    super.initState();
    _carregarNome(); // Carrega o nome assim que o app é aberto
  }

  // Função para recuperar o nome do SharedPreferences
  Future<void> _carregarNome() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      // Tenta ler a chave 'nomeUsuario', se não existir, retorna vazio
      _nomeSalvo = prefs.getString('nomeUsuario') ?? "Nenhum nome salvo";
    });
  }

  // Função para salvar o nome no SharedPreferences
  Future<void> _salvarNome() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('nomeUsuario', _nomeController.text);
    
    setState(() {
      _nomeSalvo = _nomeController.text;
    });
    
    // Limpa o campo de texto após salvar
    _nomeController.clear();
    
    // Exibe um aviso na tela
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Nome salvo com sucesso!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Atividade Prática - SharedPreferences'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Bem-vindo, $_nomeSalvo!',
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 40),
            TextField(
              controller: _nomeController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Digite seu nome',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _salvarNome,
              child: const Text('Salvar Nome'),
            ),
          ],
        ),
      ),
    );
  }
}