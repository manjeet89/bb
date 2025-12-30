class BloodGroupModel {
  String? bloodId;
  String? bloodName;
  String? bloodStatus;
  String? bloodCreatedOn;

  BloodGroupModel({this.bloodId, this.bloodName, this.bloodStatus, this.bloodCreatedOn});

  BloodGroupModel.fromJson(Map<String, dynamic> json) {
    if (json["blood_id"] is String) {
      bloodId = json["blood_id"];
    }
    if (json["blood_name"] is String) {
      bloodName = json["blood_name"];
    }
    if (json["blood_status"] is String) {
      bloodStatus = json["blood_status"];
    }
    if (json["blood_created_on"] is String) {
      bloodCreatedOn = json["blood_created_on"];
    }
  }

  static List<BloodGroupModel> fromList(List<Map<String, dynamic>> list) {
    return list.map(BloodGroupModel.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["blood_id"] = bloodId;
    _data["blood_name"] = bloodName;
    _data["blood_status"] = bloodStatus;
    _data["blood_created_on"] = bloodCreatedOn;
    return _data;
  }

  @override
  String toString() => bloodName.toString(); // for DropdownSearch display
}
