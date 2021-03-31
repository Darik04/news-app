import 'package:blog_app/constants/strings.dart';
import 'package:blog_app/pages/home.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class EditData extends StatefulWidget {
  final List list;
  final int index;

  EditData({this.list, this.index});

  @override
  _EditDataState createState() => _EditDataState();
}

class _EditDataState extends State<EditData> {
  TextEditingController controllerTitle;
  TextEditingController controllerDesc;
  TextEditingController controllerImgUrl;

  void editData() {
    http.post(Strings.edit_data_url, body: {
      'id': widget.list[widget.index]['id'],
      'title': controllerTitle.text,
      'descriptions': controllerDesc.text,
      'imgurl': controllerImgUrl.text,
    });
  }

  @override
  void initState() {
    controllerTitle =
        new TextEditingController(text: widget.list[widget.index]['title']);
    controllerDesc = new TextEditingController(
        text: widget.list[widget.index]['descriptions']);
    controllerImgUrl =
        new TextEditingController(text: widget.list[widget.index]['img']);
    super.initState();
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
                  editData();
                  Navigator.pushAndRemoveUntil(
                  context,
                    MaterialPageRoute(builder: (BuildContext context) => HomePage()),
                  (Route<dynamic> route) => false
                  );
                },
                color: Theme.of(context).primaryColor,
                child: Text(
                  'Применить',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              )
            ]),
          ],
        ),
      ),
    );
  }
}
