import 'package:crome/app_string.dart';
import 'package:crome/homepage.dart';
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
                  setState(() {
                    inAppWebViewController.loadUrl(
                      urlRequest: URLRequest(
                        url: Uri.parse(
                            'https://www.google.com'),
                      ),
                    );
                  });
                },
                child: Icon(CupertinoIcons.add, color: Colors.blue),
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
                      builder: (context) => Bottmsheet(),
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

class Bottmsheet extends StatefulWidget {
  const Bottmsheet({Key? key}) : super(key: key);

  @override
  State<Bottmsheet> createState() => _BottmsheetState();
}

class _BottmsheetState extends State<Bottmsheet> {
  int? _value = 0;

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Container(
      height: h,
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: Row(
              children: [
                GestureDetector(
                    onTap: () {
                      setState(() {
                        Navigator.pop(context);
                      });
                    },
                    child: Icon(
                      Icons.keyboard_arrow_down,
                      size: 30,
                    )),
                SizedBox(
                  width: 80,
                ),
                CupertinoSlidingSegmentedControl(
                    groupValue: _value,
                    thumbColor: Colors.white,
                    backgroundColor: Colors.grey.shade300,
                    children: {
                      0: Text("History"),
                      1: Text("BookMark"),
                    },
                    onValueChanged: (val) {
                      setState(() {
                        _value = val;
                      });
                    }),
              ],
            ),
          ),
          Expanded(
            flex: 6,
            child: (_value == 0)?Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "History",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),


              ],
            ):Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "BookMark",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),


              ],
            ),
          ),
        ],
      ),
    );
  }
}
