import 'package:creaphur/models/default_model.dart';

class TimeEntry extends DefaultModel {
  final DateTime startDate;
  final DateTime endDate;
  final double costOfServices;
  final String projectId;
  final String profileId;

  TimeEntry(
      {required String id,
      required String name,
      required this.startDate,
      required this.endDate,
      required this.costOfServices,
      required this.projectId,
      required this.profileId})
      : super(id: id, name: name);

  factory TimeEntry.fromMap(Map<String, dynamic> json) {
    return TimeEntry(
        id: json['id'],
        name: json['name'],
        startDate: DateTime.parse(json['startDate'].toString()),
        endDate: DateTime.parse(json['endDate'].toString()),
        costOfServices: json['costOfServices'],
        projectId: json['projectId'],
        profileId: json['profileId']);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'costOfServices': costOfServices,
      'projectId': projectId,
      'profileId': profileId,
    };
  }

  static TimeEntry getBlankTimeEntry(String projectId, String profileId) =>
      TimeEntry(
        id: '',
        name: '',
        projectId: projectId,
        costOfServices: 0.00,
        startDate: DateTime.now().subtract(const Duration(hours: 3)),
        endDate: DateTime.now(),
        profileId: profileId,
      );

  int getTimeInSeconds() => endDate.difference(startDate).inSeconds;
}
