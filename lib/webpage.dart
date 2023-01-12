import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';


class WebPage extends StatefulWidget {
  String path;
   WebPage({Key? key,required this.path}) : super(key: key);

  @override
  State<WebPage> createState() => _WebPageState();
}

class _WebPageState extends State<WebPage> {
  late InAppWebViewController inAppWebViewController;

  @override
  Widget build(BuildContext context) {
    return InAppWebView(
      initialUrlRequest: URLRequest(
        url: Uri.parse('${widget.path}'),
      ),
      onWebViewCreated: (InAppWebViewController val) {
        setState(() {
          inAppWebViewController = val;
        });
      },
    );
  }
}
