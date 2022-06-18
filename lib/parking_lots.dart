import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class ParkingLots extends StatefulWidget {
  const ParkingLots({Key? key}) : super(key: key);

  @override
  State<ParkingLots> createState() => _ParkingLotsState();
}

class _ParkingLotsState extends State<ParkingLots> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.car_rental_rounded),
        backgroundColor: Colors.green[500],
        centerTitle: true,
        title: Text("Available Lots")),
      
    );
}
}