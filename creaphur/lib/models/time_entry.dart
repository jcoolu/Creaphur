import 'package:creaphur/models/default_model.dart';

class TimeEntry extends DefaultModel {
  final DateTime startTime;
  final DateTime endTime;
  final double costOfServices;
  final String projectId;

  TimeEntry(
      {required String id,
      required String name,
      required this.startTime,
      required this.endTime,
      required this.costOfServices,
      required this.projectId})
      : super(id: id, name: name);

  factory TimeEntry.fromMap(Map<String, dynamic> json) {
    return TimeEntry(
      id: json['id'],
      name: json['name'],
      startTime: DateTime.parse(json['startTime']),
      endTime: DateTime.parse(json['endTime']),
      costOfServices: json['costOfServices'],
      projectId: json['projectId'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'startTime': startTime.toIso8601String(),
      'endTime': endTime.toIso8601String(),
      'costOfServices': costOfServices,
      'projectId': projectId,
    };
  }

  static TimeEntry getBlankTimeEntry(String projectId) => TimeEntry(
        id: '',
        name: '',
        projectId: projectId,
        costOfServices: 0.00,
        startTime: DateTime.now().subtract(const Duration(hours: 3)),
        endTime: DateTime.now(),
      );
}
