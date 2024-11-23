import 'package:animation/card/controllers/card_animation_configuration.dart';
import 'package:flutter/widgets.dart';

class CardAnimationController {
  final AnimationController _animationController;
  final CardAnimationConfiguration _animationConfiguration;

  late final Animation<double> imageScaleAnimation;
  late final Animation<double> iconTurnsAnimation;
  late final Animation<double> otherContentScaleAnimation;

  CardAnimationController({
    required TickerProvider vsync,
    CardAnimationConfiguration animationConfiguration = const CardAnimationConfiguration(),
  })  : _animationConfiguration = animationConfiguration,
        _animationController = AnimationController(
          vsync: vsync,
          duration: animationConfiguration.duration,
          reverseDuration: animationConfiguration.reverseDuration,
        ) {
    imageScaleAnimation = TweenSequence(
      [
        TweenSequenceItem(
          tween: Tween(
            begin: 0.0,
            end: 1.0,
          ).chain(CurveTween(curve: _animationConfiguration.imageScaleCurve)),
          weight: 40.0,
        ),
        TweenSequenceItem(
          tween: ConstantTween(1.0),
          weight: 60.0,
        ),
      ],
    ).animate(_animationController);

    otherContentScaleAnimation = TweenSequence(
      [
        TweenSequenceItem(
          tween: ConstantTween(0.0),
          weight: 40.0,
        ),
        TweenSequenceItem(
          tween: Tween(
            begin: 0.0,
            end: 1.0,
          ).chain(CurveTween(curve: _animationConfiguration.otherContentScaleCurve)),
          weight: 40.0,
        ),
        TweenSequenceItem(
          tween: ConstantTween(1.0),
          weight: 20.0,
        ),
      ],
    ).animate(_animationController);

    iconTurnsAnimation = Tween(
      begin: -0.25,
      end: 0.75,
    ).chain(CurveTween(curve: _animationConfiguration.iconTurnsCurve)).animate(_animationController);
  }

  bool get isCompleted {
    return _animationController.isCompleted;
  }

  void play({double? from}) {
    _animationController.forward(from: from);
  }

  void stop() {
    _animationController.stop();
  }

  void reset() {
    _animationController.reset();
  }

  void reverse({double? from}) {
    _animationController.reverse(from: from);
  }

  void dispose() {
    _animationController.dispose();
  }
}
