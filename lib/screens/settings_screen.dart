import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.blue),
      home: UserProfile(),
      debugShowCheckedModeBanner: false,

    );
  }
}

class UserProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
     
      body: Padding(
        padding: EdgeInsets.all(15.0),
        child: Column(
          children: <Widget>[
            CircleAvatar(
              radius: 50.0,
              backgroundColor: Color.fromRGBO(116, 95, 180, 1),
            ),
            SizedBox(height: 10.0),
            Text('.......', style: TextStyle(fontSize: 24.0)),
            SizedBox(height: 30.0),
            Card(
              child: ListTile(
                leading: Icon(Icons.person),
                title: Text('Age: ...........'),
              ),
            ),
            Card(
              child: ListTile(
                leading: Icon(Icons.email),
                title: Text('..........'),
              ),
            ),
            Card(
              child: ListTile(
                leading: Icon(Icons.favorite),
                title: Text('Height: ......'),
              ),
            ),
            Card(
              child: ListTile(
                leading: Icon(Icons.arrow_upward),
                title: Text('Weight: ....'),
              ),
            ),
            SizedBox(height: 20.0),
            Card(
              child: ListTile(
                leading: Icon(Icons.warning),
                title: Text('...........'),
                subtitle: Text(
                    '...'),
              ),
            ),
          ],
        ),
      ),
    );
    
  }
}
