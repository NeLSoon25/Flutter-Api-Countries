import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_first_api/models/data_model.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _getData();
  }

  List<Country> countries = [];

  _getData() async {
    try {
      String url = "https://restcountries.com/v3.1/all";
      http.Response res = await http.get(Uri.parse(url));
      if (res.statusCode == 200) {
        List<dynamic> data = json.decode(res.body);
        countries = data.map((json) => Country.fromJson(json)).toList();
        _isLoading = false;
        setState(() {});
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("REST Countries API Example"),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Country: ${countries[index].name.common}"),
                      Text(
                          "Capital: ${countries[index].capital}"),
                      Text(
                          "Region: ${countries[index].region}"), 
                      
                    ],
                  ),
                );
              },
              itemCount: countries.length,
            ),
    );
  }
}
