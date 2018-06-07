class Pokemon {
  final int id;
  final String height;
  final String weight;
  final String name;
  final String image;

  Pokemon({
    this.id,
    this.height,
    this.weight,
    this.name,
    this.image
  });

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return new Pokemon(
        id: json['id'],
        height: json['height'].toString(),
        weight: json['weight'].toString(),
        name: json['name'],
        image: json['sprites']['front_default']
    );
  }
}