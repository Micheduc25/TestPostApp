import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'currentPost.dart';
import 'main.dart';
import 'Pagetwo.dart';

class OnePost extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var drawerItems = ["Add a Post", "View Posts"];
    var routes = ['./create', './view'];
    return Consumer<PostData>(
        builder: (context, data, child) => MaterialApp(
            title: 'A single post',
            routes: {
              './post': (context) => OnePost(),
              './view': (context) => PageTwo(),
              './create': (context) => MyApp(c1: data)
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
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                            );
                          },
                        ))),
                appBar: AppBar(title: Text("A Post")),
                body: Center(
                  child: Hero(
                      tag: 'preview',
                      child: Consumer<PostData>(
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
                                      return mydata.getTitle;
                                    }, 'Title'),
                                  ),
                                  Expanded(
                                    child: _fieldItem(() {
                                      return mydata.getContent;
                                    }, 'Content'),
                                  ),
                                  Expanded(
                                    child: _fieldItem(() {
                                      return mydata.getAuthor;
                                    }, 'Author'),
                                  )
                                ],
                              )))),
                ))));
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
