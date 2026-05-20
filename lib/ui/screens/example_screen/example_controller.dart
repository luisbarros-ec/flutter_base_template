import 'package:flutter/material.dart';
import '../../../data/exceptions/app_exceptions.dart';
import '/data/models/example_model.dart';
import '/data/repositories/example_repository.dart';

class ExampleController extends ChangeNotifier {
  final IExampleRepository repository;

  ExampleController({required this.repository});

  ExampleModel? data;
  Exception? activeException;

  Future<void> loadData() async {
    activeException = null;

    try {
      data = await repository.fetchExampleData();
    } on ServerConnectionException catch (e) {
      // Captura o erro específico de conexão
      activeException = e;
    } on ServerTimeoutException catch (e) {
      // Captura o erro específico de timeout
      activeException = e;
    } catch (e) {
      // Captura qualquer outro erro genérico ou erro 500 do backend
      activeException = Exception('unknown');
    } finally {
      notifyListeners();
    }
  }
}
