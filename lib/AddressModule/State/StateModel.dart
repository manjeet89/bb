class StateModel {
  String? stateId;
  String? stateName;
  String? countryId;
  String? countryCode;
  String? countryName;
  String? stateCode;
  String? type;
  String? latitude;
  String? longitude;

  StateModel({
    this.stateId,
    this.stateName,
    this.countryId,
    this.countryCode,
    this.countryName,
    this.stateCode,
    this.type,
    this.latitude,
    this.longitude,
  });

  StateModel.fromJson(Map<String, dynamic> json) {
    if (json["state_id"] is String) {
      stateId = json["state_id"];
    }
    if (json["state_name"] is String) {
      stateName = json["state_name"];
    }
    if (json["country_id"] is String) {
      countryId = json["country_id"];
    }
    if (json["country_code"] is String) {
      countryCode = json["country_code"];
    }
    if (json["country_name"] is String) {
      countryName = json["country_name"];
    }
    if (json["state_code"] is String) {
      stateCode = json["state_code"];
    }
    if (json["type"] is String) {
      type = json["type"];
    }
    if (json["latitude"] is String) {
      latitude = json["latitude"];
    }
    if (json["longitude"] is String) {
      longitude = json["longitude"];
    }
  }

  static List<StateModel> fromList(List<Map<String, dynamic>> list) {
    return list.map(StateModel.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["state_id"] = stateId;
    data["state_name"] = stateName;
    data["country_id"] = countryId;
    data["country_code"] = countryCode;
    data["country_name"] = countryName;
    data["state_code"] = stateCode;
    data["type"] = type;
    data["latitude"] = latitude;
    data["longitude"] = longitude;
    return data;
  }

  @override
  String toString() => stateName.toString(); // for DropdownSearch display
}
