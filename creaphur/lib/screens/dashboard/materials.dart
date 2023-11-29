import 'package:creaphur/models/material.dart' as material_model;
import 'package:creaphur/models/material_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MaterialsScreen extends StatelessWidget {
  const MaterialsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<material_model.Material> materials =
        Provider.of<MaterialList>(context, listen: true).items;

    return const SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        child: Center(
          child: Text(
              'No materials found. Please click (+) below to create a new material.'),
        ),
      ),
    );
  }
}
