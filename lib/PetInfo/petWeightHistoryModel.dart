class Petweighthistorymodel {
  String? weightId;
  String? weightPetId;
  String? weightOwnerId;
  String? weightCurrent;
  String? weightUpdateOn;
  String? weightCreatedOn;

  Petweighthistorymodel({
    this.weightId,
    this.weightPetId,
    this.weightOwnerId,
    this.weightCurrent,
    this.weightUpdateOn,
    this.weightCreatedOn,
  });

  Petweighthistorymodel.fromJson(Map<String, dynamic> json) {
    if (json["weight_id"] is String) {
      weightId = json["weight_id"];
    }
    if (json["weight_pet_id"] is String) {
      weightPetId = json["weight_pet_id"];
    }
    if (json["weight_owner_id"] is String) {
      weightOwnerId = json["weight_owner_id"];
    }
    if (json["weight_current"] is String) {
      weightCurrent = json["weight_current"];
    }
    if (json["weight_update_on"] is String) {
      weightUpdateOn = json["weight_update_on"];
    }
    if (json["weight_created_on"] is String) {
      weightCreatedOn = json["weight_created_on"];
    }
  }

  static List<Petweighthistorymodel> fromList(List<Map<String, dynamic>> list) {
    return list.map(Petweighthistorymodel.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["weight_id"] = weightId;
    _data["weight_pet_id"] = weightPetId;
    _data["weight_owner_id"] = weightOwnerId;
    _data["weight_current"] = weightCurrent;
    _data["weight_update_on"] = weightUpdateOn;
    _data["weight_created_on"] = weightCreatedOn;
    return _data;
  }
}
