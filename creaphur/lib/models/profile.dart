import 'package:creaphur/models/default_model.dart';

class Profile extends DefaultModel {
  Profile({required String id, required name}) : super(id: id, name: name);

  int getNumberOfProjects() => 0;

  String getMaterialFunInfo() => 'You have used 3 yards of fabric';

  String getMotivationQuote() => 'Keep Moving Forward';

  Profile.fromMap(Map<String, dynamic> json) : super.fromMap(json);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }
}
