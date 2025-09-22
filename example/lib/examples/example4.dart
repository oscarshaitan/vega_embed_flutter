import 'package:flutter/material.dart';
import 'package:vega_embed_flutter/vega_embed_flutter.dart' hide VegaEmbedOptions;
import 'package:vega_embed_flutter/src/vega_interops.dart';

/// An interactive multi line plot with hover tool tip.
/// Uses the VegaEmbedOptions to set the renderer to svg.
/// It defaults to canvas.
class Example4 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return VegaLiteEmbedder(
      viewFactoryId: "4",
      vegaLiteSpecLocation:
          'assets/vega_lite_specs/interactive_multiline_plot.json',
      vegaOptions: VegaEmbedOptions(
        renderer: 'svg',
      ),
    );
  }
}
