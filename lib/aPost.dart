import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'main.dart';
import 'Pagetwo.dart';
import './Posts.dart';
import './editPost.dart';

class APost extends StatelessWidget {
  var postIndex;
  var data;

  APost({Key key, this.postIndex, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var drawerItems = ["Add a Post", "View Posts"];
    var routes = ['./create', './view'];

    if (this.postIndex < this.data.postLength) {
      return Consumer<DataTwo>(builder: (context, dataa, child) {
        return MaterialApp(
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
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                            );
                          },
                        ))),
                appBar: AppBar(
                  title:
                      Text("Post: " + dataa.getPost(this.postIndex, 'title')),
                  actions: <Widget>[
                    PopupMenuButton(
                      elevation: 5.0,
                      offset: Offset(0, 40),
                      onSelected: (selected) {
                        switch (selected) {
                          case 'deleted':
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text("Delete Post"),
                                    content: Text(
                                        "Do you really want to delete this post?"),
                                    actions: <Widget>[
                                      FlatButton(
                                        child: Text("No"),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        onPressed: () {},
                                      ),
                                      FlatButton(
                                        child: Text("Yes"),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        onPressed: () {
                                          deletePost(
                                              dataa, this.postIndex, context);
                                        },
                                      )
                                    ],
                                  );
                                });

                            break;

                          case 'edited':
                            editPost(this.postIndex, context);
                            break;
                        }
                      },

                      // initialValue: 'edited',
                      itemBuilder: (context) {
                        return <PopupMenuEntry>[
                          PopupMenuItem(
                              enabled: true,
                              value: 'deleted',
                              child: popItem(
                                Icons.close,
                                Colors.red,
                                'Delete Post',
                              )),
                          PopupMenuDivider(),
                          PopupMenuItem(
                            enabled: true,
                            value: 'edited',
                            child: popItem(
                              Icons.edit,
                              Colors.blue,
                              'Edit Post',
                            ),
                          )
                        ];
                      },
                    )
                  ],
                ),
                body: Flex(
                    direction: Axis.vertical,
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Center(
                          child: Hero(
                              tag: 'preview',
                              child: Consumer<DataTwo>(
                                  builder: (context, mydata, child) =>
                                      Container(
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
                                                      this.postIndex,
                                                      'content');
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
                        ),
                      ),
                    ])));
      });
    } else {
      print(Provider.of<DataTwo>(context).getdelPost);
      // Navigator.of(context).pushNamed('./view');
      return Container(
          color: Colors.white, width: double.infinity, height: 400);
    }
  }

  deletePost(DataTwo data, int postindex, BuildContext context) {
    if (data.postLength < 2) {
      data.setisEmpty = true;
    }

    data.deletePost(postindex);
    Navigator.of(context).pushNamed('./view');
    data.setdelPost = true;
  }

  editPost(int postIndex, BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => EditPost(postIndex: this.postIndex)));
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
          ),
        ],
      ));
}

Widget popItem(IconData icon, Color iconColor, String title) {
  return ListTile(
    leading: Icon(icon, color: iconColor),
    title: Text(title),
    // onTap: callback,
    contentPadding: EdgeInsets.all(0),
  );
}
