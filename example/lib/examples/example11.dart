import 'package:flutter/material.dart' hide Padding, Actions;
import 'package:vega_embed_flutter/vega_embed_flutter.dart';
import 'package:vega_embed_flutter/vega_embed_webview.dart';

/// An interactive multi line plot with hover tool tip.
/// Uses the VegaEmbedOptions to diable some actions in the menu.
class Example11 extends StatelessWidget {
  const Example11({super.key});

  @override
  Widget build(BuildContext context) {
    return VegaLiteEmbedder(
      viewFactoryId: '11',
      vegaLiteSpecLocation: 'assets/vega_lite_specs/bar_chart.json',
      vegaOptions: VegaEmbedOptions.fromJson({
        'downloadFileName': 'My_Custome_downlod_name',
      }),
    );
  }
}
