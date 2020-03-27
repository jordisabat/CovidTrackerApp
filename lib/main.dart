import 'package:flutter/material.dart';
import 'package:flutter_firebase_ddd_notes/app/services/api_service.dart';
import 'package:flutter_firebase_ddd_notes/models/covid_country.model.dart';

import 'app/services/api.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Covid-19 tracker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Covid-19'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  CovidCountry _covidCountry;

  void _getData() async {
    final apiService = APIService(API.sandbox());
    CovidCountry covid = await apiService.getEndpointData(
      endpoint: Endpoint.countries,
      country: "spain",
    );
    setState(() {
      _covidCountry = covid;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              _covidCountry != null ? 'cases: ${_covidCountry.cases}' : "-",
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _getData,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
