import 'package:flutter/material.dart' hide Padding;
import 'package:vega_embed_flutter/vega_embed_flutter.dart';
import 'package:vega_embed_flutter/vega_embed_webview.dart';

/// An interactive multi line plot with hover tool tip.
/// Uses the VegaEmbedOptions to diable some actions in the menu.
class Example10 extends StatelessWidget {
  const Example10({super.key});

  @override
  Widget build(BuildContext context) {
    return VegaLiteEmbedder(
      viewFactoryId: '10',
      vegaLiteSpecLocation: 'assets/vega_lite_specs/bar_chart.json',
      vegaOptions: VegaEmbedOptions.fromJson({
        'actions': {
          'editor': false,
          'source': false,
        },
      }),
    );
  }
}
