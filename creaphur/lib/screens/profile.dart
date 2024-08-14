import 'package:creaphur/common/utils.dart';
import 'package:creaphur/models/profile.dart';
import 'package:creaphur/models/profile_list.dart';
import 'package:creaphur/screens/dashboard/main.dart';
import 'package:creaphur/screens/welcome.dart';
import 'package:creaphur/services/profile_service.dart';
import 'package:creaphur/widgets/delete_dialog.dart';
import 'package:creaphur/widgets/forms/profile_form.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class ProfileScreen extends StatefulWidget {
  final Profile profile;
  const ProfileScreen({super.key, required this.profile});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late String name = widget.profile.name;
  late Profile? newProfile = widget.profile;

  @override
  Widget build(BuildContext context) {
    bool isNew = widget.profile.id.isEmpty;

    void handleBack() {
      Navigator.pop(
        context,
        MaterialPageRoute(builder: (context) => const Dashboard()),
      );
    }

    void handleSave(String value) async {
      setState(() => name = value);
      Profile profile = Profile(
          id: widget.profile.id.isNotEmpty
              ? widget.profile.id
              : const Uuid().v4(),
          name: value);
      if (widget.profile.id.isEmpty) {
        ProfileService.addProfile(context, profile);
      } else {
        await ProfileService.updateProfile(context, profile);
      }

      // Store the current context
      BuildContext currentContext = context;
      // Check if the widget is still mounted before navigating
      if (!mounted) return;

      await Utils.load(currentContext, profile);

      // Check if the widget is still mounted before navigating
      if (!mounted) return;

      Navigator.push(
        currentContext,
        MaterialPageRoute(
            builder: (context) => const Dashboard(
                  previousState: "settings",
                )),
      );
    }

    void handleDelete() {
      Profile selectedProfile =
          Profile(id: widget.profile.id, name: widget.profile.name);
      ProfileService.deleteProfile(context, selectedProfile);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Deleted Profile')),
      );

      if (Provider.of<ProfileList>(context, listen: false).items.isNotEmpty) {
        Profile firstProfile =
            Provider.of<ProfileList>(context, listen: false).items.first;

        ProfileService.setCurrent(context, firstProfile);
      } else {
        ProfileService.setCurrent(context, Profile(id: '', name: ''));
      }
    }

    return Scaffold(
      appBar: AppBar(
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4.0),
          child: Container(
            color: const Color(0xff1d874b),
            height: 3.0,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.chevron_left, color: Colors.white),
          onPressed: handleBack,
        ),
        title: Text(isNew ? 'New Profile' : 'Edit Profile'),
        backgroundColor: const Color(0xff2bca70),
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 20),
        actions: <Widget>[
          if (!isNew)
            DeleteDialog(
                isIconButton: true,
                isDeleteDisabled: false,
                model: 'profile',
                confirmedWidgetPath:
                    Provider.of<ProfileList>(context, listen: false)
                                .items
                                .length ==
                            1
                        ? const WelcomePage()
                        : const Dashboard(
                            previousState: "settings",
                          ),
                onDelete: handleDelete,
                buttonText: 'Delete Profile')
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          child: SingleChildScrollView(
            child: ProfileForm(
              setName: handleSave,
              name: name,
              isNew: isNew,
            ),
          ),
        ),
      ),
    );
  }
}
