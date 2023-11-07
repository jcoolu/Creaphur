class DefaultModel {
  late final String id;
  late final String name;

  DefaultModel(this.id, this.name);

  DefaultModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }
}
