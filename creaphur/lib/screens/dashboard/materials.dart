import 'package:creaphur/models/material.dart' as material_model;
import 'package:creaphur/models/material_list.dart';
import 'package:creaphur/screens/material.dart';
import 'package:creaphur/widgets/material_summary_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MaterialsScreen extends StatelessWidget {
  const MaterialsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<material_model.Material> materials =
        Provider.of<MaterialList>(context, listen: true).items;

    void selectMaterial(material_model.Material material) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MaterialScreen(
            material: material,
          ),
        ),
      );
    }

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        child: materials.isEmpty
            ? const Center(
                child: Text(
                    'No materials found. Please click (+) below to create a new material.'),
              )
            : SingleChildScrollView(
                child: Column(
                  children: materials
                      .map(
                        (material) => MaterialSummaryCard(
                          material: material,
                          onTap: () => selectMaterial(material),
                        ),
                      )
                      .toList(),
                ),
              ),
      ),
    );
  }
}
