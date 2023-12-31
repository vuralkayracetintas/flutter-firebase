class FirebaseCustomException implements Exception {
  FirebaseCustomException(
    this.description,
  );

  final String description;

  @override
  String toString() {
    return '$this';
  }
}

class VersionCustomException implements Exception {
  VersionCustomException(
    this.description,
  );

  final String description;

  @override
  String toString() {
    return '$this';
  }
}

class ItemCreateException implements Exception {
  ItemCreateException(this.description);

  final String description;
  @override
  String toString() {
    return '$this $description';
  }
}
