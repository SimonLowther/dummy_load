import 'package:dummy_load/loadsheet.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static String loadsheet;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Dummy Loadsheet',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: InputPage());
  }
}

class InputPage extends StatelessWidget {
  final TextEditingController regController = new TextEditingController();
  final TextEditingController flightController = new TextEditingController();
  final TextEditingController fromController = new TextEditingController();
  final TextEditingController toController = new TextEditingController();
  final TextEditingController zfwController = new TextEditingController();
  final TextEditingController fuelController = new TextEditingController();
  final TextEditingController pobController = new TextEditingController();
  final TextEditingController burnController = new TextEditingController();
  final TextEditingController indexController = new TextEditingController();
  final TextEditingController finalloadsheetController =
      new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dummy LoadSheet'),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Container(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  TextField(
                    controller: regController,
                    decoration: new InputDecoration(
                        hintText: "Aircraft Reg ie OXA",
                        labelText: 'Registration'),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Aircraft Type:  '),
                      TypeDropDown(),
                    ],
                  ),
                  TextField(
                    controller: flightController,
                    decoration: new InputDecoration(
                        hintText: "Flight Number ie NZ123",
                        labelText: 'Flight Number'),
                  ),
                  TextField(
                    controller: fromController,
                    decoration: new InputDecoration(
                        hintText: "From", labelText: 'From (XXX)'),
                  ),
                  TextField(
                    controller: toController,
                    decoration: new InputDecoration(
                        hintText: "To", labelText: 'To (XXX)'),
                  ),
                  TextField(
                    controller: zfwController,
                    decoration: new InputDecoration(
                        hintText: "ZFW", labelText: 'Zero Fuel Weight (kilos)'),
                  ),
                  TextField(
                    controller: fuelController,
                    decoration: new InputDecoration(
                        hintText: "Fuel", labelText: 'Total Fuel'),
                  ),
                  TextField(
                    controller: burnController,
                    decoration: new InputDecoration(
                        hintText: "Burn", labelText: 'Fuel Burn'),
                  ),
                  TextField(
                    controller: indexController,
                    decoration: new InputDecoration(
                        hintText: 'Not yet implemented', labelText: 'ZFWMAC'),
                  ),
                  TextField(
                    controller: pobController,
                    decoration:
                        new InputDecoration(hintText: "POB", labelText: 'PAX'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      finalloadsheetController.text = createLoadsheet();
                      MyApp.loadsheet =
                          finalloadsheetController.text.toString();
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Loadsheet()));
                    },
                    child: Text('Create Loadsheet'),
                  ),
                  Container(
                    child: TextField(
                      controller: finalloadsheetController,
                      decoration: null,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String createLoadsheet() {
    StringBuffer loadSheetBuffer = new StringBuffer();
    String date = DateFormat('dMMM').format(DateTime.now());
    String time = DateFormat('Hm').format(DateTime.now());
    int tow = (int.parse(zfwController.text) + int.parse(fuelController.text));
    int law = (tow - int.parse(burnController.text));
    int maxTow, maxLaw, maxZfw;
    int outer = 1400;
    int inner = (int.parse(fuelController.text) - 1400);
    int center = 0;

    if (TypeDropDown.type.toString() == 'A321 NEO') {
      maxTow = 97000;
      maxLaw = 79200;
      maxZfw = 75600;
    } else if (TypeDropDown.type.toString() == 'A320 NEO') {
      maxTow = 79000;
      maxLaw = 67400;
      maxZfw = 64300;
    } else if (TypeDropDown.type.toString() == 'A320 CEO') {
      maxTow = 77000;
      maxLaw = 66000;
      maxZfw = 62500;
    } else if (TypeDropDown.type.toString() == 'A320 DOM') {
      maxTow = 71500;
      maxLaw = 66000;
      maxZfw = 62500;
    }

    loadSheetBuffer.writeln('ZK-' +
        regController.text.toUpperCase() +
        ' NZCH ' +
        date.toUpperCase());
    loadSheetBuffer.writeln('LOADSHEET');
    loadSheetBuffer.writeln('EDNO 01');
    loadSheetBuffer.writeln('LOADSHEET FINAL ' + time + ' EDNO 01');
    loadSheetBuffer.writeln(
        flightController.text.toUpperCase() + ' /' + date.toUpperCase());
    loadSheetBuffer.writeln(fromController.text.toUpperCase() +
        ' ' +
        toController.text.toUpperCase() +
        ' ZK-' +
        regController.text.toUpperCase() +
        ' 2/4');
    loadSheetBuffer
        .writeln('NIL SIGNIFICANT CHANGE PRELIM ' + time.toUpperCase());
    loadSheetBuffer.writeln('*************************');
    loadSheetBuffer.writeln('ZFW ' +
        zfwController.text.toString() +
        '    MAX ' +
        maxZfw.toString());
    loadSheetBuffer.writeln('*************************');
    loadSheetBuffer.writeln('TOF ' + fuelController.text.toString());
    loadSheetBuffer
        .writeln('TOW ' + tow.toString() + '    MAX ' + maxTow.toString());
    loadSheetBuffer.writeln('TIF ' + burnController.text.toString());
    loadSheetBuffer
        .writeln('LAW ' + law.toString() + '    MAX ' + maxLaw.toString());
    loadSheetBuffer.writeln('UNDLD ' + 'XXXX');
    loadSheetBuffer.writeln('PAX ' +
        pobController.text.toString() +
        ' TTL ' +
        pobController.text.toString());
    loadSheetBuffer.writeln('PAX ' + pobController.text.toString() + ' PLUS 0');
    loadSheetBuffer.writeln('MACZFW     30.1');
    loadSheetBuffer.writeln('MACTOW    TWO-NINE-DECIMAL-TWO');
    loadSheetBuffer.writeln('CENTER          ' + center.toString());
    loadSheetBuffer.writeln('INNER           ' + inner.toString());
    loadSheetBuffer.writeln('OUTER          ' + outer.toString());
    loadSheetBuffer.writeln('A43 B43 C44');
    loadSheetBuffer.writeln('SEATROW TRIM');
    loadSheetBuffer.writeln('RADIO 1XX.X');
    loadSheetBuffer.writeln('SI BW 41486');
    loadSheetBuffer.writeln('BI 328.0');
    loadSheetBuffer.writeln('SERVICE WEIGHT ADJUSTMENT WEIGHT/INDEX');
    loadSheetBuffer.writeln('ADD');
    loadSheetBuffer.writeln(
        toController.text.toString() + ' POTABLE WATER 3 / 4       75 PCT');
    loadSheetBuffer.writeln('150     5.0-');
    loadSheetBuffer.writeln('DEDUCTIONS');
    loadSheetBuffer.writeln('NIL');
    loadSheetBuffer.writeln('AMADEUS ACARS LOADSHEET.');
    loadSheetBuffer.writeln('PREPARED BY O WRIGHT 001 555 7374');
    loadSheetBuffer.writeln('LICENCE 123456');
    loadSheetBuffer.writeln();
    loadSheetBuffer.writeln('NOTE: NOT FOR OPERATIONAL USE');
    return loadSheetBuffer.toString();
  }
}

class TypeDropDown extends StatefulWidget {
  static String type = 'A320 DOM';
  @override
  _TypeDropDownState createState() => _TypeDropDownState();
}

class _TypeDropDownState extends State<TypeDropDown> {
  String typeValue = 'A320 DOM';

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      value: typeValue,
      icon: Icon(Icons.flight),
      iconSize: 24,
      underline: Container(
        height: 2,
        color: Colors.grey,
      ),
      onChanged: (String newValue) {
        setState(() {
          typeValue = newValue;
          TypeDropDown.type = newValue;
        });
      },
      items: <String>['A320 DOM', 'A320 CEO', 'A320 NEO', 'A321 NEO']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
