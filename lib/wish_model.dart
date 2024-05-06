import 'package:flutter/cupertino.dart';

class WishModel {
  final String wish;
  WishModel(this.wish);
}

class WishListModel extends ChangeNotifier {
  final List<WishModel> wishList = [];

  WishListModel();

  void addWish(String wish) {
    wishList.add(WishModel(wish));
    notifyListeners();
  }
  List<WishModel> getWishes() {
    return wishList;
  }

}