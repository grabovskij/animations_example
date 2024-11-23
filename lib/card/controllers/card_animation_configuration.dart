import 'package:flutter/widgets.dart';

class CardAnimationConfiguration {
  final Duration duration;
  final Duration? reverseDuration;
  final Curve imageScaleCurve;
  final Curve iconTurnsCurve;
  final Curve otherContentScaleCurve;

  const CardAnimationConfiguration({
    this.imageScaleCurve = Curves.linear,
    this.otherContentScaleCurve = Curves.linear,
    this.iconTurnsCurve = Curves.easeInOutCubic,
    this.duration = const Duration(milliseconds: 500),
    this.reverseDuration,
  });
}
