import 'dart:convert';

import 'package:flutter/material.dart' hide Actions;
import 'package:vega_embed_flutter/src/vega_related_css.dart';
import 'package:vega_embed_flutter/src/web_view/vega_embed_options.dart';

import 'package:webview_flutter/webview_flutter.dart';

/// VegaLiteEmbedder as webview to use in non web flutter apps.
class VegaLiteWebViewEmbedder extends StatefulWidget {
  /// This is usually a json file served as part of your assets.
  final String vegaLiteSpecLocation;

  /// Embed options for webview [VegaLiteWebViewEmbedder].
  final VegaEmbedOptions? vegaEmbedOptions;

  /// Set of options for vegaEmbeder. Please check the documentation of vega-embed for more info.
  /// This is dartified version of the options avaailable.
  const VegaLiteWebViewEmbedder({
    Key? key,
    required this.vegaLiteSpecLocation,
    this.vegaEmbedOptions,
  }) : super(key: key);
  @override
  State<VegaLiteWebViewEmbedder> createState() =>
      _VegaLiteWebViewEmbedderState();
}

class _VegaLiteWebViewEmbedderState extends State<VegaLiteWebViewEmbedder> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();

    final WebViewController controller = WebViewController();
    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (String url) {
            controller.runJavaScript('''
              var allDetails = document.querySelectorAll('details');
              if(allDetails.length > 0){
                allDetails.forEach(e => e.remove());
              }
            ''');
          },
          onWebResourceError: (WebResourceError error) {
            debugPrint(error.toString());
          },
        ),
      );
    _controller = controller;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: DefaultAssetBundle.of(context)
          .loadString(widget.vegaLiteSpecLocation),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final divId = 'plot_div';
          final vegaEmbedScript =
              'vegaEmbed("#$divId", ${snapshot.data}, ${json.encode(widget.vegaEmbedOptions?.toJson() ?? '')})';
          final html = '''
        <!DOCTYPE html>
        <html lang="en">
          <head>
            <meta name="viewport" content="width=device-width, initial-scale=1.0" />
            <title>Document</title>        
            <script src="https://cdn.jsdelivr.net/npm/vega@5"></script>
            <script src="https://cdn.jsdelivr.net/npm/vega-lite@4"></script>
            <script src="https://cdn.jsdelivr.net/npm/vega-embed@6"></script>
            <style>$vegaEmbedStyle</style>
            <style>$vegaToolTipStyle</style>
          </head>
          <div id="$divId" width="100%" height="50%"></div>
          <script type="text/javascript">           
            $vegaEmbedScript;
          </script>
        
          </html>

        ''';

          _controller.loadHtmlString(html);

          return WebViewWidget(controller: _controller);
        }
        if (snapshot.hasError) {
          return Center(
            child: Text(
              'Sorry couldn\'t load the spec. Please check the path : ${widget.vegaLiteSpecLocation}',
              softWrap: true,
            ),
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
