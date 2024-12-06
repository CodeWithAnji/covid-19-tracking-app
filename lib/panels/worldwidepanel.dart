import 'package:flutter/material.dart';

class WorldwidePanel extends StatelessWidget {
  final Map<String, dynamic> worldData; // Ensure type safety

  const WorldwidePanel({
    Key? key,
    required this.worldData, // Ensure this parameter is required
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 2,
        ),
        children: <Widget>[
          StatusPanel(
            title: 'CONFIRMED',
            panelColor: Colors.orangeAccent,
            textColor: Colors.red,
            count: worldData['cases'].toString(), // Dynamic data
          ),
          StatusPanel(
            title: 'ACTIVE',
            panelColor: Colors.lightBlue,
            textColor: Colors.deepPurpleAccent,
            count: worldData['active'].toString(), // Dynamic data
          ),
          StatusPanel(
            title: 'RECOVERED',
            panelColor: Colors.lightGreen,
            textColor: Colors.blueGrey,
            count: worldData['recovered'].toString(), // Dynamic data
          ),
          StatusPanel(
            title: 'DEATHS',
            panelColor: Colors.grey,
            textColor: Colors.black,
            count: worldData['deaths'].toString(), // Dynamic data
          ),
        ],
      ),
    );
  }
}

class StatusPanel extends StatelessWidget {
  final Color panelColor;
  final Color textColor;
  final String title;
  final String count;

  const StatusPanel({
    Key? key,
    required this.panelColor,
    required this.textColor,
    required this.title,
    required this.count,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      margin: const EdgeInsets.all(10),
      height: 80,
      width: width / 2,
      color: panelColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: textColor,
            ),
          ),
          Text(
            count,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }
}
