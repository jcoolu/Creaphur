class Utils {
  static isCurrencyValid(String value) {
    RegExp regExp = RegExp(r'^\d+(\.\d{2})?$');
    return regExp.hasMatch(value);
  }

  static isQuantityValid(String value) {
    RegExp regExp = RegExp(r'^\d+(\.\d+)?$');
    return regExp.hasMatch(value);
  }

  static int daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inHours / 24).round();
  }
}
