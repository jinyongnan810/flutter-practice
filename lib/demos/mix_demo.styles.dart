import 'package:flutter/material.dart';
import 'package:flutter_practice/demos/mix_demo.variants.dart';
import 'package:mix/mix.dart';

Style containerStyle = Style(
  $flex.gap(24),
  $flex.crossAxisAlignment.center(),
  $box.padding.horizontal(12),
  $box.padding.vertical(16),
);
Style lineStyle = Style(
  $flex.gap(12),
  $flex.mainAxisAlignment.center(),
);

Style buttonBaseStyle = Style(
  $flex.gap(4),
  $flex.mainAxisSize.min(),
  $box.padding.horizontal(12),
  $box.padding.vertical(8),
  $box.borderRadius(8),
  $text.style.color.white(),
  $with.scale(1),
  ($on.press | $on.longPress)(
    $with.scale(0.95),
  ),
  ButtonType.primary(
    // $box.color.ref($material.colorScheme.primary),
    // $box.color.blue(),
    $box.gradient.linear(colors: [Colors.blue, Colors.blueAccent]),
    $on.hover(
      // $box.color.darken(20),
      $with.scale(0.99),
      $box.shadow(blurRadius: 2, spreadRadius: 1),
    ),
  ),
  ButtonType.secondary(
    // $box.color.amber(),
    $box.gradient.linear(colors: [Colors.amber, Colors.amberAccent]),
    $text.style.color.black(),
    $on.hover(
      // $box.color.lighten(20),
      $with.scale(0.99),
      $box.shadow(blurRadius: 2, spreadRadius: 1),
    ),
  ),
  ButtonSize.small(
    $text.style.fontSize(12),
  ),
  ButtonSize.medium(
    $text.style.fontSize(16),
  ),
  ButtonSize.large(
    $text.style.fontSize(20),
  ),
);
Style iconStyle = Style(
  $icon.color.white(),
  $icon.size(16),
  ButtonSize.small(
    $icon.size(12),
  ),
  ButtonSize.medium(
    $icon.size(16),
  ),
  ButtonSize.large(
    $icon.size(20),
  ),
  ButtonType.secondary(
    $icon.color.black(),
  ),
);

Style hoverBoxStyle = Style(
  $flex.gap(4),
  $flex.mainAxisSize.min(),
  $flex.mainAxisAlignment.center(),
  $box.padding(12),
  $box.width(200),
  $box.height(200),
  $box.gradient.radial(
    colors: [Colors.purple, Colors.purpleAccent],
    center: Alignment.center,
    radius: 0.7,
  ),
  $box.borderRadius(8),
  $text.style.color.white(),
  $text.style.fontSize(80),
  $on.hover.event((event) {
    if (event == null) {
      return const Style.empty();
    }
    final pos = event.position;
    final offset = Offset(pos.x * 10, pos.y * 10);

    return Style(
      $box.transform(Matrix4.translationValues(offset.dx, offset.dy, 0.0)),
      $box.gradient.radial.center(pos),
    );
  }),
);
