import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:parking_app/utils.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({Key? key}) : super(key: key);

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  final NameController = TextEditingController();
  final NumberPlateController = TextEditingController();
  final database = FirebaseDatabase.instance.ref().child('lots');
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    // final p1 = {
    //   '01': {'occupied': false},
    //   '02': {'occupied': false},
    //   '03': {'occupied': false},
    //   '04': {'occupied': false},
    //   '05': {'occupied': false},
    //   '06': {'occupied': false},
    //   '07': {'occupied': false},
    //   '08': {'occupied': false},
    //   '09': {'occupied': false},
    //   '10': {'occupied': false},
    //   '11': {'occupied': false},
    //   '12': {'occupied': false},
    //   '13': {'occupied': false},
    //   '14': {'occupied': false},
    //   '15': {'occupied': false},
    //   '16': {'occupied': false},
    //   '17': {'occupied': false},
    //   '18': {'occupied': false},
    //   '19': {'occupied': false},
    //   '20': {'occupied': false},
    // };
    // database.update({'p1': p1, 'p2': p1, 'p3': p1});
  }

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
      appBar: AppBar(
        centerTitle: true,
        title: Text("Book your lot here"),
        leading: Icon(Icons.car_rental_rounded),
      ),
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
                    return 'Please enter a name';
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
              Center(
                child: Text(
                    'Enter your name and number plate above, then click the lot below to book it'),
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
                            onTap: () {
                              try {
                                if (NameController.text.length < 1 ||
                                    NumberPlateController.text.length < 5) {
                                  Utils.showSnackBar(
                                      'Please enter your name and number plate',
                                      Colors.red);
                                  return;
                                }

                                database.child('/$lot/$space/').update({
                                  'name': '${NameController.text}',
                                  'plate number':
                                      '${NumberPlateController.text}',
                                  'occupied': true
                                });
                                Utils.showSnackBar(
                                    'You have booked $lot $space',
                                    Colors.green);
                              } on Exception catch (e) {
                                Utils.showSnackBar(
                                    'An error has occurred', Colors.red);
                              }
                            },
                            leading: Icon(Icons.car_rental),
                            title: Text('Parking lot $lot: $space'),
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
