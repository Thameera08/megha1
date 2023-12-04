// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';


class MyWebSite extends StatefulWidget {
  const MyWebSite({super.key});

  @override
  State<MyWebSite> createState() => _MyWebSiteState();
}

class _MyWebSiteState extends State<MyWebSite> {
  double _progress = 0;
  late InAppWebViewController inAppWebViewController;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        var isLastPage = inAppWebViewController.canGoBack();

        if (await isLastPage) {
          inAppWebViewController.goBack();
          return false;
        }

        return true;
      },
      child: Scaffold(
        body: Stack(
          children: [
            InAppWebView(
              initialUrlRequest:
                  URLRequest(url: Uri.parse("https://megha1.org/user")),
              onWebViewCreated: (InAppWebViewController controller) {
                inAppWebViewController = controller;
              },
              onProgressChanged:
                  (InAppWebViewController controller, int progress) {
                _progress = progress / 100;
              },
            ),
            _progress < 1
                ? LinearProgressIndicator(
                  value: _progress,
                )
                : const SizedBox()
          ],
        ),
      ),
    );
  }
}
