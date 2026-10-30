import 'package:flutter/material.dart';

void main() {
  runApp(const VerificadorSenhaApp());
}

class VerificadorSenhaApp extends StatelessWidget {
  const VerificadorSenhaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Verificador de Senha',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const TelaVerificadorSenha(),
    );
  }
}

class TelaVerificadorSenha extends StatefulWidget {
  const TelaVerificadorSenha({super.key});

  @override
  State<TelaVerificadorSenha> createState() => _TelaVerificadorSenhaState();
}

class _TelaVerificadorSenhaState extends State<TelaVerificadorSenha> {
  String _mensagemForca = '';
  Color _corForca = Colors.transparent;

  void _analisarTamanhoSenha(String senha) {
    setState(() {
      if (senha.isEmpty) {
        _mensagemForca = '';
        _corForca = Colors.transparent;
      } else if (senha.length < 6) {
        _mensagemForca = 'Senha Fraca';
        _corForca = Colors.red;
      } else if (senha.length >= 6 && senha.length <= 9) {
        _mensagemForca = 'Senha Média';
        _corForca = Colors.orange;
      } else {
        _mensagemForca = 'Senha Forte';
        _corForca = Colors.green;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Análise de Senha'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Digite uma senha para verificar sua força baseada no tamanho:',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            TextField(
              obscureText: true, // Oculta os caracteres digitados
              onChanged: _analisarTamanhoSenha, // Analisa a cada caractere digitado
              decoration: const InputDecoration(
                labelText: 'Senha',
                prefixIcon: Icon(Icons.lock),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 30),
            Text(
              _mensagemForca,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: _corForca,
              ),
            ),
          ],
        ),
      ),
    );
  }
}