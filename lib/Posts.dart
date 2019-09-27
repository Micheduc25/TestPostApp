import 'package:flutter/material.dart';

class DataTwo with ChangeNotifier {
  final prevData;
  bool isEmpty;
  int currPost;
  List<Map> myPosts;

  DataTwo(this.prevData) {
    if (this.prevData != null) {
      this.myPosts = this.prevData.getPosts;

      this.isEmpty = this.prevData.getisEmpty;
      currPost = this.prevData.getCurr;
    } else {
      this.myPosts =[];
      this.currPost = 1;
      this.isEmpty = true;
    }
  }
  // var myPosts =
  //     []; //we start with an empty array. values will be added over time

  // bool _isEmpty = true;
  // int currPost = 0;

  get getCurr => this.currPost;
  set setCurr(int val) {
    this.currPost = val;
  }

  get getPosts => this.myPosts;

  int get postLength => this.myPosts.length;

  set addPost(Map post) {
    this.myPosts.add(post);
  }

  set setisEmpty(bool value) {
    this.isEmpty = value;
  }

  get getisEmpty => this.isEmpty;

  String getPost(int index, String key) {
    return this.myPosts[index][key];
  }
}
