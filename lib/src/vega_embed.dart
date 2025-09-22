import 'package:flutter/material.dart';
import 'package:web/web.dart' as web;
import 'package:vega_embed_flutter/src/fakeui/fake_platformViewRegistry.dart'
    if (dart.library.html) 'dart:ui' as ui;

import 'package:vega_embed_flutter/src/vega_interops.dart';
import 'package:vega_embed_flutter/src/vega_related_css.dart';

/// A Widget that embeds VegaLite charts on to the [HtmlElementView] widget to
/// bring vega-charts in flutter web.
class VegaLiteEmbedder extends StatefulWidget {
  /// This viewFactory ID should be unique across elements.
  /// Please ensure this. Otherwise it might result in some unwanted behavior.
  final String viewFactoryId;

  /// This is usually a URL pointing to a json file or a json file served as part of your web assets.
  final String vegaLiteSpecLocation;

  /// Set of options for vegaEmbedder. Please check the documentation of vega-embed for more info.
  /// This is a dartified version of the options available.
  /// Please bear in mind this functionality is not tested and could break easily.
  final VegaEmbedOptions? vegaOptions;

  /// Constructor for VegaLiteEmbedder.
  const VegaLiteEmbedder({
    super.key,
    required this.viewFactoryId,
    required this.vegaLiteSpecLocation,
    this.vegaOptions,
  });
  @override
  State<VegaLiteEmbedder> createState() => _VegaLiteEmbedderState();
}

class _VegaLiteEmbedderState extends State<VegaLiteEmbedder> {
  /// The root element for the view
  final web.HTMLDivElement _element = web.HTMLDivElement();

  /// The div element where the chart will be embedded
  late web.HTMLDivElement _chartDiv;

  @override
  void initState() {
    super.initState();
    _chartDiv = web.HTMLDivElement()..id = widget.viewFactoryId;

    _element.append(_chartDiv);

    // Add the css style elements to renders plots options properly.
    final styleElement = web.HTMLStyleElement()..textContent = vegaEmbedStyle;
    final tooltipStyleElement = web.HTMLStyleElement()..textContent = vegaToolTipStyle;
    _element.append(styleElement);
    _element.append(tooltipStyleElement);
  }

  @override
  Widget build(BuildContext context) {
    ui.platformViewRegistry.registerViewFactory(widget.viewFactoryId,
        (int viewId) {
      return _element;
    });
    if (widget.vegaOptions != null) {
      if (widget.vegaOptions?.defaultStyle is String) {
        final embedStyle = web.HTMLStyleElement()
          ..innerText = widget.vegaOptions?.defaultStyle.toString() ?? '';
        _element.append(embedStyle);
      }
      vegaEmbed(_chartDiv, widget.vegaLiteSpecLocation, widget.vegaOptions);
    } else {
      vegaEmbed(_chartDiv, widget.vegaLiteSpecLocation);
    }
    return HtmlElementView(viewType: widget.viewFactoryId);
  }
}