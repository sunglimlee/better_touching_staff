import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BrewList extends StatefulWidget {
  const BrewList({Key? key}) : super(key: key);

  @override
  State<BrewList> createState() => _BrewListState();
}

class _BrewListState extends State<BrewList> {
  @override
  Widget build(BuildContext context) {
    final querySnapshot = Provider.of<QuerySnapshot?>(context);
    if (querySnapshot != null) {
      print(querySnapshot.docs);
      for (var doc in querySnapshot.docs) {
        print(doc.data.toString());
      }
    }
    return Container();
  }
}
