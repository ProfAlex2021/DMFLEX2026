import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Validação de Segurança',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const LoginScreen(),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // A GlobalKey identifica o formulário e permite validar ou redefinir seus campos.
  final _formKey = GlobalKey<FormState>();
  
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Expressão regular (Regex) para verificar se o formato do e-mail é válido.
  final RegExp _emailRegex = RegExp(
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"
  );

  void _submitForm() {
    // Aciona a propriedade 'validator' de todos os TextFormField dentro do Form.
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Validação bem-sucedida! Processando dados...')),
      );
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Autenticação Segura'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'E-mail',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email),
                ),
                validator: (value) {
                  // Regra 1: Campo Vazio
                  if (value == null || value.trim().isEmpty) {
                    return 'O campo de e-mail não pode estar vazio.';
                  }
                  // Regra 2: E-mail inválido
                  if (!_emailRegex.hasMatch(value)) {
                    return 'Por favor, insira um e-mail válido.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _passwordController,
                obscureText: true, // Oculta a senha por segurança
                decoration: const InputDecoration(
                  labelText: 'Senha',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock),
                ),
                validator: (value) {
                  // Regra 1: Campo Vazio
                  if (value == null || value.isEmpty) {
                    return 'O campo de senha não pode estar vazio.';
                  }
                  // Regra 3: Senha com menos de 6 caracteres
                  if (value.length < 6) {
                    return 'A senha deve conter pelo menos 6 caracteres.';
                  }
                  return null; // Retornar nulo indica que a validação passou
                },
              ),
              const SizedBox(height: 24.0),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _submitForm,
                  child: const Text(
                    'Entrar',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}