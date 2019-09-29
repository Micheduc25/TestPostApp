import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Pagetwo.dart';
import 'Posts.dart';
import 'currentPost.dart';
import './aPost.dart';

class EditPost extends StatelessWidget {
  final postIndex;

  EditPost({Key key, this.postIndex}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        './edit': (context) => EditPost(),
        './view': (context) => PageTwo(),
        './apost': (context) => APost(postIndex: this.postIndex)
      },
      title: 'home page',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MyHome(this.postIndex),
    );
  }
}

class MyHome extends StatelessWidget {
  final int postIndex;

  MyHome(this.postIndex);
  @override
  Widget build(BuildContext context) {
    var drawerItems = ["Add a Post", "View Posts"];
    var routes = ['./create', './view'];
    return Scaffold(
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
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    );
                  },
                ))),
        appBar: AppBar(
          title: Text('Edit Post'),
        ),
        body: ListView(children: <Widget>[
          Container(
            decoration: BoxDecoration(color: Colors.white),
            child: Center(
                child: Consumer<PostData>(
                    builder: (context, mydata, child) => Column(
                          children: <Widget>[
                            showWidget(
                                new NewPost(this.postIndex), mydata, 'reverse'),

                            //show or not show submit successful
                            showWidget(
                                new Text("Post successfully added",
                                    style: TextStyle(
                                        color: Colors.green, fontSize: 14)),
                                mydata,
                                'normal'),

                            //////
                            Padding(
                                padding: EdgeInsets.only(top: 30, bottom: 5),
                                child: Text(
                                  "Post Preview",
                                  style: TextStyle(fontSize: 25),
                                )),

                            //////

                            PostPreview(this.postIndex),
                            // showWidget(
                            //     new RaisedButton(
                            //       color: Colors.blue,
                            //       child: Row(
                            //           mainAxisSize: MainAxisSize.min,
                            //           children: [
                            //             Icon(Icons.add,
                            //                 color: Colors.white, size: 30),
                            //             Text("New Post",
                            //                 style:
                            //                     TextStyle(color: Colors.white))
                            //           ]),
                            //       onPressed: () {
                            //         mydata.setTitle = '';
                            //         mydata.setContent = '';
                            //         mydata.setAuthor = '';
                            //         mydata.setSubmitted = false;
                            //       },
                            //     ),
                            //     mydata,
                            //     'normal')
                          ],
                        ))),
          ),
        ]));
  }

  Widget showWidget(Widget widg, PostData data, String mode) {
    bool temp;
    if (mode == "normal") {
      temp = true;
    } else if (mode == 'reverse') {
      temp = false;
    }

    if (data.getSubmitted == temp) {
      return widg;
    } else {
      return Container();
    }
  }
}

class NewPost extends StatelessWidget {
  final int postIndex;
  NewPost(this.postIndex);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 30, left: 20, right: 20),
      // color: Colors.blue[300],
      alignment: Alignment.center,
      child: Form(
          autovalidate: true,
          child: Consumer<DataTwo>(
              builder: (context, mydata, child) => Column(children: <Widget>[
                    _formInput("Title", mydata.getPost(this.postIndex, 'title'),
                        (val) {
                      mydata.setPost(this.postIndex, 'title', val);
                    }),
                    _formInput(
                        "Content", mydata.getPost(this.postIndex, 'content'),
                        (val) {
                      mydata.setPost(this.postIndex, 'content', val);
                    }, noLines: 5),
                    _formInput(
                        "Author", mydata.getPost(this.postIndex, 'author'),
                        (val) {
                      mydata.setPost(this.postIndex, 'author', val);
                    }),
                    Consumer<DataTwo>(
                        builder: (context, data, child) => RaisedButton(
                            color: Colors.blue,
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => APost(
                                      postIndex: this.postIndex, data: data)));
                            },
                            child: Text("Save",
                                style: TextStyle(color: Colors.white))))
                  ]))),
    );
  }

  Widget _formInput(String title, String initialValue, changed(String val),
      {int noLines = 1}) {
    return Column(
      children: <Widget>[
        Text(title,
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
            ),
            textAlign: TextAlign.center),
        Padding(
          padding: EdgeInsets.only(top: 5, bottom: 20),
          child: TextFormField(
            initialValue: initialValue,
            decoration: InputDecoration(
              hintText: title,
              hintStyle: TextStyle(color: Colors.grey),
            ),
            onChanged: (value) {
              changed(value);
            },
            maxLines: noLines,
          ),
        ),
      ],
    );
  }
}

class PostPreview extends StatelessWidget {
  final int postIndex;
  @override
  PostPreview(this.postIndex);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed('./post');
        },
        child: Hero(
            tag: 'preview',
            child: Consumer<DataTwo>(
                builder: (context, mydata, child) => Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(5),
                    margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                    color: Colors.blue[300],
                    child: Column(
                      children: <Widget>[
                        _fieldItem(() {
                          return mydata.getPost(this.postIndex, 'title');
                        }, 'Title'),
                        _fieldItem(() {
                          return mydata.getPost(this.postIndex, 'title');
                        }, 'Content'),
                        _fieldItem(() {
                          return mydata.getPost(this.postIndex, 'author');
                        }, 'Author'),
                      ],
                    )))));
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
}
