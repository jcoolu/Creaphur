import 'package:creaphur/common/utils.dart';
import 'package:creaphur/models/profile.dart';
import 'package:creaphur/models/profile_list.dart';
import 'package:creaphur/screens/profile.dart';
import 'package:creaphur/widgets/filled_action_button.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
        ],
      ),
    );
  }
}
