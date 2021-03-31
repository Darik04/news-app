import 'dart:convert';

import 'package:blog_app/constants/strings.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'adddata.dart';
import 'detail.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<List> getData() async {
    final response = await http.get(Strings.news_url);
    print('Response body: ${response.body}');
    return json.decode(response.body);
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Новости'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: Center(child: GestureDetector(
              onTap: (){
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => HomePage()));
              },
              child: Icon(Icons.update)),),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () => Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) => AddData())),
        child: Icon(Icons.add),
      ),
      body: FutureBuilder<List>(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);

          return snapshot.hasData
              ? ListItem(
                  list: snapshot.data,
                )
              : Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class ListItem extends StatelessWidget {
  List list;
  ListItem({this.list});


  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: list == null ? 0 : list.length,
      itemBuilder: (BuildContext context, int i) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 4, vertical: 8),
          child: GestureDetector(
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => Detail(
                      list: list,
                      index: i,
                    ))),
            child: Card(
                child: ListTile(
              title: Text(list[i]['title']),
              leading: Image.network(list[i]['img']),
              subtitle: Text(list[i]['descriptions']),
            )),
          ),
        );
      },
    );
  }
}
