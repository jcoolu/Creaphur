import 'package:creaphur/common/utils.dart';
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
  final double customCost;

  Expense(
      {required String id,
      required String name,
      required this.materialId,
      required this.projectId,
      required this.quantity,
      required this.profileId,
      required this.customCost})
      : super(id: id, name: name);

  factory Expense.fromMap(Map<String, dynamic> json) {
    return Expense(
        id: json['id'].trim(),
        name: Utils.removeQuotes(json['name']).trim(),
        materialId: json['materialId'].trim(),
        projectId: json['projectId'].trim(),
        quantity: json['quantity'] is String
            ? double.tryParse(json['quantity'])
            : json['quantity'],
        profileId: json['profileId'].trim(),
        customCost: json['customCost'] is String
            ? double.tryParse(json['customCost'])
            : json['customCost']);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'materialId': materialId,
      'projectId': projectId,
      'quantity': quantity,
      'profileId': profileId,
      'customCost': customCost
    };
  }

  static Expense getBlankExpense(String projectId, String profileId) => Expense(
        id: '',
        name: '',
        projectId: projectId,
        quantity: 0.00,
        materialId: 'None',
        profileId: profileId,
        customCost: 0.00,
      );

  String? getMaterialName(context) {
    List<Material> materials =
        Provider.of<MaterialList>(context, listen: false).items;

    List<Material>? possibleMatches =
        materials.where((element) => element.id == materialId).toList();

    return possibleMatches.isEmpty ? 'None' : possibleMatches.first.name;
  }

  String getMaterialQuantityType(context) {
    List<Material> materials =
        Provider.of<MaterialList>(context, listen: false).items;

    List<Material>? possibleMatches =
        materials.where((element) => element.id == materialId).toList();

    return possibleMatches.isEmpty ? '' : possibleMatches.first.quantityType;
  }

  String getMaterialCost(context) {
    List<Material> materials =
        Provider.of<MaterialList>(context, listen: false).items;

    List<Material>? possibleMatches =
        materials.where((element) => element.id == materialId).toList();

    return possibleMatches.isEmpty
        ? customCost.toStringAsFixed(2)
        : (possibleMatches.first.costPer * quantity).toStringAsFixed(2);
  }
}
