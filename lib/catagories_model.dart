  
import 'dart:convert';

CatagoriesModel catagoriesModelFromJson(String str) => CatagoriesModel.fromJson(json.decode(str));

String catagoriesModelToJson(CatagoriesModel data) => json.encode(data.toJson());

class CatagoriesModel {
    List<Catagory> catagories;

    CatagoriesModel({
        required this.catagories,
    });

    factory CatagoriesModel.fromJson(Map<String, dynamic> json) => CatagoriesModel(
        catagories: List<Catagory>.from(json["catagories"].map((x) => Catagory.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "catagories": List<dynamic>.from(catagories.map((x) => x.toJson())),
    };
}

class Catagory {
    String name;
    List<String> subcategories;

    Catagory({
        required this.name,
        required this.subcategories,
    });

    factory Catagory.fromJson(Map<String, dynamic> json) => Catagory(
        name: json["name"],
        subcategories: List<String>.from(json["subcategories"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "subcategories": List<dynamic>.from(subcategories.map((x) => x)),
    };
}
