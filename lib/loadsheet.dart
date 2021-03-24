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
                      Alerts.singleAlert(context, 'Copied',
                          'Your loadsheet has been copied to the clipboard. \n You can now paste it into any app.');
                    },
                    child: Text('  Copy to \n Clipboard')),
                ElevatedButton(
                    onPressed: () {
                      Alerts.singleAlert(context, 'Almost there...',
                          'This function is currently being implemented \n and will be available soon. \n\n In the meantime use the Copy to Clipboard \n function and print from any other app');
                    },
                    child: Text('Print Loadsheet')),
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

class Alerts {
  static Widget singleAlert(
      BuildContext context, String title, String message) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: Text(message),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true).pop();
                  },
                  child: Text('Close'))
            ],
          );
        });
  }
}
