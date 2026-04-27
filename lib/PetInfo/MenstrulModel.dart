
class MenstrulModel {
  String? mcId;
  String? mcPetId;
  String? mcDate;
  String? mcCreatedOn;

  MenstrulModel({this.mcId, this.mcPetId, this.mcDate, this.mcCreatedOn});

  MenstrulModel.fromJson(Map<String, dynamic> json) {
    if(json["mc_id"] is String) {
      mcId = json["mc_id"];
    }
    if(json["mc_pet_id"] is String) {
      mcPetId = json["mc_pet_id"];
    }
    if(json["mc_date"] is String) {
      mcDate = json["mc_date"];
    }
    if(json["mc_created_on"] is String) {
      mcCreatedOn = json["mc_created_on"];
    }
  }

  static List<MenstrulModel> fromList(List<Map<String, dynamic>> list) {
    return list.map(MenstrulModel.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["mc_id"] = mcId;
    _data["mc_pet_id"] = mcPetId;
    _data["mc_date"] = mcDate;
    _data["mc_created_on"] = mcCreatedOn;
    return _data;
  }
}