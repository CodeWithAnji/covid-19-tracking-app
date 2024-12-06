import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CountryPage extends StatefulWidget {
  const CountryPage({super.key});

  @override
  State<CountryPage> createState() => _CountryPageState();
}

class _CountryPageState extends State<CountryPage> {
  // Declare the countryData variable as a class-level field
  List<Map<String, dynamic>>? countryData; // Nullable for initialization

  // Fetch data from the API
  Future<void> fetchCountryData() async {
    try {
      final http.Response response = await http.get(
        Uri.parse('https://disease.sh/v3/covid-19/countries'),
      );

      if (response.statusCode == 200) {
        setState(() {
          // Initialize countryData with the fetched data
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
    fetchCountryData(); // Call the fetch method when the widget initializes
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Country Status'),
      ),
      body: countryData == null // Check if data is null
          ? const Center(child: CircularProgressIndicator()) // Show loading spinner
          : ListView.builder(
        itemCount: countryData!.length, // Access length safely with '!'
        itemBuilder: (context, index) {
          return Container(
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 5,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: <Widget>[
                Image.network(
                  countryData![index]['countryInfo']['flag'], // Flag image
                  height: 50,
                  width: 70,
                  fit: BoxFit.cover,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        countryData![index]['country'], // Country name
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'Cases: ${countryData![index]['cases']}',
                        style: const TextStyle(color: Colors.orange),
                      ),
                      Text(
                        'Deaths: ${countryData![index]['deaths']}',
                        style: const TextStyle(color: Colors.red),
                      ),
                      Text(
                        'Recovered: ${countryData![index]['recovered']}',
                        style: const TextStyle(color: Colors.green),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
