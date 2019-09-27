import 'package:flutter/foundation.dart';

class PostData with ChangeNotifier {
  String _title = '';
  String _content = '';
  String _author = '';
  bool submitted = false;

  set setTitle(value) {
    _title = value;
    notifyListeners();
  }

  set setContent(value) {
    _content = value;
    notifyListeners();
  }

  set setAuthor(value) {
    _author = value;
    notifyListeners();
  }

  set setSubmitted(bool val) {
    submitted = val;
    notifyListeners();
  }

  get getSubmitted => submitted;

  get getTitle => _title;
  get getContent => _content;
  get getAuthor => _author;
}
