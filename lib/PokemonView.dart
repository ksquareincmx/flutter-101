import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import "PokemonModel.dart";

class PokemonView extends StatelessWidget {
  final String urlToFetch;

  PokemonView({Key key, @required this.urlToFetch}) : super(key:key);

  Future<Pokemon> _getPokemon(String url) async {
    final response = await http.get(url);
    final responseJson = json.decode(response.body);

    return new Pokemon.fromJson(responseJson);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Details"),
      ),
      body: new Center(
          child: new FutureBuilder(
            future: _getPokemon(this.urlToFetch),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                  return new Center(child: new CircularProgressIndicator());
                default:
                  if (snapshot.hasError)
                    return new Text('Error: ${snapshot.error}');
                  else
                    return new Column(children: <Widget>[
                      new Container(
                          margin: const EdgeInsets.only(top: 25.0),
                          child: new Column(
                            children: <Widget>[
                              new Text('${snapshot.data.name[0].toUpperCase()}${snapshot.data.name.substring(1)}', style: new TextStyle(fontSize: 25.0) ),
                              new Image.network(snapshot.data.image)
                            ],
                          )
                      ),
                      new Divider(),
                      new ListTile(
                        title: new Text("Heigth"),
                        leading: const Icon(Icons.accessibility_new),
                        trailing: new Text(snapshot.data.height),
                      ),
                      new Divider(),
                      new ListTile(
                        title: new Text("Weight"),
                        leading: const Icon(Icons.dashboard ),
                        trailing: new Text(snapshot.data.weight),
                      ),
                      new Divider()
                    ],
                    );
              }
            },
          )
      ),
    );
  }
}