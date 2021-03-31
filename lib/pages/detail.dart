import 'dart:ffi';

import 'package:blog_app/constants/strings.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'editdata.dart';
import 'home.dart';

class Detail extends StatefulWidget {
  List list;
  int index;
  Detail({this.index, this.list});
  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {

 void deleteData(){
    http.post(Strings.del_data_url, body: {
      'id' : widget.list[widget.index]['id']
    });
  }

  void confirm(){
    AlertDialog alertDialog = AlertDialog(
      content: Text('Вы точно хотите удалить: ${widget.list[widget.index]['title']}'),
      actions: <Widget>[
        RaisedButton(
          child: Text('Удалить', style: TextStyle(color: Colors.white),),
          color: Colors.red,
          onPressed: (){
            deleteData();
            Navigator.pushAndRemoveUntil(
                  context,
                    MaterialPageRoute(builder: (BuildContext context) => HomePage()),
                  (Route<dynamic> route) => false
                  );
          },
        ),
        RaisedButton(
          child: Text('Отмена', style: TextStyle(color: Colors.white),),
          color: Colors.green,
          onPressed: (){
            Navigator.pop(context);
          },
        )
      ],
    );
    showDialog(context: context, builder: (_) => alertDialog);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.list[widget.index]['title']}'),
      ),
      body: Container(
        // padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        
            child: ListView(
          children: <Widget>[
            Image.network(widget.list[widget.index]['img']),
            Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.only(top: 12, left: 15, bottom: 5),
              child: Text(
                widget.list[widget.index]['title'],
                style: TextStyle(fontSize: 20),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Divider(
                
                    color: Colors.black,
                  ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                widget.list[widget.index]['descriptions'],
                style: TextStyle(fontSize: 16),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Row(
                
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  RaisedButton(
                    child: Text('Редактировать', style: TextStyle(color: Colors.white, fontSize: 18.0),),
                    color: Colors.green,
                    onPressed: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=>EditData(list: widget.list, index: widget.index,))),
                  ),
                  RaisedButton(
                    child: Text('Удалить', style: TextStyle(color: Colors.white, fontSize: 18.0),),
                    color: Colors.red,
                    onPressed: (){
                      confirm();
                    },
                  ),
                ]
              ),
            )
          ],
        ),
      ),
    );
  }
}
