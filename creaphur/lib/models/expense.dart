import 'default_model.dart';

class Expense extends DefaultModel {
  late String materialId;
  late String projectId;
  late double quantity;

  Expense(
      String id, String name, this.materialId, this.projectId, this.quantity)
      : super(id, name);

  Expense.fromJson(Map<String, dynamic> json)
      : materialId = json['materialId'],
        projectId = json['projectId'],
        quantity = json['quantity'],
        super(json['id'], json['name']);

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
