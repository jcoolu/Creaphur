import 'dart:io';

import 'package:creaphur/models/profile.dart';
import 'package:creaphur/services/expense_service.dart';
import 'package:creaphur/services/material_service.dart';
import 'package:creaphur/services/profile_service.dart';
import 'package:creaphur/services/project_service.dart';
import 'package:creaphur/services/time_entry_service.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

class Utils {
  static const List<String> fields = [
    'type',
    'id',
    'costOfServices',
    'costPer',
    'description',
    'endDate',
    'estCost',
    'image',
    'materialId',
    'name',
    'quantity',
    'quantityType',
    'profileId',
    'projectId',
    'retailer',
    'startDate',
    'status',
  ];
  // ignore: prefer_interpolation_to_compose_strings
  static String csvHeader = Utils.fields.join(',') + ' \n';

  static const saveDataFileName = "creaphur_save_data.csv";

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

  static Future<String> getLocalPath() async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  static Future<File> getSaveFile() async =>
      File('${await Utils.getLocalPath()}/creaphurSaveData.txt');

  static void saveFile(data) async {
    File file = await Utils.getSaveFile();
    file.writeAsString(data.toString());
  }

  static DateTime? parseDateTime(String? dateStr) {
    if (dateStr == null || dateStr.isEmpty) {
      return null;
    }

    List<DateFormat> dateFormats = [
      DateFormat("yyyy-MM-dd H:mm:ss"),
      DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS"),
      DateFormat(
          "yyyy-MM-dd'T'HH:mm:ss"), // To handle the case without milliseconds
    ];

    for (var format in dateFormats) {
      try {
        return format.parse(dateStr.trim());
      } catch (e) {
        // Continue to the next format
      }
    }

    return null; // Return null if no formats match
  }

  static String escapeCommas(String input) {
    return '"$input"';
  }

  static String removeQuotes(String input) {
    return input.replaceAll('"', '');
  }
}
