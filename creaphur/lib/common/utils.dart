import 'dart:io';

import 'package:creaphur/db/main.dart';
import 'package:creaphur/models/expense.dart';
import 'package:creaphur/models/expense_list.dart';
import 'package:creaphur/models/material.dart';
import 'package:creaphur/models/material_list.dart';
import 'package:creaphur/models/profile.dart';
import 'package:creaphur/models/profile_list.dart';
import 'package:creaphur/models/project.dart';
import 'package:creaphur/models/project_list.dart';
import 'package:creaphur/models/time_entry.dart';
import 'package:creaphur/models/time_entry_list.dart';
import 'package:creaphur/services/expense_service.dart';
import 'package:creaphur/services/material_service.dart';
import 'package:creaphur/services/profile_service.dart';
import 'package:creaphur/services/project_service.dart';
import 'package:creaphur/services/time_entry_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

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

  static void exportSaveData(BuildContext context) async {
    ProfileList profilesList = Provider.of<ProfileList>(context, listen: false);
    MaterialList materials = Provider.of<MaterialList>(context, listen: false);
    ExpenseList expenses = Provider.of<ExpenseList>(context, listen: false);
    TimeEntryList timeEntries =
        Provider.of<TimeEntryList>(context, listen: false);
    ProjectList projects = Provider.of<ProjectList>(context, listen: false);

    String header = Utils.csvHeader;

    String profileData = '';
    String materialData = '';
    String expenseData = '';
    String timeEntryData = '';
    String projectData = '';

    // type, id, costOfServices, costPer, description, endDate, estCost, image, materialId, name, quantity, quantityType, profileId, projectId, retailer, startDate, status

    for (Profile profile in profilesList.items) {
      profileData +=
          'profile, ${profile.id}, , , , , , , , ${Utils.escapeCommas(profile.name)}, , , , , , , \n';
    }

    for (Material material in materials.items) {
      materialData +=
          'material, ${material.id}, , ${material.costPer}, , , , ${"\"${material.image}\""}, , ${Utils.escapeCommas(material.name)}, , ${material.quantityType}, ${material.profileId}, , ${Utils.escapeCommas(material.retailer)}, , \n';
    }

    for (Expense expense in expenses.items) {
      expenseData +=
          'expense, ${expense.id}, , , , , , , ${expense.materialId}, ${Utils.escapeCommas(expense.name)}, ${expense.quantity}, , ${expense.profileId}, ${expense.projectId}, , , \n';
    }

    for (TimeEntry timeEntry in timeEntries.items) {
      timeEntryData +=
          'timeEntry, ${timeEntry.id}, ${Utils.escapeCommas(timeEntry.costOfServices.toString())}, , , ${timeEntry.endDate}, , , , ${Utils.escapeCommas(timeEntry.name)}, , , ${timeEntry.profileId}, ${timeEntry.projectId}, , ${timeEntry.startDate}, \n';
    }

    for (Project project in projects.items) {
      projectData +=
          'project, ${project.id}, , , ${Utils.escapeCommas(project.description ?? '')}, ${project.endDate}, ${Utils.escapeCommas(project.estCost.toString())}, ${project.image}, , ${Utils.escapeCommas(project.name)}, , , ${project.profileId}, , , ${project.startDate}, ${project.status} \n';
    }

    final directory = await getTemporaryDirectory();
    final tempFilePath = '${directory.path}/${Utils.saveDataFileName}';

    // Create and write to a temporary file
    final tempFile = File(tempFilePath);
    final data = header +
        profileData +
        materialData +
        expenseData +
        timeEntryData +
        projectData;
    await tempFile.writeAsString(data);

    // Use the share plugin to let the user choose where to save the file
    await Share.shareXFiles([XFile(tempFilePath)], text: 'Save your file');

    // Clean up the temporary file
    await tempFile.delete();
  }

  static void importSaveData(contents, context) async {
    try {
      // Split the content into lines
      List<String> lines = contents.split('\n');

      // Remove any empty lines (e.g., the last line after a newline character)
      lines.removeWhere((line) => line.trim().isEmpty);

      // Extract the header
      List<String> headers = lines.first.split(',');

      // Process each line into a map
      List<Map<String, String>> rows = lines.skip(1).map((line) {
        List<String> values = line.split(',');
        Map<String, String> row = {};
        for (int i = 0; i < headers.length; i++) {
          row[headers[i]] = values[i];
        }
        return row;
      }).toList();

      if (rows.isNotEmpty) {
        await DatabaseHelper.clearData();
        // Loop through each row and print values
        for (int i = 0; i < rows.length; i++) {
          if (rows[i]['type'] == 'profile') {
            Profile profile = Profile.fromMap(rows[i]);
            await ProfileService.addProfile(context, profile);
          }
          if (rows[i]['type'] == 'timeEntry') {
            TimeEntry timeEntry = TimeEntry.fromMap(rows[i]);
            await TimeEntryService.addTimeEntry(context, timeEntry);
          }
          if (rows[i]['type'] == 'material') {
            Material material = Material.fromMap(rows[i]);
            await MaterialService.addMaterial(context, material);
          }
          if (rows[i]['type'] == 'project') {
            Project project = Project.fromMap(rows[i]);
            await ProjectService.addProject(context, project);
          }
          if (rows[i]['type'] == 'expense') {
            Expense expense = Expense.fromMap(rows[i]);
            await ExpenseService.addExpense(context, expense);
          }
        }
      }
      ProfileList profilesList =
          Provider.of<ProfileList>(context, listen: false);
      if (profilesList.items.isNotEmpty) {
        ProfileService.setCurrent(context, profilesList.items.first);
      }
    } on Exception catch (_, e) {
      // to-do add text to screen to say that import failed
      print(e);
      print("Error happened while importing Save Data");
    }
  }
}
