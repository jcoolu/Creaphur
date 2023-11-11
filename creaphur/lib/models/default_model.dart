import 'package:flutter/material.dart';

class DefaultModel extends ChangeNotifier {
  late final String id;
  late final String name;

  DefaultModel({required this.id, required this.name});

  DefaultModel.fromMap(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'];
}
