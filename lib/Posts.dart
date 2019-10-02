import 'package:flutter/material.dart';

class DataTwo with ChangeNotifier {

  final prevData;
  bool isEmpty;
  int currPost;
  List<Map> myPosts;
  bool delPost;

  DataTwo(this.prevData) {
    if (this.prevData != null) {
      this.myPosts = this.prevData.getPosts;

      this.isEmpty = this.prevData.getisEmpty;
      currPost = this.prevData.getCurr;
      this.delPost = this.prevData.getdelPost;
    } else {
      this.myPosts = [
        {
          'title': "My Post",
          'content': "This is the content",
          'author': "Michel"
        },
        {
          'title': "My Post",
          'content': "This is the content",
          'author': "Michel"
        },
        {
          'title': "My Post",
          'content': "This is the content",
          'author': "Michel"
        }
      ];
      this.currPost = 1;
      this.isEmpty = false;
      this.delPost = false;
    }
  }


  get getCurr => this.currPost;
  set setCurr(int val) {
    this.currPost = val;
    notifyListeners();
  }

  get getPosts => this.myPosts;

  int get postLength => this.myPosts.length;

  set addPost(Map post) {
    this.myPosts.add(post);
    notifyListeners();
  }

  set setisEmpty(bool value) {
    this.isEmpty = value;
    notifyListeners();
  }

  get getisEmpty => this.isEmpty;

  String getPost(int index, String key) {
    return this.myPosts[index][key];
  }

  void setPost(int index, String key, String value) {
    this.myPosts[index][key] = value;
    notifyListeners();
  }

  void deletePost(int index) {
    this.myPosts.removeAt(index);
    // notifyListeners();
  }

  get getdelPost => this.delPost;
  set setdelPost(value) {
    this.delPost = value;
  }
}
