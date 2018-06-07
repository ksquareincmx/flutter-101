
class PokemonListItem {
  final String name;
  final String url;

  PokemonListItem({this.url, this.name});

  factory PokemonListItem.fromJson(Map<String, dynamic> json) {
    return new PokemonListItem(url: json['url'], name: json['name']);
  }
}