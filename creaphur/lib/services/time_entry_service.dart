import 'package:creaphur/db/helpers/time_entry_helper.dart';
import 'package:creaphur/models/time_entry.dart';
import 'package:creaphur/models/time_entry_list.dart';
import 'package:provider/provider.dart';

class TimeEntryService {
  static Future<void> addTimeEntry(context, TimeEntry timeEntry) async {
    await TimeEntryHelper.addTimeEntry(timeEntry);
    Provider.of<TimeEntryList>(context, listen: false).add(timeEntry);
  }

  static Future<void> updateTimeEntry(context, TimeEntry timeEntry) async {
    await TimeEntryHelper.updateTimeEntry(timeEntry);
    Provider.of<TimeEntryList>(context, listen: false).update(timeEntry);
  }

  static Future<void> deleteTimeEntry(context, TimeEntry timeEntry) async {
    await TimeEntryHelper.deleteTimeEntry(timeEntry);
    Provider.of<TimeEntryList>(context, listen: false).remove(timeEntry);
  }

  static getTimeEntries(context, String profileId) async {
    List<TimeEntry> timeEntrys =
        await TimeEntryHelper.getAllTimeEntries(profileId);
    Provider.of<TimeEntryList>(context, listen: false).items.clear();
    Provider.of<TimeEntryList>(context, listen: false)
        .addAllTimeEntries(timeEntrys);
  }
}
