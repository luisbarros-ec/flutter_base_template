class ExampleModel {
  final String id;
  final String title;

  ExampleModel({required this.id, required this.title});

  factory ExampleModel.fromMap(Map<String, dynamic> map) {
    return ExampleModel(id: map['id'] ?? '', title: map['title'] ?? '');
  }
}
