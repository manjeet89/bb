class Petcategorymodel {
  String? categoryId;
  String? categoryName;
  String? categoryStatus;
  String? categoryUpdatedOn;
  String? categoryCreatedOn;

  Petcategorymodel({
    this.categoryId,
    this.categoryName,
    this.categoryStatus,
    this.categoryUpdatedOn,
    this.categoryCreatedOn,
  });

  Petcategorymodel.fromJson(Map<String, dynamic> json) {
    if (json["category_id"] is String) {
      categoryId = json["category_id"];
    }
    if (json["category_name"] is String) {
      categoryName = json["category_name"];
    }
    if (json["category_status"] is String) {
      categoryStatus = json["category_status"];
    }
    if (json["category_updated_on"] is String) {
      categoryUpdatedOn = json["category_updated_on"];
    }
    if (json["category_created_on"] is String) {
      categoryCreatedOn = json["category_created_on"];
    }
  }

  static List<Petcategorymodel> fromList(List<Map<String, dynamic>> list) {
    return list.map(Petcategorymodel.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["category_id"] = categoryId;
    _data["category_name"] = categoryName;
    _data["category_status"] = categoryStatus;
    _data["category_updated_on"] = categoryUpdatedOn;
    _data["category_created_on"] = categoryCreatedOn;
    return _data;
  }
}
