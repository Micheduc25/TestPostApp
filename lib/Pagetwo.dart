import 'package:flutter/material.dart';
import './main.dart';
import 'package:provider/provider.dart';
import './Posts.dart';
import './aPost.dart';

class PageTwo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Consumer<DataTwo>(
        builder: (context, dataa, child) => MaterialApp(
              routes: {
                './create': (context) => MyApp(),
                './view': (context) => PageTwo(),
                './apost': (context) => APost(postIndex: dataa.getCurr)
              },
              title: 'Page two',
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
    var size = MediaQuery.of(context).size;

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
          title: Text('All Posts'),
        ),
        body: Consumer<DataTwo>(
            builder: (context, data, child) => Container(
                padding: EdgeInsets.all(5),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      showWidget(
                          Center(
                            child: Text(
                              "No Posts For the Moment",
                              style:
                                  TextStyle(fontSize: 30, color: Colors.blue),
                            ),
                          ),
                          data,
                          'normal'),
                      showWidget(
                          Expanded(
                              child: Container(
                            child: GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: colCount(data, context),
                                      mainAxisSpacing: 10,
                                      crossAxisSpacing: 10),
                              itemCount: data.postLength,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(builder: (context) {
                                      return APost(
                                          postIndex: index, data: data);
                                    }));

                                    // data.setCurr = index;
                                  },
                                  child: Container(
                                      padding: EdgeInsets.all(5),
                                      color: Colors.blue,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: <Widget>[
                                          _fieldItem(
                                              () =>
                                                  data.getPost(index, 'title'),
                                              "Title"),
                                          _fieldItem(
                                              () => data.getPost(
                                                  index, 'content'),
                                              "Content"),
                                          _fieldItem(
                                              () =>
                                                  data.getPost(index, 'author'),
                                              "Author")
                                        ],
                                      )),
                                );
                              },
                            ),
                          )),
                          data,
                          'reverse')
                    ]))));
  }

  Widget showWidget(Widget widg, DataTwo data, String mode) {
    bool temp;
    if (mode == "normal") {
      temp = true;
    } else if (mode == 'reverse') {
      temp = false;
    }

    if (data.getisEmpty == temp) {
      return widg;
    } else {
      return Container();
    }
  }
}

int colCount(DataTwo data,context) {
  //if there is only one element in the post arrays, we return one as our cross axis count, else we return the number
  if(MediaQuery.of(context).size.width>1200){
    return 3;
  }

  else if (MediaQuery.of(context).size.width>700){
    return 2;
  }

  else if(MediaQuery.of(context).size.width<=700){
    return 1;
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
