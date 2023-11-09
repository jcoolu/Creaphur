import 'package:creaphur/models/default_model.dart';

class Project extends DefaultModel {
  final String? description;
  final DateTime startDate;
  final DateTime endDate;
  final double estCost;
  final String ownerId;

  Project(
      {required String id,
      required String name,
      this.description,
      required this.startDate,
      required this.endDate,
      required this.estCost,
      required this.ownerId})
      : super(id: id, name: name);

  factory Project.fromMap(Map<String, dynamic> json) {
    return Project(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        startDate: DateTime.parse(json['startDate']),
        endDate: DateTime.parse(json['endDate']),
        estCost: json['estCost'],
        ownerId: json['ownerId']);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'estCost': estCost,
      'ownerId': ownerId,
    };
  }
}
