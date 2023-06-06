import 'package:firebase2/drawer.dart';
import 'package:firebase2/widgets/data_card.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class IoT_Page extends StatefulWidget {
  const IoT_Page({Key? key}) : super(key: key);

  @override
  State<IoT_Page> createState() => _IoT_PageState();
}

class _IoT_PageState extends State<IoT_Page> {
  final DatabaseReference databaseReference = FirebaseDatabase.instance.ref();

  String tempData = '0';
  String humData = '0';
  double temValue = 0.0;
  double humValue = 0.0;

  @override
  void initState() {
    super.initState();
    final DatabaseReference nodeReference =
        databaseReference.child('/ESP32_APP');
    final DatabaseReference key1Reference = nodeReference.child('/TEMPERATURE');
    final DatabaseReference key2Reference = nodeReference.child('/HUMIDITY');
    key1Reference.onValue.listen((event) {
      setState(() {
        tempData = event.snapshot.value.toString();
        temValue = double.parse(tempData) / 100;
      });
    });
    key2Reference.onValue.listen((event) {
      setState(() {
        humData = event.snapshot.value.toString();
        humValue = double.parse(humData) / 100;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffe2e3eb),
      appBar: AppBar(
        title: Text("IoT Monitor"),
        backgroundColor: Colors.green,
        elevation: 0,
      ),
      drawer: CustomDrawer(),
      body: SizedBox(
          width: double.infinity,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      DataCard(
                        data: tempData,
                        name: "TEMPERATURE",
                        value: temValue,
                      ),
                      DataCard(
                        data: humData,
                        name: "HUMIDTY",
                        value: humValue,
                      ),
                    ]),
                SizedBox(height: 30),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      DataCard(
                        data: "0",
                        name: "SOIL MOISTURE",
                        value: 0.0,
                      ),
                      DataCard(
                        data: "0",
                        name: "SOIL NUTRIENT",
                        value: 0.0,
                      ),
                    ])
              ],
            ),
          )),
    );
  }
}
