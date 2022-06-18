import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:parking_app/parking_lots.dart';

import 'first_screen.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final NameController = TextEditingController();
  final NumberPlateController = TextEditingController();
  final database = FirebaseDatabase.instance.ref().child('lots');
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    // final p1 = {'01': false,'02': false,'03': false,'04': false,'05': false,
    // '06': false,'07': false,'08': false,'09': false,'10': false,
    // '11': false,'12': false,'13': false,'14': false,'15': false,
    // '16': false,'17': false,'18': false,'19': false,'20': false,};
    // final value = {'p1': p1};
    // database.update({'lots': {'p1': p1, 'p2': p1, 'p3': p1}});
  }

  static const List<Widget> _screenList = [
    FirstScreen(),
    ParkingLots(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

  }


  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
        final width = MediaQuery.of(context).size.width;
    

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: _screenList[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_parking_rounded),
            label: 'Free lots',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
