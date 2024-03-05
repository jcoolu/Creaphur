import 'package:creaphur/models/profile.dart';
import 'package:creaphur/services/expense_service.dart';
import 'package:creaphur/services/material_service.dart';
import 'package:creaphur/services/profile_service.dart';
import 'package:creaphur/services/project_service.dart';
import 'package:creaphur/services/time_entry_service.dart';

class Utils {
  static isCurrencyValid(String value) {
    RegExp regExp = RegExp(r'^\d+(\.\d{2})?$');
    return regExp.hasMatch(value);
  }

  static isQuantityValid(String value) {
    RegExp regExp = RegExp(r'^\d+(\.\d+)?$');
    return regExp.hasMatch(value);
  }

  static int daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inHours / 24).round();
  }

  static load(context, Profile profile) async {
    await ProfileService.setCurrent(context, profile);
    await ProjectService.getProjects(context, profile.id);
    await MaterialService.getMaterials(context, profile.id);

    await ExpenseService.getExpenses(context, profile.id);
    await TimeEntryService.getTimeEntries(context, profile.id);
  }

  static String formatDuration(Duration duration) {
    String result = '';

    if (duration.inDays > 0) {
      result += '${duration.inDays} ${duration.inDays == 1 ? 'day' : 'days'}';
    }

    if (duration.inHours.remainder(24) > 0) {
      result +=
          '${result.isEmpty ? '' : ', '}${duration.inHours.remainder(24)} ${duration.inHours.remainder(24) == 1 ? 'hour' : 'hours'}';
    }

    if (duration.inMinutes.remainder(60) > 0) {
      result +=
          '${result.isEmpty ? '' : ', '}${duration.inMinutes.remainder(60)} ${duration.inMinutes.remainder(60) == 1 ? 'minute' : 'minutes'}';
    }

    return result.isEmpty ? '0 minutes' : result;
  }
}
