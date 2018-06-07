import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'PokemonListItemModel.dart';
import 'PokemonView.dart';


void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Pokedex Demo',
      theme: new ThemeData(
        primarySwatch: Colors.yellow,
      ),
      home: new MyHomePage(),

    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    var futureBuilder = new FutureBuilder(
      future: _getData(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return new Center(child: new CircularProgressIndicator());
          default:
            if (snapshot.hasError)
              return new Text('Error: ${snapshot.error}');
            else
              return createListView(context, snapshot);
        }
      },
    );

    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Pokedex"),
      ),
      body: futureBuilder,
    );
  }

  Future<List<PokemonListItem>> _getData([int index = 0]) async {
    final _pokeItems = <PokemonListItem>[];
    final response = await http.get(
        "https://pokeapi.co/api/v2/pokemon/?limit=20&offset=$index");
    final responseJson = json.decode(response.body);


    for (var pokeItem in responseJson['results']) {
      _pokeItems.add(new PokemonListItem.fromJson(pokeItem));
    }

    return _pokeItems;
  }

  Widget createListView(BuildContext context, AsyncSnapshot snapshot) {
    List<PokemonListItem> values = snapshot.data;

    return new ListView.builder(
      itemCount: values.length,
      itemBuilder: (BuildContext itemContext, int index) {
        return new Column(
          children: <Widget>[
            new ListTile(
              title: new Text('${values[index].name[0].toUpperCase()}${values[index].name.substring(1)}'),
              onTap: () {
                Navigator.push(context, new MaterialPageRoute(builder: (context) => new PokemonView(urlToFetch: values[index].url)));
              },
            ),
            new Divider(height: 2.0),
          ],
        );
      },
    );
  }
}





