import 'package:flutter/foundation.dart';

class PostData with ChangeNotifier {
  final prevData;
  String title = '';
  String content = '';
  String author = '';
  bool submitted = false;

  PostData(this.prevData) {
    if (this.prevData != null) {
      this.title = this.prevData.getTitle;
      this.content = this.prevData.getContent;
      this.author = this.prevData.getAuthor;
      this.submitted = this.prevData.getSubmitted;
    } else {
      this.title = '';
      this.content = '';
      this.author = '';
      this.submitted = false;
    }
  }

  set setTitle(value) {
    this.title = value;
    notifyListeners();
  }

  set setContent(value) {
    this.content = value;
    notifyListeners();
  }

  set setAuthor(value) {
    this.author = value;
    notifyListeners();
  }

  set setSubmitted(bool val) {
    this.submitted = val;
    notifyListeners();
  }

  get getSubmitted => this.submitted;

  get getTitle => this.title;
  get getContent => this.content;
  get getAuthor => this.author;
}
