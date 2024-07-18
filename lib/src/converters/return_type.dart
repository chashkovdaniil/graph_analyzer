class ReturnTypeConverter {
  final String _returnType;

  ReturnTypeConverter(this._returnType);

  String get inUml {
    var returnType = _returnType;
    if (returnType == 'void') {
      return 'void';
    }
    final regexpList = RegExp(r'List?(<[^>]*>)?');
    regexpList.allMatches(returnType).forEach((final match) {
      final groupOfList = match.group(0);
      final groupOfGeneric = match.group(1);
      if (groupOfList == null) {
        return;
      }
      if (groupOfGeneric == null) {
        returnType = returnType.replaceAll(match.pattern, 'dynamic[0..*]');
      } else {
        returnType = returnType.replaceAll(
            match.pattern, '${_clearString(groupOfGeneric)}[0..*]');
      }
    });
    return returnType.replaceAll('Future<', '').replaceAll('>', '');
  }

  String _clearString(final String input) {
    return input.replaceAll(RegExp(r'[<>]'), '');
  }
}
