import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:creaphur/common/utils.dart';
import 'package:creaphur/db/main.dart';
import 'package:creaphur/models/expense.dart';
import 'package:creaphur/models/expense_list.dart';
import 'package:creaphur/models/material_list.dart';
import 'package:creaphur/models/profile.dart';
import 'package:creaphur/models/profile_list.dart';
import 'package:creaphur/models/project.dart';
import 'package:creaphur/models/project_list.dart';
import 'package:creaphur/models/time_entry.dart';
import 'package:creaphur/models/time_entry_list.dart';
import 'package:creaphur/models/material.dart' as material_model;
import 'package:creaphur/screens/profile.dart';
import 'package:creaphur/services/expense_service.dart';
import 'package:creaphur/services/material_service.dart';
import 'package:creaphur/services/profile_service.dart';
import 'package:creaphur/services/project_service.dart';
import 'package:creaphur/services/time_entry_service.dart';
import 'package:creaphur/widgets/filled_action_button.dart';
import 'package:creaphur/widgets/outlined_file_picker.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<Profile> profiles =
        Provider.of<ProfileList>(context, listen: true).items;
    Profile currentProfile = Provider.of<Profile>(context, listen: false);

    void selectProfile(String name) async {
      List<Profile> relevantProfiles =
          profiles.where((p) => p.name == name).toList();

      if (relevantProfiles.isNotEmpty) {
        Profile nextProfile = relevantProfiles.first;
        await Utils.load(context, nextProfile);
      }
    }

    void goToProfile() {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ProfileScreen(
                    profile: Profile(id: '', name: ''),
                  )));
    }

    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          DropdownSearch<String>(
              items: profiles.map((p) => p.name).toList(),
              selectedItem: currentProfile.name,
              dropdownDecoratorProps: const DropDownDecoratorProps(
                dropdownSearchDecoration: InputDecoration(
                  labelText: "Current Profile",
                  hintText: "Current Profile Selected",
                ),
              ),
              onChanged: (String? val) => selectProfile(val!)),
          const SizedBox(
            height: 16,
          ),
          FilledActionButton(
            buttonText: 'Add Profile',
            onPressed: goToProfile,
          ),
          OutlinedFilePicker(
            onChange: (contents) async {
              await DatabaseHelper.clearData();
              List<Profile> profiles = [];
              List<material_model.Material> materials = [];
              List<Expense> expenses = [];
              List<TimeEntry> timeEntries = [];
              List<Project> projects = [];
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
                    material_model.Material material =
                        material_model.Material.fromMap(rows[i]);
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
              } on Exception catch (_, e) {
                // to-do add text to screen to say that import failed
                print(e);
                print("Error happened");
              }
            },
            type: FileType.custom,
            childWidget: const Text('Import Save Data'),
          ),
          FilledActionButton(
            onPressed: () async {
              ProfileList profilesList =
                  Provider.of<ProfileList>(context, listen: false);
              MaterialList materials =
                  Provider.of<MaterialList>(context, listen: false);
              ExpenseList expenses =
                  Provider.of<ExpenseList>(context, listen: false);
              TimeEntryList timeEntries =
                  Provider.of<TimeEntryList>(context, listen: false);
              ProjectList projects =
                  Provider.of<ProjectList>(context, listen: false);

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

              for (material_model.Material material in materials.items) {
                materialData +=
                    'material, ${material.id}, , ${material.costPer}, , , , ${"\"${material.image}\""}, , ${Utils.escapeCommas(material.name)}, ${material.quantity}, ${material.quantityType}, ${material.profileId}, , ${Utils.escapeCommas(material.retailer)}, , \n';
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
              final tempFilePath =
                  '${directory.path}/${Utils.saveDataFileName}';

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
              await Share.shareXFiles([XFile(tempFilePath)],
                  text: 'Save your file');

              // Clean up the temporary file
              await tempFile.delete();
            },
            buttonText: 'Export Save Data',
          ),
        ],
      ),
    );
  }
}
