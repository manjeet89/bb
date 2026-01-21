
class BreedModel {
  String? breedId;
  String? breedCategoryId;
  String? breedName;
  String? breedSlug;
  String? breedImage;
  String? breedDiscountedPrice;
  String? breedStatus;
  String? breedUpdatedOn;
  String? breedCreatedOn;

  BreedModel({this.breedId, this.breedCategoryId, this.breedName, this.breedSlug, this.breedImage, this.breedDiscountedPrice, this.breedStatus, this.breedUpdatedOn, this.breedCreatedOn});

  BreedModel.fromJson(Map<String, dynamic> json) {
    if(json["breed_id"] is String) {
      breedId = json["breed_id"];
    }
    if(json["breed_category_id"] is String) {
      breedCategoryId = json["breed_category_id"];
    }
    if(json["breed_name"] is String) {
      breedName = json["breed_name"];
    }
    if(json["breed_slug"] is String) {
      breedSlug = json["breed_slug"];
    }
    if(json["breed_image"] is String) {
      breedImage = json["breed_image"];
    }
    if(json["breed_discounted_price"] is String) {
      breedDiscountedPrice = json["breed_discounted_price"];
    }
    if(json["breed_status"] is String) {
      breedStatus = json["breed_status"];
    }
    if(json["breed_updated_on"] is String) {
      breedUpdatedOn = json["breed_updated_on"];
    }
    if(json["breed_created_on"] is String) {
      breedCreatedOn = json["breed_created_on"];
    }
  }

  static List<BreedModel> fromList(List<Map<String, dynamic>> list) {
    return list.map(BreedModel.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["breed_id"] = breedId;
    _data["breed_category_id"] = breedCategoryId;
    _data["breed_name"] = breedName;
    _data["breed_slug"] = breedSlug;
    _data["breed_image"] = breedImage;
    _data["breed_discounted_price"] = breedDiscountedPrice;
    _data["breed_status"] = breedStatus;
    _data["breed_updated_on"] = breedUpdatedOn;
    _data["breed_created_on"] = breedCreatedOn;
    return _data;
  }
}