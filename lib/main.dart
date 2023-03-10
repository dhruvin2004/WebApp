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
              padding: EdgeInsets.only(left: 10),
              height: 50,
              width: w,
              decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  border:
                      Border(top: BorderSide(width: 1, color: Colors.black26))),
              child: Row(
                children: [
                  SizedBox(
                    width: w - 120 + AppString.a,
                    child: CupertinoSearchTextField(
                      onTap: () {
                        setState(() {
                          AppString.show = !AppString.show;
                          if (AppString.show == true) {
                            AppString.a = 0;
                          } else {
                            AppString.a = 95;
                          }
                        });
                      },
                      onChanged: (val) {
                        setState(() {
                          AppString.Value = val;
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  (AppString.show)
                      ? MaterialButton(
                          color: Colors.blue,
                          onPressed: () {
                            setState(() {
                              inAppWebViewController.loadUrl(
                                urlRequest: URLRequest(
                                  url: Uri.parse(
                                      'https://www.google.com/search?q=${AppString.Value}'),
                                ),
                              );
                            });
                          },
                          child: Text(
                            "Done",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      : Container(),
                ],
              ),
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
                onTap: () {
                  setState(() async {});
                },
                child: const Icon(
                  Icons.arrow_back_ios_new_outlined,
                  color: Colors.blue,
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() async {
                    if (await inAppWebViewController.canGoForward()) {
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
                  setState(() {
                    showModalBottomSheet(
                      backgroundColor: Colors.transparent,
                      context: context,
                      builder: (context) => Container(
                        height: 300,
                        width: w,
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Color(0xffe0e0e0),
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(20),
                          ),
                        ),
                        child: ListView(
                          children: [
                            Text("BookMark",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 18),),

                          ],
                        ),
                      ),
                    );
                  });
                },
                child: Icon(CupertinoIcons.book, color: Colors.blue),
              ),
            ],
          ),
        ),
        body: HomeScreen(),
      ),
    );
  }
}
