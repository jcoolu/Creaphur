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
}
