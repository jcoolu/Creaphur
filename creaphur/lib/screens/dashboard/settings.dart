import 'package:creaphur/common/utils.dart';
import 'package:creaphur/models/profile.dart';
import 'package:creaphur/models/profile_list.dart';
import 'package:creaphur/screens/profile.dart';
import 'package:creaphur/widgets/filled_action_button.dart';
import 'package:creaphur/widgets/outlined_file_picker.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

const buttonWidth = double.infinity;
const buttonHeight = 50.0;

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
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      child: ListView(
        children: <Widget>[
          DropdownSearch<String>(
              items: profiles.map((p) => p.name).toList(),
              selectedItem: currentProfile.name,
              dropdownDecoratorProps: const DropDownDecoratorProps(
                dropdownSearchDecoration: InputDecoration(
                  labelText: "Current Profile",
                  hintText: "Current profile selected.",
                  border: OutlineInputBorder(),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                ),
              ),
              onChanged: (String? val) => selectProfile(val!)),
          const SizedBox(
            height: 22,
          ),
          SizedBox(
            width: buttonWidth,
            height: buttonHeight * 0.8,
            child: FilledActionButton(
              buttonText: 'Add Profile',
              onPressed: goToProfile,
            ),
          ),
          const SizedBox(
            height: 35,
          ),
          const Divider(),
          const SizedBox(
            height: 35,
          ),
          OutlinedFilePicker(
            onChange: (contents) async =>
                Utils.importSaveData(contents, context),
            type: FileType.any,
            childWidget: const Text('Import Save Data'),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: buttonWidth,
            height: buttonHeight,
            child: FilledActionButton(
              onPressed: () async => Utils.exportSaveData(context),
              buttonText: 'Export All Save Data',
            ),
          ),
        ],
      ),
    );
  }
}
