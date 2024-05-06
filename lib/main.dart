import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/wish_generator.dart';
import 'package:flutter_project/wish_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wish app Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const WishListPage(title: 'Wish Demo Home Page'),
    );
  }
}

class WishListPage extends StatefulWidget {
  const WishListPage({super.key, required this.title});

  final String title;

  @override
  State<WishListPage> createState() => _WishListPageState();
}

class _WishListPageState extends State<WishListPage> {
  WishListModel wishListModel = WishListModel();
  final textController = TextEditingController();
  int counter = 0;
  @override
  void initState() {
    super.initState();
    wishListModel.addListener(() {
      setState(() {});
    });
  }
  void _addWish(String wish) {
    print("Got a wish $wish");
    counter -= 1;
    wishListModel.addWish(wish);
  }
  void _onSubmit(String unused) {
    _generateWish();
  }
  void _generateWish() {
    String value = textController.text;

    WishGenerator().generateWish(value).then((wish) => _addWish(wish.wish));
    setState(() {
      counter += 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Visibility(visible: counter != 0, child: const CircularProgressIndicator()),
            TextButton(onPressed: _generateWish, child: const Text('Generate')),
            TextField(
              controller: textController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Enter a wish!",
              ),
              onSubmitted: _onSubmit,
            ),
            ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: wishListModel.getWishes().length,
                itemBuilder: (BuildContext context, int index) {
                  String wish = wishListModel.getWishes()[index].wish;
                  return SizedBox(height: 50, child: Center(child: Text(wish)));
                }),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
