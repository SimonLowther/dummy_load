import 'package:flutter/material.dart';

class Loadsheet extends StatefulWidget {
  @override
  _LoadsheetState createState() => _LoadsheetState();
}

class _LoadsheetState extends State<Loadsheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pop();
            },
            child: Text('Modify Load'),
          ),
        ],
      ),
    );
  }
}
