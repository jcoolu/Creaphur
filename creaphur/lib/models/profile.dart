import 'package:creaphur/models/default_model.dart';

class Profile extends DefaultModel {
  Profile({required String id, required name}) : super(id: id, name: name);

  int getNumberOfProjects() => 0;

  String getMaterialFunInfo() => 'You have used 3 yards of fabric';

  String getMotivationQuote() => 'Keep Moving Forward';

  Profile.fromJson(Map<String, dynamic> json) : super.fromJson(json);

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
