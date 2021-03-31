import 'package:blog_app/constants/strings.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'home.dart';


class AddData extends StatefulWidget {
  @override
  _AddDataState createState() => _AddDataState();
}

class _AddDataState extends State<AddData> {

  TextEditingController controllerTitle = new TextEditingController();
  TextEditingController controllerDesc = new TextEditingController();
  TextEditingController controllerImgUrl = new TextEditingController();

  addData(){
    http.post(Strings.add_data_url, body: {
      'news_title' :  controllerTitle.text,
      'news_desc' : controllerDesc.text,
      'news_imgurl' : controllerImgUrl.text
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Добавление новости..'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: [
            Column(children: <Widget>[
              TextField(
                controller: controllerTitle,
                  decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 15),
                hintText: 'Заголовок',
                labelText: 'Заголовок',
              )),
              TextField(
                controller: controllerDesc,
                  decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 15),
                hintText: 'Описание',
                labelText: 'Описание',
              )),
              TextField(
                controller: controllerImgUrl,
                  decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 15),
                hintText: 'URL картинки',
                labelText: 'URL картинки',
              )),
              Padding(padding: EdgeInsets.all(10.0)),
              RaisedButton(
                onPressed: () {
                  addData();
                  Navigator.pushAndRemoveUntil(
                  context,
                    MaterialPageRoute(builder: (BuildContext context) => HomePage()),
                  (Route<dynamic> route) => false
                  );
                },
                color: Theme.of(context).primaryColor,
                child: Text('Добавить', style: TextStyle(fontSize: 18, color: Colors.white),),
              )
            ]),
          ],
        ),
      ),
    );
  }
}
