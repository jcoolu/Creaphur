class Project {
  late String id;
  late String name;
  late String description;
  late DateTime startDate;
  late DateTime endDate;
  late double estCost;
  late String ownerId;

  Project(this.id, this.name, this.description, this.startDate, this.endDate,
      this.estCost, this.ownerId);

  Project.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    estCost = json['estCost'];
    ownerId = json['ownerId'];
  }
}
