import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fstore_project/pages/update_user_page.dart';

class ListUserPage extends StatefulWidget {
  ListUserPage({Key? key}) : super(key: key);

  @override
  _ListUserPageState createState() => _ListUserPageState();
}

class _ListUserPageState extends State<ListUserPage> {
  final Stream<QuerySnapshot> usersStream =
      FirebaseFirestore.instance.collection('users').snapshots();

  CollectionReference users =
      FirebaseFirestore.instance.collection('users');
  Future<void> deleteUser(id) {
    return users
        .doc(id)
        .delete()
        .then((value) => print('Пользователь удален'))
        .catchError((error) => print('Ошибка удаления пользователя: $error'));
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: usersStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            print('Что-то пошло не так');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          final List storedocs = [];
          snapshot.data!.docs.map((DocumentSnapshot document) {
            Map a = document.data() as Map<String, dynamic>;
            storedocs.add(a);
            a['id'] = document.id;
          }).toList();

          return Container(
            margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Table(
                border: TableBorder.all(),
                columnWidths: const <int, TableColumnWidth>{
                  1: FixedColumnWidth(140),
                },
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                children: [
                  TableRow(
                    children: [
                      TableCell(
                        child: Container(
                          color: Color.fromARGB(255, 187, 147, 255),
                          child: Center(
                            child: Text(
                              'Имя',
                              style: TextStyle(
                                fontSize: 17.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Container(
                          color: Color.fromARGB(255, 187, 147, 255),
                          child: Center(
                            child: Text(
                              'Почта',
                              style: TextStyle(
                                fontSize: 17.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Container(
                          color: Color.fromARGB(255, 187, 147, 255),
                          child: Center(
                            child: Text(
                              'Действие',
                              style: TextStyle(
                                fontSize: 17.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  for (var i = 0; i < storedocs.length; i++) ...[
                    TableRow(
                      children: [
                        TableCell(
                          child: Center(
                              child: Text(storedocs[i]['name'],
                                  style: TextStyle(fontSize: 18.0))),
                        ),
                        TableCell(
                          child: Center(
                              child: Text(storedocs[i]['email'],
                                  style: TextStyle(fontSize: 18.0))),
                        ),
                        TableCell(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                onPressed: () => {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => UpdateUserPage(
                                          id: storedocs[i]['id']),
                                    ),
                                  )
                                },
                                icon: Icon(
                                  Icons.edit_note_rounded,
                                  color: Color.fromARGB(255, 95, 100, 237),
                                ),
                              ),
                              IconButton(
                                onPressed: () =>
                                    {deleteUser(storedocs[i]['id'])},
                                icon: Icon(
                                  Icons.delete_sweep_rounded,
                                  color: Color.fromARGB(255, 95, 100, 237)
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          );
      });
  }
}