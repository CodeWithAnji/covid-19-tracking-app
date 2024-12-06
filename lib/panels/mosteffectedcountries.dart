import 'package:flutter/material.dart';

class MostEffectedPanel extends StatelessWidget {
  final List<Map<String, dynamic>> countryData;

  const MostEffectedPanel({Key? key, required this.countryData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Sort the countries by deaths in descending order and take the top 6
    final List<Map<String, dynamic>> mostAffectedCountries = countryData
        .where((country) => country['deaths'] != null) // Ensure data validity
        .toList()
      ..sort((a, b) => b['deaths'].compareTo(a['deaths']));
    final topCountries = mostAffectedCountries.take(6).toList();

    return Container(
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(), // Prevents ListView from interfering with parent scroll
        itemCount: topCountries.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0), // Added right padding
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                children: <Widget>[
                  Image.network(
                    topCountries[index]['countryInfo']['flag'],
                    height: 25,
                  ),
                  const SizedBox(width: 10),
                  Expanded( // Makes the text wrap or fit within available space
                    child: Text(
                      topCountries[index]['country'],
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                      overflow: TextOverflow.ellipsis, // Ensures text doesn't overflow
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'Deaths: ${topCountries[index]['deaths'].toString()}',
                    style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
