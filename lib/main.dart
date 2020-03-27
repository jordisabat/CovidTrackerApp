import 'package:flutter/material.dart';
import 'package:flutter_firebase_ddd_notes/app/services/api_service.dart';

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
  int _cases = 0;
  int _deaths = 0;
  int _recovered = 0;

  void _getData() async {
    final apiService = APIService(API.sandbox());
    final accessToken = await apiService.getAccessToken();
    final cases = await apiService.getEndpointData(
      accessToken: accessToken,
      endpoint: Endpoint.cases,
    );
    final deaths = await apiService.getEndpointData(
      accessToken: accessToken,
      endpoint: Endpoint.deaths,
    );
    final recovered = await apiService.getEndpointData(
      accessToken: accessToken,
      endpoint: Endpoint.recovered,
    );
    setState(() {
      _cases = cases;
      _deaths = deaths;
      _recovered = recovered;
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
              _cases != null ? 'cases: $_cases' : '-',
              style: Theme.of(context).textTheme.display1,
            ),
            Text(
              _deaths != null ? 'recovered $_recovered' : '-',
              style: Theme.of(context).textTheme.display1,
            ),
            Text(
              _deaths != null ? 'deaths $_deaths' : '-',
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
