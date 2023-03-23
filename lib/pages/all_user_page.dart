import 'package:flutter/material.dart';
import 'package:flutter_fstore_project/pages/reg_user_page.dart';
import 'package:flutter_fstore_project/pages/list_user_page.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Все пользователи'),
            ElevatedButton(
              onPressed: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddUserPage(),
                  ),
                )
              },
              child: Text('+', style: TextStyle(fontSize: 20.0)),
              style: ElevatedButton.styleFrom(primary: Color.fromARGB(255, 187, 147, 255)),
            )
          ],
        ),
      ),
      body: ListUserPage(),
    );
  }
}