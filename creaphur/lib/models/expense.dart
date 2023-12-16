import 'package:creaphur/models/material.dart';
import 'package:creaphur/models/material_list.dart';
import 'package:provider/provider.dart';

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

  factory Expense.fromMap(Map<String, dynamic> json) {
    return Expense(
      id: json['id'],
      name: json['name'],
      materialId: json['materialId'],
      projectId: json['projectId'],
      quantity: json['quantity'].toDouble(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'materialId': materialId,
      'projectId': projectId,
      'quantity': quantity,
    };
  }

  static Expense getBlankExpense(String projectId) => Expense(
        id: '',
        name: '',
        projectId: projectId,
        quantity: 0.00,
        materialId: '',
      );

  String? getMaterialUnit(context) {
    List<Material> materials =
        Provider.of<MaterialList>(context, listen: false).items;

    List<Material>? possibleMatches =
        materials.where((element) => element.id == materialId).toList();

    return possibleMatches.isEmpty ? null : possibleMatches.first.name;
  }
}
