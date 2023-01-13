import 'package:crome/app_string.dart';
import 'package:crome/homepage.dart';
import 'package:crome/webpage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
      home: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late InAppWebViewController inAppWebViewController;
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return SafeArea(
      maintainBottomViewPadding: true,
      child: Scaffold(
        bottomSheet: BottomSheet(
          onClosing: () {},
          builder: (BuildContext context) {
            return Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(left: 10, right: 10),
              height: 50,
              width: w,
              decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  border:
                      Border(top: BorderSide(width: 1, color: Colors.black26))),
              child: CupertinoSearchTextField(),
            );
          },
        ),
        bottomNavigationBar: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
          height: 40,
          width: w,
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: ()  {
                  setState(() async{

                  });
                },
                child: const Icon(
                  Icons.arrow_back_ios_new_outlined,
                  color: Colors.blue,
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() async{
                    if(await inAppWebViewController.canGoForward())
                    {
                    await inAppWebViewController.goForward();
                    }
                  });
                },
                child:
                    Icon(Icons.arrow_forward_ios_outlined, color: Colors.blue),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {});
                },
                child: Icon(CupertinoIcons.share, color: Colors.blue),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {});
                },
                child: Icon(CupertinoIcons.book, color: Colors.blue),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {});
                },
                child:
                    Icon(CupertinoIcons.square_on_square, color: Colors.blue),
              ),
            ],
          ),
        ),
        body: HomeScreen(),
      ),
    );
  }
}
