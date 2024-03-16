import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late FlutterBluetoothSerial bluetooth = FlutterBluetoothSerial.instance;
  BluetoothConnection? connection;
  bool isConnected = false;
  List<BluetoothDevice> devicesList = [];

  // Sensor data with units
  String heartRate = "Waiting...";
  String temperature = "Waiting...";
  String steps = "Waiting...";

  @override
  void initState() {
    super.initState();
    initBluetooth();
  }

  void initBluetooth() async {
    await FlutterBluetoothSerial.instance.requestEnable();
    devicesList = await bluetooth.getBondedDevices();

    for (BluetoothDevice device in devicesList) {
      if (device.name == 'HC-05') {
        try {
          connection = await BluetoothConnection.toAddress(device.address);
          setState(() {
            isConnected = true;
          });

          connection!.input!.listen((Uint8List data) {
            String dataString = String.fromCharCodes(data).trim();
            updateSensorData(dataString);
          }).onDone(() {
            setState(() {
              isConnected = false;
            });
          });
        } catch (e) {
          print("Error connecting to device: $e");
        }
        break;
      }
    }
  }

  void updateSensorData(String data) {
    List<String> readings = data.split(';');
    for (String reading in readings) {
      List<String> parts = reading.split(':');
      if (parts.length == 2) {
        String key = parts[0].trim();
        String value = parts[1].trim();
        switch (key) {
          case 'Heart Rate':
            heartRate = "$value BPM";
            break;
          case 'Temp':
            temperature = "$value C";
            break;
          case 'Movement':
            steps = "$value steps";
            break;
        }
      }
    }
    setState(() {});
  }

  Widget buildGridCard({
    required String title,
    required Color color,
    required Color ancColor,
    required String data,
    String icon = '',
  }) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(13),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    color: Colors.white60,
                  ),
                ),
                const SizedBox(height: 25),
                Text(
                  data,
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          if (icon.isNotEmpty)
            Positioned(
              top: -1,
              right: -1,
              child: CircleAvatar(
                radius: 32,
                backgroundColor: ancColor,
                child: SvgPicture.asset(
                  icon,
                  height: 30,
                  width: 30,
                  color: Colors.white54,
                ),
              ),
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          isConnected ? 'Connected to HC-05' : 'Disconnected',
          style: TextStyle(
            color: isConnected ? Colors.green : Color(0xFFa04e68),
          ),
        ),
        iconTheme: IconThemeData(
          color: isConnected ? Colors.green : Color(0xFFa04e68),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: AnimationLimiter(
          child: GridView.count(
            crossAxisCount: 2,
            childAspectRatio: 1.5,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
            children: AnimationConfiguration.toStaggeredList(
              duration: const Duration(milliseconds: 375),
              childAnimationBuilder: (widget) => SlideAnimation(
                horizontalOffset: 50.0,
                child: FadeInAnimation(child: widget),
              ),
              children: [
                buildGridCard(
                  title: "Heart Rate",
                  color: Colors.pink.shade300,
                  ancColor: Colors.pink.shade100,
                  data: heartRate,
                  icon: 'icons/heart-rate.svg',
                ),
                buildGridCard(
                  title: "Temperature",
                  color: Colors.blue.shade300,
                  ancColor: Colors.blue.shade100,
                  data: temperature,
                  icon: 'icons/temp.svg',
                ),
                buildGridCard(
                  title: "Steps",
                  color: Colors.green.shade300,
                  ancColor: Colors.green.shade100,
                  data: steps,
                  icon: 'icons/steps.svg',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    connection?.dispose();
  }
}
