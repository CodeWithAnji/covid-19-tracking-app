import 'package:covid_19/datasource.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Infopanel extends StatelessWidget {
  const Infopanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(vertical: 12,horizontal: 10),
            margin: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
            color: primaryBlack,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('FAQ',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                Icon(Icons.arrow_forward,color: Colors.white,)
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              launch('https://covid19responsefund.org/');
            },
            child: Container(
                padding: EdgeInsets.symmetric(vertical: 12,horizontal: 10),
                margin: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                color: primaryBlack,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('DONATE',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                    Icon(Icons.arrow_forward,color: Colors.white,)
                  ],
                ),
            ),
          ),
          GestureDetector(
            onTap: () {
              launch(
                  'https://www.who.int/emergencies/diseases/novel-coronavirus-2019/advice-for-public/myth-busters');
            },
            child: Container(
                padding: EdgeInsets.symmetric(vertical: 12,horizontal: 10),
                margin: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                color: primaryBlack,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('MYTH BUSTORS',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                    Icon(Icons.arrow_forward,color: Colors.white,)
                  ],
                ),
            ),
          ),
        ],
      ),
    );
  }
}
