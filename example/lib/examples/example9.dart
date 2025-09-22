import 'package:flutter/material.dart' hide Padding;
import 'package:vega_embed_flutter/vega_embed_flutter.dart';
import 'package:vega_embed_flutter/vega_embed_webview.dart';

/// An interactive multi line plot with hover tool tip.
/// Uses the VegaEmbedOptions to set the scale of the plot.
class Example9 extends StatelessWidget {
  const Example9({super.key});

  @override
  Widget build(BuildContext context) {
    return VegaLiteEmbedder(
      viewFactoryId: '9',
      vegaLiteSpecLocation: 'assets/vega_lite_specs/bar_chart.json',
      vegaOptions: VegaEmbedOptions.fromJson({
        'scaleFactor': 2.0,
      }),
    );
  }
}
