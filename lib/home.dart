import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:getlead/model/data.dart';
import 'package:http/http.dart' as http;

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ScrollController _scrollController = new ScrollController();
  bool loading;

  List<Data> payLoad;
  bool hasMore;
  int pageNo=1;
  int dataInList = 15;

  fetchData() async {
    Map<String, String> header = {
      'Authorization': 'Bearer' +
          'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC9kZW1vMS5nZXRsZWFkLmNvLnVrXC9hcGlcL2FnZW50LWFwcFwvbG9naW4iLCJpYXQiOjE2MTg3NTQxNjMsIm5iZiI6MTYxODc1NDE2MywianRpIjoiNk0yQzBwOWY1cmEwRWhwcSIsInN1YiI6NTY2LCJwcnYiOiI4N2UwYWYxZWY5ZmQxNTgxMmZkZWM5NzE1M2ExNGUwYjA0NzU0NmFhIn0.hEMxLBObHfiNxY5YynqvJI9FEZJUilo4tnf_wIdxCJk'
    };
    final response = await http.post(
        Uri.parse(
            'https://app.getlead.co.uk/api/agent-app/dashboard-tasks/?page=$pageNo'),
        headers: header);
    var data = json.decode(response.body);

    var message = data["message"];
    var jsonResults = data['data']['data'] as List;
    print(data);
    print(message);
    print(jsonResults);
    if (message == "alerts.Success") {
   List<Data>   intPayLoad = jsonResults.map((place) => Data.fromJson(place)).toList();
      setState(() {
        loading = false;
        payLoad.addAll(intPayLoad);
        hasMore = false;


      });
    } else {
      setState(() {
        loading = true;
      });
    }
  }

  @override
  void initState() {
    payLoad=[];
    loading = true;
    fetchData();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        setState(() {
          pageNo++;
          hasMore = true;
          fetchData();

        });
      } else{
          hasMore = false;
          }
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[50],
        elevation: 0,
        title: Text(
          widget.title,
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              controller: _scrollController,
              shrinkWrap: true,
              itemCount: payLoad.length + (hasMore ? 1 : 0),
              itemBuilder: (context, index) {
                if (index != payLoad.length) {
                  return Card(
                    margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    child: ListTile(
                      leading: CircleAvatar(
                        foregroundColor: Colors.blue,
                      ),
                      title: Text(payLoad[index].vchrCustomerName??'null'),
                      subtitle: Text(payLoad[index].vchrStatus??'null'),
                      trailing: Text(payLoad[index].createdDate??'null'),
                    ),
                  );
                } else {
                  return Container(
                      child: Center(child: CircularProgressIndicator()));
                }
              },
            ),
    );
  }
}
