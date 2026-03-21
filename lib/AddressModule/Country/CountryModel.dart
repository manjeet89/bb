// class CountryDropDownModel {
//   final String id;
//   final String name;

//   CountryDropDownModel({required this.id, required this.name});

//   factory CountryDropDownModel.fromJson(Map<String, dynamic> json) {
//     return CountryDropDownModel(
//       id: json['country_id'] ?? '',
//       name: json['country_name'] ?? '',
//     );
//   }

//   @override
//   String toString() => name; // for DropdownSearch display
// }

class CountryDropDownModel {
  String? countryId;
  String? countryName;
  String? iso3;
  String? iso2;
  String? numericCode;
  String? phoneCode;
  String? capital;
  String? currency;
  String? currencyName;
  String? currencySymbol;
  String? tld;
  String? native;
  String? region;
  String? regionId;
  String? subregion;
  String? subregionId;
  String? nationality;
  String? timezones;
  String? latitude;
  String? longitude;
  String? emoji;
  String? emojiU;

  CountryDropDownModel({
    this.countryId,
    this.countryName,
    this.iso3,
    this.iso2,
    this.numericCode,
    this.phoneCode,
    this.capital,
    this.currency,
    this.currencyName,
    this.currencySymbol,
    this.tld,
    this.native,
    this.region,
    this.regionId,
    this.subregion,
    this.subregionId,
    this.nationality,
    this.timezones,
    this.latitude,
    this.longitude,
    this.emoji,
    this.emojiU,
  });

  CountryDropDownModel.fromJson(Map<String, dynamic> json) {
    if (json["country_id"] is String) {
      countryId = json["country_id"];
    }
    if (json["country_name"] is String) {
      countryName = json["country_name"];
    }
    if (json["iso3"] is String) {
      iso3 = json["iso3"];
    }
    if (json["iso2"] is String) {
      iso2 = json["iso2"];
    }
    if (json["numeric_code"] is String) {
      numericCode = json["numeric_code"];
    }
    if (json["phone_code"] is String) {
      phoneCode = json["phone_code"];
    }
    if (json["capital"] is String) {
      capital = json["capital"];
    }
    if (json["currency"] is String) {
      currency = json["currency"];
    }
    if (json["currency_name"] is String) {
      currencyName = json["currency_name"];
    }
    if (json["currency_symbol"] is String) {
      currencySymbol = json["currency_symbol"];
    }
    if (json["tld"] is String) {
      tld = json["tld"];
    }
    if (json["native"] is String) {
      native = json["native"];
    }
    if (json["region"] is String) {
      region = json["region"];
    }
    if (json["region_id"] is String) {
      regionId = json["region_id"];
    }
    if (json["subregion"] is String) {
      subregion = json["subregion"];
    }
    if (json["subregion_id"] is String) {
      subregionId = json["subregion_id"];
    }
    if (json["nationality"] is String) {
      nationality = json["nationality"];
    }
    if (json["timezones"] is String) {
      timezones = json["timezones"];
    }
    if (json["latitude"] is String) {
      latitude = json["latitude"];
    }
    if (json["longitude"] is String) {
      longitude = json["longitude"];
    }
    if (json["emoji"] is String) {
      emoji = json["emoji"];
    }
    if (json["emojiU"] is String) {
      emojiU = json["emojiU"];
    }
  }

  static List<CountryDropDownModel> fromList(List<Map<String, dynamic>> list) {
    return list.map(CountryDropDownModel.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["country_id"] = countryId;
    data["country_name"] = countryName;
    data["iso3"] = iso3;
    data["iso2"] = iso2;
    data["numeric_code"] = numericCode;
    data["phone_code"] = phoneCode;
    data["capital"] = capital;
    data["currency"] = currency;
    data["currency_name"] = currencyName;
    data["currency_symbol"] = currencySymbol;
    data["tld"] = tld;
    data["native"] = native;
    data["region"] = region;
    data["region_id"] = regionId;
    data["subregion"] = subregion;
    data["subregion_id"] = subregionId;
    data["nationality"] = nationality;
    data["timezones"] = timezones;
    data["latitude"] = latitude;
    data["longitude"] = longitude;
    data["emoji"] = emoji;
    data["emojiU"] = emojiU;
    return data;
  }

  @override
  String toString() => countryName.toString(); // for DropdownSearch display
}
