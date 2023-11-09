import 'package:asistencia_app/login/login_google.dart';
import 'package:asistencia_app/theme/AppTheme.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:asistencia_app/ui/actividadb/actividad_form.dart';

bool shouldUseFirestoreEmulator = false;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  if (shouldUseFirestoreEmulator) {
    FirebaseFirestore.instance.useFirestoreEmulator('localhost', 8083);
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "FinkaRED",
      theme: AppTheme.themeData,
      debugShowCheckedModeBanner: false,
      home: ActividadForm(),
    );
  }
}
