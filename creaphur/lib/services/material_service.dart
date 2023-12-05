import 'package:creaphur/db/helpers/material_helper.dart';
import 'package:creaphur/models/material.dart';
import 'package:creaphur/models/material_list.dart';
import 'package:provider/provider.dart';

class MaterialService {
  static Future<void> addMaterial(context, Material material) async {
    await MaterialHelper.addMaterial(material);
    Provider.of<MaterialList>(context, listen: false).add(material);
  }

  static Future<void> updateMaterial(context, Material material) async {
    await MaterialHelper.updateMaterial(material);
    Provider.of<MaterialList>(context, listen: false).update(material);
  }

  static Future<void> deleteMaterial(context, Material material) async {
    await MaterialHelper.deleteMaterial(material);
    Provider.of<MaterialList>(context, listen: false).remove(material);
  }

  static getMaterials(context, String profileId) async {
    List<Material> materials = await MaterialHelper.getMaterials(profileId);
    Provider.of<MaterialList>(context, listen: false)
        .addAllMaterials(materials);
  }
}
