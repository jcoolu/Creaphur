class Expense {
  late String id;
  late String materialId;
  late String projectId;
  late double quantity;

  Expense(this.id, this.materialId, this.projectId, this.quantity);

  Expense.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    materialId = json['materialId'];
    projectId = json['projectId'];
    quantity = json['quantity'];
  }
}
