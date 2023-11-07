import 'package:creaphur/models/default_model.dart';

class TimeEntry extends DefaultModel {
  late DateTime startTime;
  late DateTime endTime;
  late int duration;
  late double costOfServices;
  late String projectId;

  TimeEntry(String id, String name, this.startTime, this.endTime, this.duration,
      this.costOfServices, this.projectId)
      : super(id, name);
}
