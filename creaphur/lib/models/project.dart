import 'package:creaphur/models/default_model.dart';

class Project extends DefaultModel {
  late String description;
  late DateTime startDate;
  late DateTime endDate;
  late double estCost;
  late String ownerId;

  Project(String id, String name, this.description, this.startDate,
      this.endDate, this.estCost, this.ownerId)
      : super(id, name);

  Project.fromJson(Map<String, dynamic> json)
      : description = json['description'],
        startDate = DateTime.parse(json['startDate']),
        endDate = DateTime.parse(json['endDate']),
        estCost = json['estCost'],
        ownerId = json['ownerId'],
        super(json['id'], json['name']);

  Map<String, dynamic> toJson() {
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
