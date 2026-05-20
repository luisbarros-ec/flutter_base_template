import 'package:flutter/material.dart';
import '../../extensions/exception_extensions.dart';
import '/ui/mixins/app_messages.dart';
import '/ui/screens/example_screen/example_controller.dart';
import '/ui/theme/custom_text_styles.dart';
import 'package:provider/provider.dart';

class ExampleScreen extends StatefulWidget {
  const ExampleScreen({super.key});

  @override
  State<ExampleScreen> createState() => _ExampleScreenState();
}

class _ExampleScreenState extends State<ExampleScreen> with AppMessages {
  void _fetchData() async {
    showLoading();

    final controller = context.read<ExampleController>();
    await controller.loadData();

    hideLoading();

    if (controller.activeException != null) {
      // A UI decide a tradução baseada no tipo da excecão customizada
      if (controller.activeException != null) {
        // Basta chamar o '.userMessage' mágico que criamos na extensão
        customFlushBar(controller.activeException!.userMessage);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<ExampleController>();
    return Scaffold(
      appBar: AppBar(title: const Text('Exemplo do Template')),
      body: Center(
        child: Padding(
          padding: const EdgeInsetsGeometry.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 10,
            children: [
              Text(
                controller.data?.title ?? 'Nenhum dado carregado ainda',
                style: CustomTextStyles.body,
                textAlign: TextAlign.center,
              ),
              ElevatedButton(
                onPressed: _fetchData,
                child: const Text('Buscar Dados da API'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
