// ignore_for_file: sort_constructors_first

enum IconConstants {
  microphone('ic_microphone');

  final String value;

  const IconConstants(this.value);
  String get toPng => 'assets/icons/$value.png';
}
