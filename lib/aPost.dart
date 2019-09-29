import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'currentPost.dart';
import 'main.dart';
import 'Pagetwo.dart';
import './Posts.dart';

class APost extends StatelessWidget {
  final postIndex;

  APost({Key key, this.postIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var drawerItems = ["Add a Post", "View Posts"];
    var routes = ['./create', './view'];
    return Consumer<DataTwo>(
      builder: (context, dataa, child) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'A single post',
          routes: {
            './post': (context) => APost(
                  postIndex: this.postIndex,
                ),
            './view': (context) => PageTwo(),
            './create': (context) => MyApp(c2: dataa)
          },
          home: Scaffold(
              drawer: Drawer(
                  child: Container(
                      color: Colors.blue,
                      child: ListView.builder(
                        itemCount: 2,
                        itemBuilder: (context, index) {
                          return ListTile(
                            onTap: () {
                              Navigator.of(context).pushNamed(routes[index]);
                            },
                            leading: Icon(Icons.add, color: Colors.white),
                            title: Text(
                              drawerItems[index],
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          );
                        },
                      ))),
              appBar: AppBar(
                title: Text("A Post"),
                actions: <Widget>[
                  PopupMenuButton(
                    itemBuilder: (context) {
                      return [
                        PopupMenuItem(
                          enabled: true,
                          child: popItem(
                              Icons.close, Colors.red, 'Delete Post', () {}),
                        ),
                        PopupMenuItem(
                          enabled: true,
                          child: popItem(
                              Icons.edit, Colors.blue, 'Edit Post', () {}),
                        )
                      ];
                    },
                    icon: Icon(Icons.arrow_drop_down),
                  )
                ],
              ),
              body: Center(
                child: Hero(
                    tag: 'preview',
                    child: Consumer<DataTwo>(
                        builder: (context, mydata, child) => Container(
                            width: double.infinity,
                            height: screenSize.height / 1.8,
                            padding: EdgeInsets.all(5),
                            margin: EdgeInsets.symmetric(
                                vertical: 20, horizontal: 10),
                            color: Colors.blue[300],
                            child: Column(
                              children: <Widget>[
                                Expanded(
                                  child: _fieldItem(() {
                                    return mydata.getPost(
                                        this.postIndex, 'title');
                                  }, 'Title'),
                                ),
                                Expanded(
                                  child: _fieldItem(() {
                                    return mydata.getPost(
                                        this.postIndex, 'content');
                                  }, 'Content'),
                                ),
                                Expanded(
                                  child: _fieldItem(() {
                                    return mydata.getPost(
                                        this.postIndex, 'author');
                                  }, 'Author'),
                                )
                              ],
                            )))),
              ))),
    );
  }
}

Widget _fieldItem(getdata(), String title) {
  return Padding(
      padding: EdgeInsets.only(top: 5, bottom: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Text(title,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold)),
          Text(
            getdata(),
            softWrap: true,
            style: TextStyle(color: Colors.white),
          )
        ],
      ));
}

Widget popItem(IconData icon, Color iconColor, String title, callback()) {
  return ListTile(
    leading: Icon(icon, color: iconColor),
    title: Text(title),
    onTap: callback,
    contentPadding: EdgeInsets.all(0),
  );
}
