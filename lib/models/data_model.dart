
import 'dart:convert';

DataModel dataModelFromJson(String str) => DataModel.fromJson(json.decode(str));

String dataModelToJson(DataModel data) => json.encode(data.toJson());

class DataModel {
  DataModel({
    required this.countries,
  });

  List<Country> countries;

  factory DataModel.fromJson(Map<String, dynamic> json) => DataModel(
  countries: (json['countries'] as Map<String, dynamic>).values
      .map((countryJson) => Country.fromJson(countryJson))
      .toList(),
);


  Map<String, dynamic> toJson() => {
        "countries": Map.fromEntries(
            countries.map((country) => MapEntry(country.name.common, country.toJson()))),
      };
}

class Country {
  Country({
    required this.name,
    required this.capital,
    required this.region,
  });

  CommonName name;
  dynamic capital;
  dynamic region; 


  factory Country.fromJson(Map<String, dynamic> json) => Country(
        name: CommonName.fromJson(json["name"]),
        capital: json["capital"] ?? "", 
        region: json["region"] ?? "",
        
      );

  Map<String, dynamic> toJson() => {
        "name": name.toJson(),
        "capital": capital,
        "region": region,
      };
}


class CommonName {
  CommonName({
    required this.common,
  });

  dynamic common;

  factory CommonName.fromJson(Map<String, dynamic> json) {
    var commonValue = json["common"];
    return CommonName(
      common: commonValue is List ? commonValue.first : commonValue,
    );
  }

  Map<String, dynamic> toJson() => {
        "common": common,
      };
}
