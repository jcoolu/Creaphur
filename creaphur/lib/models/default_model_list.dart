import 'package:creaphur/models/default_model.dart';
import 'package:flutter/foundation.dart';

class DefaultModelList<T extends DefaultModel> extends ChangeNotifier {
  List<T> items = [];

  DefaultModelList(this.items);

  void add(T item) {
    if (items.any((element) => element.id == item.id)) {
      update(item);
    } else {
      items.add(item);
    }

    notifyListeners();
  }

  void remove(T item) {
    if (items.any((element) => element.id == item.id)) {
      items = items.where((element) => element.id != item.id).toList();
      notifyListeners();
    }
  }

  void update(T item) {
    items = items.map((e) {
      if (e.id == item.id) {
        return item;
      }
      return e;
    }).toList();
    notifyListeners();
  }

  void addAll(List<T> updatedItems) {
    for (var updatedItem in updatedItems) {
      add(updatedItem);
    }
    notifyListeners();
  }

  void updateAll(List<T> updatedItems) {
    for (var updatedItem in updatedItems) {
      update(updatedItem);
    }
    notifyListeners();
  }

  bool isDuplicate(String name) => items.map((p) => p.name).contains(name);
}
