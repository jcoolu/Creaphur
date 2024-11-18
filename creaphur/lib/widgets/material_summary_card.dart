import 'package:creaphur/models/material.dart' as material_model;
import 'package:creaphur/widgets/image_display.dart';
import 'package:flutter/material.dart';

class MaterialSummaryCard extends StatelessWidget {
  final material_model.Material material;
  final void Function()? onTap;

  const MaterialSummaryCard({
    super.key,
    required this.material,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: Color(0xff6c47ff), width: 2),
        borderRadius: BorderRadius.circular(5),
      ),
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              tileColor: const Color(0xffad99ff),
              textColor: Colors.white,
              splashColor: const Color(0xff2900cc),
              leading:
                  SummaryImage(icon: Icons.assessment, image: material.image),
              title: Text(material.name,
                  softWrap: false,
                  style: const TextStyle(overflow: TextOverflow.ellipsis)),
              subtitle:
                  Text('\$${material.costPer} per ${material.quantityType}'),
            ),
          ],
        ),
      ),
    );
  }
}
