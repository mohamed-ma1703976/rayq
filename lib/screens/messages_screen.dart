import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class MessagesScreen extends StatelessWidget {
  final List<String> adviceTitles = [
    "Manage Your Time",
    "Stay Active",
    "Connect With Others",
    "Practice Mindfulness",
    "Seek Help When Needed",
  ];

  final List<String> adviceDetails = [
    "Effective time management allows you to complete more in a shorter period, leading to more free time, which lets you take advantage of learning opportunities and lowers your stress.",
    "Regular physical activity can improve your muscle strength and boost your endurance. Exercise delivers oxygen and nutrients to your tissues and helps your cardiovascular system work more efficiently.",
    "Building strong, healthy relationships with others can greatly reduce stress and anxiety in your life. Make an effort to build relationships with classmates, friends, and family.",
    "Mindfulness meditation involves sitting silently and paying attention to thoughts, sounds, the sensations of breathing, or parts of the body. It can reduce stress and enhance your mood.",
    "It's okay to seek help if you're feeling overwhelmed. Many schools offer free counseling services, or you can reach out to a trusted adult or professional therapist.",
  ];

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Color.fromRGBO(255, 255, 255, 1)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView.builder(
            itemCount: adviceTitles.length,
            itemBuilder: (context, index) {
              return AnimationConfiguration.staggeredList(
                position: index,
                duration: const Duration(milliseconds: 375),
                child: SlideAnimation(
                  horizontalOffset: 50.0,
                  child: FadeInAnimation(
                    child: _buildAdviceTile(index, screenSize, context),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildAdviceTile(int index, Size screenSize, BuildContext context) {
    return Card(
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: ExpansionTileCard(
        title: Text(adviceTitles[index]),
        children: <Widget>[
          Divider(
            thickness: 1.0,
            height: 1.0,
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  adviceDetails[index],
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
