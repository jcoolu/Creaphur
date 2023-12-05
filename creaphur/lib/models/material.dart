import 'package:creaphur/models/default_model.dart';

class Material extends DefaultModel {
  final String image;
  final String profileId;
  final double quantity;
  final String quantityType;
  final double costPer;
  final double singleQuantity;

  Material(
      {required String id,
      required String name,
      required this.image,
      required this.profileId,
      required this.quantity,
      required this.quantityType,
      required this.costPer,
      required this.singleQuantity})
      : super(id: id, name: name);

  factory Material.fromMap(Map<String, dynamic> json) {
    return Material(
        id: json['id'],
        name: json['name'],
        image: json['image'] ?? '',
        profileId: json['profileId'],
        quantity: json['quantity'],
        quantityType: json['quantityType'],
        costPer: json['costPer'],
        singleQuantity: json['singleQuantity']);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'profileId': profileId,
      'quantity': quantity,
      'quantityType': quantityType,
      'costPer': costPer,
      'singleQuantity': singleQuantity,
    };
  }

  static Material getBlankMaterial(String profileId) => Material(
      id: '',
      name: '',
      profileId: profileId,
      quantity: 0.00,
      quantityType: 'Each',
      costPer: 0.00,
      image: '',
      singleQuantity: 1);
}
