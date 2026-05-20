import '/data/http/http_client.dart';

import '/data/models/example_model.dart';

abstract class IExampleRepository {
  Future<ExampleModel> fetchExampleData();
}

class ExampleRepository implements IExampleRepository {
  IHttpClient httpClient;

  ExampleRepository({required this.httpClient});

  @override
  Future<ExampleModel> fetchExampleData() async {
    // Simula o tempo de resposta de uma API (2 segundos)
    await Future.delayed(const Duration(seconds: 2));

    return ExampleModel(id: '123', title: 'Template Configurado com Sucesso!');
  }
}
