import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:url_launcher/url_launcher.dart';




class TaxiSchool extends StatefulWidget {
  @override
  _TaxiSchoolState createState() => _TaxiSchoolState();
}


class _TaxiSchoolState extends State<TaxiSchool> {
  late InAppWebViewController controller;
  bool _isLoading = true;

  // Add a list to keep track of the history of visited URLs
  List<Uri> history = [];




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF95C0EC),
      body: SafeArea(
        child: WillPopScope(
          onWillPop: () async {
            // Check if there is a previous page in history
            if (history.length > 1) {
              // Navigate to the previous page
              controller.goBack();
              // Remove the current page from history
              history.removeLast();
              return false; // Prevent the app from closing
            }
            return true; // Allow the app to close if there is no previous page
          },
          child: Stack(
            children: [
              InAppWebView(
                initialUrlRequest: URLRequest(url: WebUri('https://www.taxischool.ie/taxiapp/public/')),
                initialOptions: InAppWebViewGroupOptions(
                  crossPlatform: InAppWebViewOptions(
                    useShouldOverrideUrlLoading: true,
                    useOnDownloadStart: true,
                  ),
                ),
                onWebViewCreated: (InAppWebViewController controller) {
                  this.controller = controller;
                },
                onLoadStart: (controller, url) {
                  setState(() {
                    _isLoading = true;
                  });
                },
                onLoadStop: (controller, url) {
                  setState(() {
                    _isLoading = false;
                  });
                  // Add the current page to history
                  history.add(url!);
                },


                onDownloadStart: (controller, url) async {
                  // Implement your download logic here
                  // For example, you can use the url_launcher package to launch the download URL
                  if (await canLaunch(url.toString())) {
                    await launch(url.toString());
                  } else {
                    throw 'Could not launch $url';
                  }
                },
                shouldOverrideUrlLoading: (controller, navigationAction) async {
                  var uri = navigationAction.request.url!;
                  if (!uri.toString().startsWith('http')) {
                    if (await canLaunchUrl(uri)) {
                      await launchUrl(uri);
                      return NavigationActionPolicy.CANCEL;
                    }
                  }

                  return NavigationActionPolicy.ALLOW;
                },
              ),
              if (_isLoading)
                Center(child: CircularProgressIndicator(),),
            ],
          ),
        ),
      ),
    );
  }
}
