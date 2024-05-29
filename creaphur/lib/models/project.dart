import 'package:creaphur/common/utils.dart';
import 'package:creaphur/models/default_model.dart';
import 'package:creaphur/models/expense.dart';
import 'package:creaphur/models/expense_list.dart';
import 'package:creaphur/models/material.dart';
import 'package:creaphur/models/material_list.dart';
import 'package:creaphur/models/time_entry.dart';
import 'package:creaphur/models/time_entry_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class Project extends DefaultModel {
  final String? description;
  final DateTime startDate;
  final DateTime endDate;
  final double estCost;
  final String profileId;
  final String image;
  final String status;

  Project({
    required String id,
    required String name,
    this.description,
    required this.status,
    required this.startDate,
    required this.endDate,
    required this.estCost,
    required this.profileId,
    required this.image,
  }) : super(id: id, name: name);

  factory Project.fromMap(Map<String, dynamic> json) {
    return Project(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        startDate: DateTime.parse(json['startDate'].toString()),
        endDate: DateTime.parse(json['endDate'].toString()),
        estCost: json['estCost'],
        profileId: json['profileId'],
        image: json['image'] ?? '',
        status: json['status'] ?? Project.getStatuses().first);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'estCost': estCost,
      'profileId': profileId,
      'image': image,
      'status': status
    };
  }

  static Project getBlankProject(String profileId) => Project(
      id: '',
      name: '',
      profileId: profileId,
      startDate: DateTime.now(),
      endDate: DateTime.now().add(const Duration(days: 1)),
      estCost: 0.00,
      image: '',
      status: getStatuses().first);

  String getTotalCost(BuildContext context) {
    List<Expense> expenses = Provider.of<ExpenseList>(context, listen: false)
        .items
        .where((exp) => exp.projectId == id)
        .toList();

    List<double> costs = expenses
        .map(
            (expense) => double.tryParse(expense.getMaterialCost(context)) ?? 0)
        .toList();

    return costs.isEmpty
        ? '\$0.00'
        : '\$${costs.reduce((a, b) => a + b).toStringAsFixed(2)}';
  }

  double getTotal(BuildContext context) {
    List<Expense> expenses = Provider.of<ExpenseList>(context, listen: false)
        .items
        .where((exp) => exp.projectId == id)
        .toList();

    List<double> costs = expenses
        .map(
            (expense) => double.tryParse(expense.getMaterialCost(context)) ?? 0)
        .toList();

    return costs.isEmpty ? 0.00 : costs.reduce((a, b) => a + b);
  }

  List<String> getMaterials(BuildContext context) {
    List<Expense> expenses = Provider.of<ExpenseList>(context, listen: false)
        .items
        .where((exp) => exp.projectId == id)
        .toList();
    List<String> materials = [];

    for (Expense exp in expenses) {
      if (exp.materialId.isNotEmpty) {
        Material? material = Provider.of<MaterialList>(context, listen: false)
            .getRelatedMaterialObject(exp.materialId);
        if (material != null) {
          materials.add(
              '${exp.quantity} ${material.quantityType} of ${material.name}');
        }
      }
    }
    return materials;
  }

  static String notStarted = 'Not Started';

  static String inProgress = 'In Progress';

  static String finished = 'Completed';

  static List<String> getStatuses() => [notStarted, inProgress, finished];

  String getTotalHours(BuildContext context) {
    List<TimeEntry> timeEntries =
        Provider.of<TimeEntryList>(context, listen: false)
            .items
            .where((time) => time.projectId == id)
            .toList();

    int timeSum = timeEntries.isEmpty
        ? 0
        : timeEntries
            .map((time) => time.getTimeInSeconds())
            .reduce((value, element) => value + element);
    Duration durationOfTime = Duration(seconds: timeSum);
    return Utils.formatDuration(durationOfTime);
  }

  String getCostOfServices(BuildContext context) {
    List<TimeEntry> timeEntries =
        Provider.of<TimeEntryList>(context, listen: false)
            .items
            .where((time) => time.projectId == id)
            .toList();
    if (timeEntries.isEmpty) {
      return '\$0.00';
    }
    double costSum = timeEntries.map((time) => time.costOfServices).reduce(
        (value, element) => double.parse((value + element).toStringAsFixed(2)));

    return '\$${costSum.toString()}';
  }
}
