import 'package:creaphur/common/utils.dart';
import 'package:flutter/material.dart';

class DefaultModel extends ChangeNotifier {
  late String id;
  late String name;

  DefaultModel({required this.id, required this.name});

  DefaultModel.fromMap(Map<String, dynamic> json)
      : id = json['id'].trim(),
        name = Utils.removeQuotes(json['name']).trim();
}
