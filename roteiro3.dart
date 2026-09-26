import 'package:flutter/material.dart';

void main() => runApp(const LoginExampleApp());

class LoginExampleApp extends StatelessWidget {
  const LoginExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Login Sample')),
        body: const Center(child: LoginPage()),
      ),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Controladores para capturar o texto digitado
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();

  @override
  void dispose() {
    // Descarte dos controladores para liberar memória
    _emailController.dispose();
    _senhaController.dispose();
    super.dispose();
  }

  void _validarLogin() {
    String email = _emailController.text;
    String senha = _senhaController.text;

    // Condição de validação
    bool loginValido = (email == 'adm@exemplo.com' && senha == '123');

    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text('Sistema'),
        content: Text(loginValido ? 'Acesso Autorizado' : 'Acesso Negado'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'OK'),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Acesso ao Sistema')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Campo de e-mail
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'E-mail',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),
            // Campo de senha
            TextField(
              controller: _senhaController,
              decoration: const InputDecoration(
                labelText: 'Senha',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 24),
            // Botão Entrar
            ElevatedButton(
              onPressed: _validarLogin,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text('ENTRAR'),
            ),
          ],
        ),
      ),
    );
  }
}