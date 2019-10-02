import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import './currentPost.dart';
import './Pagetwo.dart';
import './OnePost.dart';
import './Posts.dart';

void main() {
  // debugPaintSizeEnabled = true;

  return runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {

  final c1;
  final c2;

  MyApp({Key key, this.c1: null, this.c2: null}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            builder: (context) => PostData(this.c1),
          ),
          ChangeNotifierProvider(
            builder: (context) => DataTwo(this.c2),
          )
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          routes: {
            './create': (context) => MyApp(c1: Provider.of<PostData>(context)),
            './view': (context) => PageTwo(),
            './post': (context) => OnePost()
          },
          title: 'home page',
          theme: ThemeData(primarySwatch: Colors.blue),
          home: MyHome(),
        ));
  }
}

class MyHome extends StatelessWidget {
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
          title: Text('New Post'),
        ),
        body: ListView(children: <Widget>[
          Container(
            decoration: BoxDecoration(color: Colors.white),
            child: Center(
                child: Consumer<PostData>(
                    builder: (context, mydata, child) => Column(
                          children: <Widget>[
                            showWidget(new NewPost(), mydata, 'reverse'),

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

                            PostPreview(),
                            showWidget(
                                new RaisedButton(
                                  color: Colors.blue,
                                  child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(Icons.add,
                                            color: Colors.white, size: 30),
                                        Text("New Post",
                                            style:
                                                TextStyle(color: Colors.white))
                                      ]),
                                  onPressed: () {
                                    mydata.setTitle = '';
                                    mydata.setContent = '';
                                    mydata.setAuthor = '';
                                    mydata.setSubmitted = false;
                                  },
                                ),
                                mydata,
                                'normal')
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
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 30, left: 20, right: 20),
      // color: Colors.blue[300],
      alignment: Alignment.center,
      child: Form(
          autovalidate: true,
          child: Consumer<PostData>(
              builder: (context, mydata, child) => Column(children: <Widget>[
                    _formInput("Title", mydata, (val) {
                      mydata.setTitle = val;
                    }),
                    _formInput("Content", mydata, (val) {
                      mydata.setContent = val;
                    }, noLines: 5),
                    _formInput("Author", mydata, (val) {
                      mydata.setAuthor = val;
                    }),
                    Consumer<DataTwo>(
                        builder: (context, data, child) => RaisedButton(
                            color: Colors.blue,
                            onPressed: () {
                              data.addPost = {
                                'title': mydata.getTitle,
                                'content': mydata.getContent,
                                'author': mydata.getAuthor
                              };

                              data.setisEmpty = false;
                              print(data.getPosts);
                              mydata.setSubmitted = !mydata.getSubmitted;
                            },
                            child: Text("Create",
                                style: TextStyle(color: Colors.white))))
                  ]))),
    );
  }

  Widget _formInput(String title, PostData data, changed(String val),
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
  @override
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed('./post');
        },
        child: Hero(
            tag: 'preview',
            child: Consumer<PostData>(
                builder: (context, mydata, child) => Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(5),
                    margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                    color: Colors.blue[300],
                    child: Column(
                      children: <Widget>[
                        _fieldItem(() {
                          return mydata.getTitle;
                        }, 'Title'),
                        _fieldItem(() {
                          return mydata.getContent;
                        }, 'Content'),
                        _fieldItem(() {
                          return mydata.getAuthor;
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
