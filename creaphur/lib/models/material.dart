import 'package:creaphur/models/default_model.dart';
import 'package:flutter/material.dart';

class Material extends DefaultModel {
  final Image? image;
  final String profileId;
  final double quantity;
  final String quantityType;
  final double costPer;
  final double singleQuantity;

  Material(
      {required String id,
      required String name,
      this.image,
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
        image: json['image'] != null ? Image.network(json['image']) : null,
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
      'image': image, // Assuming 'image' is an ImageProvider
      'profileId': profileId,
      'quantity': quantity,
      'quantityType': quantityType,
      'costPer': costPer,
      'singleQuantity': singleQuantity,
    };
  }
}
