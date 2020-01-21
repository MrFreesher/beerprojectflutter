class Beer {
  int id;
  String name;
  String tagline;
  String description;
  double abv;
  double ibu;
  String foodParing;
  //String foodParing;

  Beer(this.id, this.name, this.tagline, this.description, this.abv, this.ibu,
      this.foodParing);

  factory Beer.fromJson(Map<String, dynamic> json) {
    return new Beer(
        json["id"] as int,
        json["name"] as String,
        json["tagline"] as String,
        json["description"] as String,
        json["abv"].toDouble(),
        json["ibu"].toDouble(),
        List.from(json["food_pairing"]).join(", "));
  }
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'name': name,
      'tagline': tagline,
      'description': description,
      'abv': abv,
      'ibu': ibu,
      'foodPairing': foodParing
    };
    return map;
  }

  Beer.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
    description = map['description'];
    tagline = map['tagline'];
    abv = map['abv'];
    ibu = map['ibu'];
    foodParing = map['foodPairing'];
  }
}
