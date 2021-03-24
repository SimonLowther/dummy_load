import 'package:dummy_load/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Loadsheet extends StatefulWidget {
  @override
  _LoadsheetState createState() => _LoadsheetState();
}

class _LoadsheetState extends State<Loadsheet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            ButtonBar(
              alignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true).pop();
                  },
                  child: Text('Modify Load'),
                ),
                ElevatedButton(
                    onPressed: () {
                      Clipboard.setData(
                          new ClipboardData(text: MyApp.loadsheet));
                    },
                    child: Text('  Copy to \n Clipboard')),
                ElevatedButton(
                    onPressed: () {}, child: Text('Print Loadsheet')),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 40, 0, 12),
              child: Text(MyApp.loadsheet.toString()),
            ),
          ],
        ),
      ),
    );
  }
}

class Alerts {}
