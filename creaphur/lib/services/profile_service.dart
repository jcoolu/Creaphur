import 'package:creaphur/db/helpers/profile_helper.dart';
import 'package:creaphur/models/profile.dart';
import 'package:creaphur/models/profile_list.dart';
import 'package:provider/provider.dart';

class ProfileService {
  static Future<void> addProfile(context, Profile profile) async {
    await ProfileHelper.addProfile(profile);
    Provider.of<ProfileList>(context, listen: false).add(profile);
    Provider.of<Profile>(context, listen: false).selectProfile(profile);
  }

  static getProfiles(context) async {
    List<Profile> profiles = await ProfileHelper.getProfiles() ?? [];
    Provider.of<ProfileList>(context, listen: false).addAllProfiles(profiles);
  }

  static setCurrent(context, Profile profile) {
    Provider.of<Profile>(context, listen: false).selectProfile(profile);
  }
}
