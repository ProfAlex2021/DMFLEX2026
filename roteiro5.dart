import 'package:flutter/material.dart';

void main() {
  runApp(const MeuApp());
}

class MeuApp extends StatelessWidget {
  const MeuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pesquisa de Tecnologias',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const TelaPesquisaTecnologias(),
    );
  }
}

// 1. StatefulWidget é necessário porque o estado das checkboxes vai mudar
class TelaPesquisaTecnologias extends StatefulWidget {
  const TelaPesquisaTecnologias({super.key});

  @override
  State<TelaPesquisaTecnologias> createState() => _TelaPesquisaTecnologiasState();
}

class _TelaPesquisaTecnologiasState extends State<TelaPesquisaTecnologias> {
  // 2. Variáveis para guardar o estado de cada opção
  bool java = false;
  bool kotlin = false;
  bool flutter = false;
  bool python = false;

  void verificarResposta() {
    List<String> selecionadas = [];
    
    if (java) selecionadas.add('Java');
    if (kotlin) selecionadas.add('Kotlin');
    if (flutter) selecionadas.add('Flutter');
    if (python) selecionadas.add('Python');

    String mensagem = selecionadas.isEmpty
        ? 'Nenhuma tecnologia selecionada.'
        : 'Você conhece: ${selecionadas.join(', ')}';

    // 3. Exibe a mensagem usando um SnackBar (o equivalente ao Toast do Android nativo)
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(mensagem),
        behavior: SnackBarBehavior.floating, // Faz o alerta flutuar na tela
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Conhecimentos'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Alinha os itens à esquerda
          children: [
            const Text(
              'Quais tecnologias você conhece?',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            
            // 4. CheckboxListTile é o componente ideal pois permite clicar tanto na caixa quanto no texto
            CheckboxListTile(
              title: const Text('Java'),
              value: java,
              onChanged: (bool? value) {
                // setState avisa o Flutter que a tela precisa ser redesenhada
                setState(() { java = value ?? false; });
              },
              controlAffinity: ListTileControlAffinity.leading, // Coloca a caixinha na esquerda
            ),
            CheckboxListTile(
              title: const Text('Kotlin'),
              value: kotlin,
              onChanged: (bool? value) {
                setState(() { kotlin = value ?? false; });
              },
              controlAffinity: ListTileControlAffinity.leading,
            ),
            CheckboxListTile(
              title: const Text('Flutter'),
              value: flutter,
              onChanged: (bool? value) {
                setState(() { flutter = value ?? false; });
              },
              controlAffinity: ListTileControlAffinity.leading,
            ),
            CheckboxListTile(
              title: const Text('Python'),
              value: python,
              onChanged: (bool? value) {
                setState(() { python = value ?? false; });
              },
              controlAffinity: ListTileControlAffinity.leading,
            ),
            
            const SizedBox(height: 32),
            
            // Botão de verificação centralizado
            Center(
              child: ElevatedButton(
                onPressed: verificarResposta,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                ),
                child: const Text('Verificar Resposta', style: TextStyle(fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}