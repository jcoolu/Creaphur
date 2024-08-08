import 'package:creaphur/common/utils.dart';
import 'package:creaphur/models/material_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FormUtils {
  static String? onValidateBasicString(String? value, String message) {
    if (value == null || value.trim().isEmpty) {
      return message;
    }
    return null;
  }

  static String? onValidateCurrency(String? value, String field, String object,
      Function onChange, String variable) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter a $field for your $object';
    }
    if (!Utils.isCurrencyValid(value)) {
      return 'Please enter a valid format for $field.';
    }
    onChange(variable, double.parse(value));
    return null;
  }

  static String? onValidateQuantity(String? value, String field, String object,
      Function onChange, String variable) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter a $field for your $object';
    }
    if (!Utils.isQuantityValid(value)) {
      return 'Please enter a valid format for $field of $object.';
    }
    onChange(variable, double.parse(value));
    return null;
  }

  static String? onValidateMaterial(
      String? value, BuildContext context, bool isNew) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter a name for your material';
    }

    if (Provider.of<MaterialList>(context, listen: false).isDuplicate(value) &&
        isNew) {
      return 'Duplicate name';
    }

    return null;
  }
}
