import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fstore_project/pages/all_user_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          print("Что-то пошло не так");
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            title: 'Firestore',
            theme: ThemeData(
              primarySwatch: Colors.deepPurple,
            ),
            debugShowCheckedModeBanner: false,
            home: HomePage(),
          );
        }
        return CircularProgressIndicator();
      },
    );
  }
}