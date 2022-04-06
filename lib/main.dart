import 'dart:convert';
//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/screen.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List dataList = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  void getData() async {
    var trial = await http.get(
      Uri.parse("https://api.github.com/users"),
    );
    dataList = jsonDecode(trial.body);
    print(dataList);
    setState(() {
      dataList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Listview using local json file'),
      ),
      body: dataList.isEmpty
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Center(
              child: ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (BuildContext context) {
                        return Details(
                          data: dataList[index],
                        );
                      }));
                    },
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 32, bottom: 32, left: 16, right: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  dataList[index]["login"]
                                          .toString()
                                          .substring(0, 1)
                                          .toUpperCase() +
                                      dataList[index]["login"]
                                          .toString()
                                          .substring(1),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22),
                                ),
                                Text(
                                  'Login',
                                  style: TextStyle(
                                    color: Colors.blueAccent,
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              height: 50,
                              width: 50,
                              child: Image.network(
                                  '${dataList[index]["avatar_url"]}'),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
                itemCount: dataList.length,
              ),
            ),
    );
  }
}
