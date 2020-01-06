class Beer {
  final String name;
  final String tagline;
  final String description;
  final double abv;
  final double ibu;
  String foodParing;
  //String foodParing;

  Beer(this.name, this.tagline, this.description, this.abv, this.ibu,
      this.foodParing);

  factory Beer.fromJson(Map<String, dynamic> json) {
    return new Beer(
        json["name"] as String,
        json["tagline"] as String,
        json["description"] as String,
        json["abv"].toDouble(),
        json["ibu"].toDouble(),
        List.from(json["food_pairing"]).join(", "));
  }
}
