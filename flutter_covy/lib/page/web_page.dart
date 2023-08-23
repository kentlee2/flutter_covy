import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:fwfh_webview/fwfh_webview.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';

class WebPage extends StatefulWidget {
  const WebPage({super.key});

  @override
  State<WebPage> createState() => _WebPageState();
}

class _WebPageState extends State<WebPage> {
  WebViewController? _controller;
  String title = "";
  String url = "";

  @override
  void initState() {
    super.initState();

    var data = Get.parameters;
    url = data["link"] ?? "";
    title = data["title"] ?? "";
    try {
      if (Platform.isAndroid || Platform.isIOS) {
        late final PlatformWebViewControllerCreationParams params;
        // WebViewPlatform.instance=WebKitWebViewPlatform();
        if (WebViewPlatform.instance is WebKitWebViewPlatform) {
          params = WebKitWebViewControllerCreationParams(
            allowsInlineMediaPlayback: true,
            mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
          );
        } else {
          params = const PlatformWebViewControllerCreationParams();
        }

        final WebViewController controller =
            WebViewController.fromPlatformCreationParams(params);
        // #enddocregion platform_features
        controller
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..setBackgroundColor(const Color(0x00000000))
          ..setNavigationDelegate(
            NavigationDelegate(
              onProgress: (int progress) {
                debugPrint('WebView is loading (progress : $progress%)');
                EasyLoading.showProgress(progress.toDouble() / 100);
              },
              onPageStarted: (String url) {
                debugPrint('Page started loading: $url');
              },
              onPageFinished: (String url) {
                debugPrint('Page finished loading: $url');
                EasyLoading.dismiss();
              },
              onWebResourceError: (WebResourceError error) {
                debugPrint('''
Page resource error:
  code: ${error.errorCode}
  description: ${error.description}
  errorType: ${error.errorType}
  isForMainFrame: ${error.isForMainFrame}
          ''');
              },
              onNavigationRequest: (NavigationRequest request) {
                if (request.url.startsWith('https://www.youtube.com/')) {
                  debugPrint('blocking navigation to ${request.url}');
                  return NavigationDecision.prevent;
                }
                debugPrint('allowing navigation to ${request.url}');
                return NavigationDecision.navigate;
              },
              onUrlChange: (UrlChange change) {
                debugPrint('url change to ${change.url}');
              },
            ),
          )
          ..addJavaScriptChannel(
            'Toaster',
            onMessageReceived: (JavaScriptMessage message) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(message.message)),
              );
            },
          )
          ..loadRequest(Uri.parse(url));

        // #docregion platform_features
        if (controller.platform is AndroidWebViewController) {
          AndroidWebViewController.enableDebugging(true);
          (controller.platform as AndroidWebViewController)
              .setMediaPlaybackRequiresUserGesture(false);
        }
        // #enddocregion platform_features
        _controller = controller;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: InkWell(
            child: const Icon(Icons.arrow_back_ios),
            onTap: () {
              Get.back();
            },
          ),
          title: Text(title),
          // This drop down menu demonstrates that Flutter widgets can be shown over the web view.
        ),
        body: _controller == null
            ? HtmlWidget('<iframe style="height=100%"  src=$url ></iframe>',
                factoryBuilder: () => MyWidgetFactory())
            : WebViewWidget(controller: _controller!),
      ),
      builder: EasyLoading.init(),
    );
  }
}

class MyWidgetFactory extends WidgetFactory with WebViewFactory {
  @override
  bool get webViewMediaPlaybackAlwaysAllow => true;
}
