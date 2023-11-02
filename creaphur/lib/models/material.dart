import 'package:flutter/material.dart';

class Material {
  late String id;
  late String name;
  late Image image;
  late String profileId;
  late double quantity;
  late String quantityType;
  late double costPer;
  late double singleQuantity;

  Material(this.id, this.name, this.image, this.profileId, this.quantity,
      this.quantityType, this.costPer, this.singleQuantity);

  Material.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    profileId = json['profileId'];
    quantity = json['quantity'];
    quantityType = json['quantityType'];
    costPer = json['costPer'];
    singleQuantity = json['singleQuantity'];
  }
}
