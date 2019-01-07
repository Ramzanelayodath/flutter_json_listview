import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: Home(),
    );
  }
}
class Home extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() {
    return HomeState();
  }

}

class HomeState extends State<Home>
{
  List data;
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: true,
      home: Scaffold(
        appBar: AppBar(
          title: Text("JSON LIST VIEW"),
          backgroundColor: Colors.green,
        ),
        body: _isLoading ?Center(
          child: CircularProgressIndicator(),
        )
              :ListView.builder(
                  itemCount: data == null ? 0 : data.length,
                  itemBuilder: (BuildContext context,i){
                    return ListTile(
                      title: Text(data[i]["name"]["first"]),
                      subtitle: Text(data[i]["phone"]),
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(data[i]["picture"]["thumbnail"]),
                      ),
                    );

                  })
          ) ,


    );
  }
  Future<String> makeRequest() async
  {
    setState(() {
      _isLoading = true;
    });
    String url = 'https://randomuser.me/api/?results=15';
    var response = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});
    setState(() {
      _isLoading = false;
       var extdata = json.decode(response.body);
       data = extdata["results"];
    });
  }

  @override
  void initState() {
    this.makeRequest();
  }



}



