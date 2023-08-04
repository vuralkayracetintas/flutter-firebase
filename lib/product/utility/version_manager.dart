import 'package:flutter_firebase/product/utility/exception/exception.dart';

class VersionManager {
  VersionManager({
    required this.deviceValue,
    required this.databaseValue,
  });

  final String deviceValue;
  final String databaseValue;

  bool isNeedUpdate() {
    final deviveNumberSplit = deviceValue.split('.').join('');
    final databaseNumberSplit = databaseValue.split('.').join('');

    final deviceNumber = int.tryParse(deviveNumberSplit);
    final dbNumber = int.tryParse(databaseNumberSplit);

    if (deviceNumber == null || dbNumber == null) {
      throw VersionCustomException(
        '$deviceNumber or $databaseValue is not int',
      );
    }

    return deviceNumber < dbNumber;
  }
}
