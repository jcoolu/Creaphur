class Utils {
  static isCurrencyValid(String value) {
    RegExp regExp = RegExp(r'^\d+(\.\d{2})?$');
    return regExp.hasMatch(value);
  }
}
