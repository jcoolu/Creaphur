import 'package:creaphur/models/default_model_list.dart';
import 'package:creaphur/models/material.dart';

class MaterialList extends DefaultModelList<Material> {
  MaterialList(List<Material> items) : super(items);

  void addMaterial(Material material) {
    add(material);
  }

  void removeMaterial(Material material) {
    remove(material);
  }

  void updateMaterial(Material material) {
    update(material);
  }

  void updateAllMaterials(List<Material> updatedMaterials) {
    updateAll(updatedMaterials);
  }

  void addAllMaterials(List<Material> materials) {
    addAll(materials);
    notifyListeners();
  }
}
