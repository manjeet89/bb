class DistrictModelDropDown {
  String? districtId;
  String? stateId;
  String? districtName;
  String? districtStatus;
  String? districtUpdatedOn;
  String? districtCreatedOn;

  DistrictModelDropDown({
    this.districtId,
    this.stateId,
    this.districtName,
    this.districtStatus,
    this.districtUpdatedOn,
    this.districtCreatedOn,
  });

  DistrictModelDropDown.fromJson(Map<String, dynamic> json) {
    if (json["district_id"] is String) {
      districtId = json["district_id"];
    }
    if (json["state_id"] is String) {
      stateId = json["state_id"];
    }
    if (json["district_name"] is String) {
      districtName = json["district_name"];
    }
    if (json["district_status"] is String) {
      districtStatus = json["district_status"];
    }
    if (json["district_updated_on"] is String) {
      districtUpdatedOn = json["district_updated_on"];
    }
    if (json["district_created_on"] is String) {
      districtCreatedOn = json["district_created_on"];
    }
  }

  static List<DistrictModelDropDown> fromList(List<Map<String, dynamic>> list) {
    return list.map(DistrictModelDropDown.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["district_id"] = districtId;
    _data["state_id"] = stateId;
    _data["district_name"] = districtName;
    _data["district_status"] = districtStatus;
    _data["district_updated_on"] = districtUpdatedOn;
    _data["district_created_on"] = districtCreatedOn;
    return _data;
  }

  @override
  String toString() => districtName.toString(); // for DropdownSearch display
}
