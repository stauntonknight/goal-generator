import 'package:flutter/cupertino.dart';
import 'package:flutter_project/wish_model.dart';

class WishUI extends StatelessWidget {
  final WishModel wishModel;

  const WishUI(this.wishModel, {super.key});
  factory WishUI.fromText(String wishContent) {
    return  WishUI(WishModel(wishContent));
  }


  @override
  Widget build(BuildContext context) {
    return Text(wishModel.wish);
  }

}