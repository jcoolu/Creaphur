import 'package:creaphur/common/utils.dart';
import 'package:creaphur/models/default_model.dart';
import 'package:flutter/cupertino.dart';

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
    try {
      DateTime? startDate = json['startDate'] is String
          ? Utils.parseDateTime(json['startDate'])
          : json['startDate'];
      DateTime? endDate = json['endDate'] is String
          ? Utils.parseDateTime(json['endDate'])
          : json['endDate'];

      if (startDate == null) {
        throw FormatException("Invalid startDate format: ${json['startDate']}");
      }
      if (endDate == null) {
        throw FormatException("Invalid endDate format: ${json['endDate']}");
      }

      return TimeEntry(
          id: json['id'].trim(),
          name: Utils.removeQuotes(json['name']).trim(),
          startDate: startDate,
          endDate: endDate,
          costOfServices: json['costOfServices'] is String
              ? double.tryParse(Utils.removeQuotes(json['costOfServices']))
              : json['costOfServices'],
          projectId: json['projectId'],
          profileId: json['profileId']);
    } catch (e) {
      print('Error in Project.fromMap: $e');
      rethrow;
    }
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

  String getDuration(BuildContext context) =>
      Utils.formatDuration(endDate.difference(startDate));
}
