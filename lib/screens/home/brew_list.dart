import 'package:brew_crew/models/brews.dart';
import 'package:brew_crew/screens/home/brew_tile.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
// provider package is used to get data from stream

class BrewList extends StatefulWidget {
  @override
  _BrewListState createState() => _BrewListState();
}

class _BrewListState extends State<BrewList> {
  @override
  Widget build(BuildContext context) {
    // The stream provider will pass the stream of List of Brew to its child or descendants
    // and then this Brewlist will get that stream data.

    // Now below line comes from the Provider package and then using this we can extract the data
    // brews here is basically List<Brew>

    final brews = Provider.of<List<Brew>>(context);

    return ListView.builder(
      // number of items in our list
      itemCount: brews.length,

      // function which will render individual brew from the list
      itemBuilder: (context, index) {
        return BrewTile(brew: brews[index]);
      },
    );
  }
}
