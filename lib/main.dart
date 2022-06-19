import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:parking_app/utils.dart';

import 'home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Home(),
    scaffoldMessengerKey: Utils.messengerKey,
  ));
}
