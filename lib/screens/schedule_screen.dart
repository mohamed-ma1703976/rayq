import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({Key? key}) : super(key: key);

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  void showScheduleDialog(String title) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Plan Your $title'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Enter details for your event:'),
                TextField(
                  decoration: InputDecoration(
                    hintText: "Event Details",
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Save'),
              onPressed: () {
                // Logic to save the event details can be added here
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  children: [
                    _buildScheduleCard(
                      title: "Sports",
                      icon: "icons/sports.svg",
                      color: Color(0xffF48FB1),
                      ancColor: Color(0xffF8BBD0),
                    ),
                    _buildScheduleCard(
                      title: "Food",
                      icon: "icons/food.svg",
                      color: Color(0xff90CAF9),
                      ancColor: Color(0xffBBDEFB),
                    ),
                    _buildScheduleCard(
                      title: "Study",
                      icon: "icons/study.svg",
                      color: Color(0xffA5D6A7),
                      ancColor: Color(0xffC8E6C9),
                    ),
                    _buildScheduleCard(
                      title: "Family",
                      icon: "icons/family.svg",
                      color: Color(0xffFFAB91),
                      ancColor: Color(0xffFFCCBC),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildScheduleCard({
    required String title,
    required String icon,
    required Color color,
    required Color ancColor,
  }) {
    return GestureDetector(
      onTap: () => showScheduleDialog(title),
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 5,
              offset: Offset(0, 2),
            ),
          ],
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
                      color: Colors.white,
                    ),
                  ),
                  Spacer(),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Text(
                      "Manage",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white.withOpacity(0.8),
                      ),
                    ),
                  ),
                ],
              ),
            ),
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
      ),
    );
  }
}
