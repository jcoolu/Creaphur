class TimeEntry {
  late String id;
  late DateTime startTime;
  late DateTime endTime;
  late int duration;
  late String task;
  late double costOfServices;
  late String projectId;

  TimeEntry(this.id, this.startTime, this.endTime, this.duration, this.task,
      this.costOfServices, this.projectId);
}
