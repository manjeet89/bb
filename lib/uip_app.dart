class UipApp {
  final String? packageName;
  final String? applicationName;
  final String? version;

  UipApp(this.packageName, this.applicationName, this.version);

  factory UipApp.fromJson(Map<String, dynamic> parsedJson) {
    return UipApp(
      parsedJson['packageName'],
      parsedJson['applicationName'],
      parsedJson['version'].toString(),
    );
  }
}
