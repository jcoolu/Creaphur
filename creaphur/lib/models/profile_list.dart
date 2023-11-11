import 'package:creaphur/models/default_model_list.dart';
import 'package:creaphur/models/profile.dart';

class ProfileList extends DefaultModelList<Profile> {
  ProfileList(List<Profile> items) : super(items);

  void addProfile(Profile profile) {
    add(profile);
    notifyListeners();
  }

  void removeProfile(Profile profile) {
    remove(profile);
    notifyListeners();
  }

  void updateProfile(Profile profile) {
    update(profile);
    notifyListeners();
  }

  void updateAllProfiles(List<Profile> updatedProfiles) {
    updateAll(updatedProfiles);
    notifyListeners();
  }

  void addAllProfiles(List<Profile> profiles) {
    addAll(profiles);
    notifyListeners();
  }
}
