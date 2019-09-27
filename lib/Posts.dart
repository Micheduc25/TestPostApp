import 'package:flutter/material.dart';

class DataTwo with ChangeNotifier {
  var myPosts =
      []; //we start with an empty array. values will be added over time

  bool _isEmpty = true;
  int currPost = 0;

  get getCurr => currPost;
  set setCurr(int val) {
    currPost = val;
  }

  get getPosts => myPosts;

  int get postLength => myPosts.length;

  set addPost(Map post) {
    myPosts.add(post);
  }

  set setisEmpty(bool value) {
    _isEmpty = value;
  }

  get getisEmpty => _isEmpty;

  String getPost(int index, String key) {
    return myPosts[index][key];
  }
}
