import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class ParkingLots extends StatefulWidget {
  const ParkingLots({Key? key}) : super(key: key);

  @override
  State<ParkingLots> createState() => _ParkingLotsState();
}

class _ParkingLotsState extends State<ParkingLots> {
  final NameController = TextEditingController();
  final NumberPlateController = TextEditingController();
  final ParkingLotController = TextEditingController();
  final database = FirebaseDatabase.instance.ref().child('lots');

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.car_rental_rounded),
        backgroundColor: Colors.green[500],
        centerTitle: true,
        title: Text("Available Lots")),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text('Name:'),
            TextField(
              controller: NameController,
            ),
            Text('Number plate:'),
            TextField(
              controller: NumberPlateController,
            ),
            Text('Parking lot:'),
            TextField(
              controller: ParkingLotController,
            ),
            Column(
              children: [Text(
                  'Enter your name, number plate & parking lot' '\n(in the format "p* ##") above to unbook it'),
                  ElevatedButton(
                    onPressed: () {
                      database.child('/${ParkingLotController.text.substring(0,2)}/${ParkingLotController.text.substring(3,5)}/').update({
                              'name': null,
                              'plate number': null,
                              'occupied': false,
                            });
                    },
                    child: Text("Unbook")),
              ],
            ),
            Container(
              height: height * 0.6,
              child: StreamBuilder(
                stream: database.onValue,
                builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
                  if (snapshot.hasData) {
                    final data = snapshot.data!.snapshot.value as Map;
                    List filtered = [];
                    data.forEach((key, value) {
                      final parkingLot = key;
                      final lot = value as Map;
                      lot.forEach((key, value) {
                        final number = key;
                        if (value['occupied'] == false) {
                          filtered.add('$parkingLot $number');
                        }
                      });
                    });
                    return ListView.builder(
                      itemBuilder: (context, index) {
                        String info = filtered[index];
                        String lot = info.substring(0, 2);
                        String space = info.substring(3, 5);
                        // return Text('$lot $space');
                        return ListTile(
                          onTap: () {},
                          leading: Icon(Icons.car_rental),
                          title: Text('Parking lot $lot: $space'),
                          trailing: Icon(Icons.circle, color: Colors.green[500],),
                        );
                      },
                      itemCount: filtered.length,
                    );
                  }
                  return Text('hfda');
                },
              ),
            )
          ],
        ),
      ),
    );
}
}