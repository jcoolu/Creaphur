import 'package:creaphur/models/profile.dart';
import 'package:creaphur/models/profile_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfilesScreen extends StatelessWidget {
  const ProfilesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<Profile> profiles =
        Provider.of<ProfileList>(context, listen: true).items;

    return const SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        child: Center(
          child: Text(
              'No profiles found. Please click (+) below to create a new profile.'),
        ),
      ),
    );
  }
}
