class DefaultModel {
  final String id;
  final String name;

  DefaultModel({required this.id, required this.name});

  DefaultModel.fromMap(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'];
}
