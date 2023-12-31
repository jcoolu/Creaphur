import 'package:creaphur/models/default_model.dart';

class Project extends DefaultModel {
  final String? description;
  final DateTime startDate;
  final DateTime endDate;
  final double estCost;
  final String profileId;
  final String image;

  Project(
      {required String id,
      required String name,
      this.description,
      required this.startDate,
      required this.endDate,
      required this.estCost,
      required this.profileId,
      required this.image})
      : super(id: id, name: name);

  factory Project.fromMap(Map<String, dynamic> json) {
    return Project(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        startDate: DateTime.parse(json['startDate'].toString()),
        endDate: DateTime.parse(json['endDate'].toString()),
        estCost: json['estCost'],
        profileId: json['profileId'],
        image: json['image'] ?? '');
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
    };
  }

  static Project getBlankProject(String profileId) => Project(
      id: '',
      name: '',
      profileId: profileId,
      startDate: DateTime.now(),
      endDate: DateTime.now().add(const Duration(days: 1)),
      estCost: 0.00,
      image: '');
}
