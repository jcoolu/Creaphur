import 'package:creaphur/common/utils.dart';
import 'package:creaphur/models/profile.dart';
import 'package:creaphur/models/profile_list.dart';
import 'package:creaphur/screens/dashboard/main.dart';
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
      await Utils.load(context, profile);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Dashboard()),
      );
    }

    void handleDelete() {
      ProfileService.deleteProfile(context, widget.profile);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Deleted Profile')),
      );

      Navigator.pop(
        context,
        MaterialPageRoute(builder: (context) => const Dashboard()),
      );
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
        title: const Text('Profile'),
        backgroundColor: const Color(0xff2bca70),
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 20),
        actions: <Widget>[
          if (!isNew)
            DeleteDialog(
                isIconButton: true,
                model: 'profile',
                onDelete: Provider.of<ProfileList>(context, listen: false)
                            .items
                            .length >
                        1
                    ? handleDelete
                    : null,
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
            ),
          ),
        ),
      ),
    );
  }
}
