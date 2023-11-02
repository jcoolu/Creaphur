class Profile {
  late String id;
  late String name;

  Profile(this.id, this.name);

  // to-do later
  int getNumberOfProjects() => 0;

  //to-do later
  String getMaterialFunInfo() => 'You have used 3 yards of fabric';

  // to-do later
  String getMotivationQuote() => 'Keep  Moving Forward';

  Profile.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }
}
