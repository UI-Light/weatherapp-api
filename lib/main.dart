import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


void main() {
  runApp(MaterialApp(title: "Weather Application", home: Home()));
}

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  var temp;
  var description;
  var currently;
  var humidity;
  var windSpeed;

  Future getWeather() async {
    http.Response response = await http.get(Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?q=Enugu&appid=e295166f4d840380ed6d70e432c1322e")
    );

    var results = jsonDecode(response.body);
    setState(() {
      this.temp = results['main']['temp'];
      this.description = results['weather'][0]['description'];
      this.currently = results['weather'][0]['main'];
      this.humidity = results['main']['humidity'];
      this.windSpeed = results['wind']['speed'];
    });
  }

  @override
  void initState(){super.initState();
  this.getWeather();
  }

  @override
  build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          padding: EdgeInsets.only(top:100),
          child: ListView(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Nsukka, Enugu",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w500,
                      color: Colors.black
                    ),
                  ),
                ],
              ),
              SizedBox(height:50),
              Text(temp != null ?temp.toString() + "°": "Loading...",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 60, fontWeight: FontWeight.w600)),
              SizedBox(height: 15),
              Text(currently != null ? currently.toString() : "Loading...",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, color: Colors.black),
              ),
              SizedBox(height: 80),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                decoration: BoxDecoration(
                  color: Colors.lightBlueAccent,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Today",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color:Colors.white
                      ),
                    ),
                    SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Temperature",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "Weather",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "Humidity",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "WindSpeed",
                          style: TextStyle(
                            fontSize: 15,
                            color:  Colors.white,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height:10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(
                        FontAwesomeIcons.thermometerHalf,
                          color: Colors.white,
                          size: 30.0,
                        ),
                        Icon(
                          FontAwesomeIcons.cloud,
                          color: Colors.white,
                          size: 30.0,
                        ),
                        Icon(
                          FontAwesomeIcons.sun,
                          color: Colors.white,
                          size: 30.0,
                        ),
                        Icon(
                          FontAwesomeIcons.wind,
                          color: Colors.white,
                          size: 30.0,
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                    Text(temp != null ?temp.toString() + "°": "Loading",
                          style: TextStyle(
                            fontSize: 17,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                    Text(description !=null ? description.toString(): "Loading",
                          style: TextStyle(
                            fontSize: 17,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                    Text(humidity !=null ? humidity.toString(): "Loading",
                          style: TextStyle(
                            fontSize: 17,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                    Text(windSpeed !=null ? windSpeed.toString(): "Loading",
                          style: TextStyle(
                            fontSize: 17,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
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
}
