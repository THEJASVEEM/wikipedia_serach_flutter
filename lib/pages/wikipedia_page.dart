import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

/// [WikipediaPage] is a StatefulWidget that represents a page for displaying
/// a Wikipedia article based on the provided title.
///
/// The [InAppWebView] widget is used to display the web content.
/// It's configured with various options, such as enabling media playback
///  without user gestures and handling permission requests.
///
/// The [androidOnPermissionRequest] callback allows you to handle permission
///  requests from the WebView, and in this case, it grants all requested permissions.
///
/// The [onConsoleMessage] callback is used to print console messages to the
/// debug console when running in debug mode.
///
/// The [AppBar] at the top provides a title for the Wikipedia page and back button.
///
/// The page's URL is constructed based on the provided [title], and the
/// initial URL request is set accordingly.
///
/// This page allows users to view Wikipedia articles by specifying the title,
/// and it uses the [InAppWebView] to display the content with specific configuration options.
class WikipediaPage extends StatefulWidget {
  const WikipediaPage({super.key, required this.title});

  final String title;

  @override
  State<WikipediaPage> createState() => _WikipediaPageState();
}

class _WikipediaPageState extends State<WikipediaPage> {
  final GlobalKey webViewKey = GlobalKey();

  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
      crossPlatform: InAppWebViewOptions(
        useShouldOverrideUrlLoading: true,
        mediaPlaybackRequiresUserGesture: false,
      ),
      android: AndroidInAppWebViewOptions(
        useHybridComposition: true,
      ),
      ios: IOSInAppWebViewOptions(
        allowsInlineMediaPlayback: true,
      ));

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: const Color(0xFF2A2A2A),
            title: const Text(
              "Wikipedia Page",
              style: TextStyle(color: Colors.white),
            )),
        body: SafeArea(
            child: InAppWebView(
          key: webViewKey,
          initialUrlRequest: URLRequest(
              url: Uri.parse('https://en.wikipedia.org/wiki/${widget.title}')),
          initialOptions: options,
          androidOnPermissionRequest: (controller, origin, resources) async {
            return PermissionRequestResponse(
                resources: resources,
                action: PermissionRequestResponseAction.GRANT);
          },
          onConsoleMessage: (controller, consoleMessage) {
            if (kDebugMode) {
              print(consoleMessage);
            }
          },
        )));
  }
}
