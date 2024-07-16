import 'package:browser/model/data.dart';
import 'package:flutter/cupertino.dart';

class DeleteProvider extends ChangeNotifier {
  void deleteAllData() {
    Bookmark.urls.clear();
    Bookmark.urlData.clear();
    notifyListeners();
  }

  void delete(int index) {
    Bookmark.urls.remove(Bookmark.urlData[index]);
    Bookmark.urlData.removeAt(index);
    notifyListeners();
  }
}
