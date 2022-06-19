import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:parking_app/utils.dart';

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
        child: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              Text('Name:'),
              TextFormField(
                controller: NameController,
                validator: (name) {
                  if (name != null && name.length < 1) {
                    return 'Please enter your name';
                  } else {
                    return null;
                  }
                },
              ),
              Text('Number plate:'),
              TextFormField(
                controller: NumberPlateController,
                validator: (numberplate) {
                  if (numberplate != null && numberplate.length < 5) {
                    return 'Please enter a number plate (min 5 characters)';
                  } else {
                    return null;
                  }
                },
              ),
              Column(
                children: [
                  Text(
                      'Enter your name and number plate then click the lot you booked to unbook it'),
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
                          filtered.add('$parkingLot $number');
                        });
                      });
                      return ListView.builder(
                        itemBuilder: (context, index) {
                          String info = filtered[index];
                          String lot = info.substring(0, 2);
                          String space = info.substring(3, 5);
                          String name = NameController.text;
                          String numberPlate = NumberPlateController.text;
                          bool occupied = data[lot][space]['occupied'];
                          return ListTile(
                            onTap: () {
                              try {
                                if (name != data[lot][space]['name'] ||
                                    numberPlate !=
                                        data[lot][space]['plate number']) {
                                  Utils.showSnackBar(
                                      'Please enter the correct name and number plate or tap on an occupied lot',
                                      Colors.red);
                                  return;
                                }

                                database.child('/$lot/$space/').update({
                                  'name': null,
                                  'plate number': null,
                                  'occupied': false,
                                });
                                Utils.showSnackBar(
                                    'You have unbooked $lot $space',
                                    Colors.green);
                              } on Exception catch (e) {
                                Utils.showSnackBar(
                                    'An error has occured', Colors.red);
                              }
                            },
                            leading: Icon(Icons.car_rental),
                            title: Text('Parking lot $lot: $space'),
                            trailing: Icon(
                              Icons.circle,
                              color: occupied ? Colors.red : Colors.green,
                            ),
                          );
                        },
                        itemCount: filtered.length,
                      );
                    }
                    return Text('Loading');
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
