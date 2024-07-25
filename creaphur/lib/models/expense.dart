import 'package:creaphur/models/expense_list.dart';
import 'package:creaphur/models/material.dart';
import 'package:creaphur/models/material_list.dart';
import 'package:provider/provider.dart';

import 'default_model.dart';

class Expense extends DefaultModel {
  final String materialId;
  final String projectId;
  final double quantity;
  final String profileId;

  Expense(
      {required String id,
      required String name,
      required this.materialId,
      required this.projectId,
      required this.quantity,
      required this.profileId})
      : super(id: id, name: name);

  factory Expense.fromMap(Map<String, dynamic> json) {
    return Expense(
      id: json['id'],
      name: json['name'],
      materialId: json['materialId'],
      projectId: json['projectId'],
      quantity: json['quantity'] is String
          ? double.tryParse(json['quantity'])
          : json['quantity'],
      profileId: json['profileId'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'materialId': materialId,
      'projectId': projectId,
      'quantity': quantity,
      'profileId': profileId,
    };
  }

  static Expense getBlankExpense(String projectId, String profileId) => Expense(
        id: '',
        name: '',
        projectId: projectId,
        quantity: 0.00,
        materialId: '',
        profileId: profileId,
      );

  String? getMaterialName(context) {
    List<Expense> expenses =
        Provider.of<ExpenseList>(context, listen: false).items;

    List<Expense>? possibleMatches =
        expenses.where((element) => element.materialId == materialId).toList();

    return possibleMatches.isEmpty ? 'None' : possibleMatches.first.name;
  }

  String getMaterialCost(context) {
    List<Material> materials =
        Provider.of<MaterialList>(context, listen: false).items;

    List<Material>? possibleMatches =
        materials.where((element) => element.id == materialId).toList();

    return possibleMatches.isEmpty
        ? ''
        : (possibleMatches.first.costPer * quantity).toStringAsFixed(2);
  }
}
