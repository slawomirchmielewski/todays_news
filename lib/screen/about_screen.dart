import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("About"),
        ),
        body: Column(
          children: [
            ListTile(
              leading: Icon(Icons.account_circle),
              title: Text("Developer"),
              subtitle: Text("Slawomir Chmielewski"),
            ),
            ListTile(
              leading: Icon(Icons.info_outline),
              title: Text("Version"),
              subtitle: Text("1.0"),
            ),
            ListTile(
              leading: Icon(Icons.language),
              title: Text("News Provider"),
              subtitle: Text("www.currentsapi.services"),
            )
          ],
        ));
  }
}
