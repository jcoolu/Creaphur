import 'package:creaphur/models/default_model_list.dart';
import 'package:creaphur/models/time_entry.dart';

class TimeEntryList extends DefaultModelList<TimeEntry> {
  TimeEntryList(List<TimeEntry> items) : super(items);

  void addTimeEntry(TimeEntry timeEntry) {
    add(timeEntry);
  }

  void removeTimeEntry(TimeEntry timeEntry) {
    remove(timeEntry);
  }

  void updateTimeEntry(TimeEntry timeEntry) {
    update(timeEntry);
  }

  void updateAllTimeEntries(List<TimeEntry> updatedTimeEntries) {
    updateAll(updatedTimeEntries);
  }
}
