import 'package:covid_19/datasource.dart';
import 'package:covid_19/pages/countryPage.dart';
import 'package:covid_19/panels/infoPanel.dart';
import 'package:covid_19/panels/mosteffectedcountries.dart';
import 'package:covid_19/panels/worldwidepanel.dart'; // Correct import
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  Map<String, dynamic>? worldData; // Null safety applied
  List<Map<String, dynamic>> countryData = []; // Declare with correct type

  Future<void> fetchWorldwideData() async {
    try {
      final http.Response response = await http.get(
        Uri.parse('https://disease.sh/v3/covid-19/all'),
      );

      if (response.statusCode == 200) {
        setState(() {
          worldData = json.decode(response.body);
        });
      } else {
        print('Failed to fetch data. Status Code: ${response.statusCode}');
      }
    } catch (e) {
      print('An error occurred: $e');
    }
  }

  Future<void> fetchCountryData() async {
    try {
      final http.Response response = await http.get(
        Uri.parse('https://disease.sh/v3/covid-19/countries'),
      );

      if (response.statusCode == 200) {
        setState(() {
          // Cast the List<dynamic> to List<Map<String, dynamic>>
          countryData = List<Map<String, dynamic>>.from(json.decode(response.body));
        });
      } else {
        print('Failed to fetch data. Status Code: ${response.statusCode}');
      }
    } catch (e) {
      print('An error occurred: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchWorldwideData();
    fetchCountryData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: Colors.black,
        title: const Text(
          'COVID-19 TRACKER APP',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 100,
              alignment: Alignment.center,
              padding: const EdgeInsets.all(10),
              color: Colors.blue[50],
              child: Text(
                DataSource.quote,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text(
                    'Worldwide',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context,MaterialPageRoute(builder: (context)=>CountryPage()));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black, // Replace with your custom color if needed
                        borderRadius: BorderRadius.circular(15),
                      ),
                      padding: const EdgeInsets.all(10),
                      child: const Text(
                        'Regional',
                        style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            worldData == null
                ? const Center(child: CircularProgressIndicator())
                : WorldwidePanel(worldData: worldData!), // Safely pass data
            Padding(
              padding: const EdgeInsets.all(10),
              child: const Text(
                'Most Affected Countries',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            countryData.isEmpty
                ? const Center(child: CircularProgressIndicator()) // Loading indicator
                : MostEffectedPanel(countryData: countryData),
            Infopanel(),
            SizedBox(height: 50,)// Safely pass data
          ],
        ),
      ),
    );
  }
}
