import 'default_model.dart';

class Expense extends DefaultModel {
  final String materialId;
  final String projectId;
  final double quantity;

  Expense(
      {required String id,
      required String name,
      required this.materialId,
      required this.projectId,
      required this.quantity})
      : super(id: id, name: name);

  factory Expense.fromJson(Map<String, dynamic> json) {
    return Expense(
      id: json['id'],
      name: json['name'],
      materialId: json['materialId'],
      projectId: json['projectId'],
      quantity: json['quantity'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'materialId': materialId,
      'projectId': projectId,
      'quantity': quantity,
    };
  }
}
