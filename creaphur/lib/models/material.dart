import 'package:creaphur/common/utils.dart';
import 'package:creaphur/models/default_model.dart';

class Material extends DefaultModel {
  final String image;
  final String profileId;
  final double quantity;
  final String quantityType;
  final double costPer;
  final String retailer;

  Material({
    required String id,
    required String name,
    required this.image,
    required this.profileId,
    required this.quantity,
    required this.quantityType,
    required this.costPer,
    required this.retailer,
  }) : super(id: id, name: name);

  factory Material.fromMap(Map<String, dynamic> json) {
    return Material(
        id: json['id'].trim(),
        name: Utils.removeQuotes(json['name']).trim(),
        image: Utils.removeQuotes(json['image'].toString().trim()),
        profileId: json['profileId'].trim(),
        quantity: json['quantity'] is String
            ? double.tryParse(json['quantity'])
            : json['quantity'],
        quantityType: Utils.removeQuotes(json['quantityType']).trim(),
        costPer: json['costPer'] is String
            ? double.tryParse(json['costPer'])
            : json['costPer'],
        retailer: Utils.removeQuotes(json['retailer']).trim());
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
      'retailer': retailer,
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
      retailer: 'None / Unknown');
}
