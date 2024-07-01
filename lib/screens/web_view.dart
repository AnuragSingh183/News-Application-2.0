import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class CustomWebView extends StatefulWidget {
  static const routeName = '/custom-web-view';

  @override
  _CustomWebViewState createState() => _CustomWebViewState();
}

class _CustomWebViewState extends State<CustomWebView> {
  bool loading = true;
  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    final news = args["news"];
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.black,
          leading: InkWell(
            onTap: () => Navigator.of(context).pop(),
            child: Icon(
              Icons.close_outlined,
              size: 30,
              color: Colors.white,
            ),
          ),
        ),
        //body: Text("hello"),
        body: Stack(
          children: [
            InAppWebView(
              onLoadStop: (controller, url) {
                setState(() {
                  loading = false;
                });
              },
              initialUrlRequest: URLRequest(url: Uri.parse(news.more)),
            ),
            if (loading)
              Center(
                child: CircularProgressIndicator(
                  color: Theme.of(context).hintColor,
                ),
              )
          ],
        ),
      ),
    );
  }
}
