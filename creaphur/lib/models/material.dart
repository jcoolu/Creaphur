import 'package:creaphur/models/default_model.dart';
import 'package:flutter/material.dart';

class Material extends DefaultModel {
  late Image image;
  late String profileId;
  late double quantity;
  late String quantityType;
  late double costPer;
  late double singleQuantity;

  Material(String id, String name, this.image, this.profileId, this.quantity,
      this.quantityType, this.costPer, this.singleQuantity)
      : super(id, name);

  Material.fromJson(Map<String, dynamic> json)
      : image = Image.network(json['image']),
        profileId = json['profileId'],
        quantity = json['quantity'],
        quantityType = json['quantityType'],
        costPer = json['costPer'],
        singleQuantity = json['singleQuantity'],
        super(json['id'], json['name']);

  Map<String, dynamic> toJson() {
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
