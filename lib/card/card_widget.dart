import 'package:animation/card/controllers/card_animation_configuration.dart';
import 'package:animation/card/controllers/card_animation_controller.dart';
import 'package:flutter/material.dart';

class CardWidget extends StatefulWidget {
  final CardAnimationConfiguration animationConfiguration;
  final String imageAsset;
  final double imageSize;
  final String title;
  final TextStyle? titleStyle;
  final Widget? otherContent;

  const CardWidget({
    required this.imageAsset,
    required this.title,
    this.imageSize = 56,
    this.titleStyle,
    this.otherContent,
    this.animationConfiguration = const CardAnimationConfiguration(),
    super.key,
  });

  @override
  State<CardWidget> createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> with TickerProviderStateMixin {
  late final CardAnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = CardAnimationController(
      vsync: this,
      animationConfiguration: widget.animationConfiguration,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.black)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              onTap: () =>
                  _animationController.isCompleted ? _animationController.reverse() : _animationController.play(),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.title,
                    style: widget.titleStyle,
                  ),
                  RotationTransition(
                    turns: _animationController.iconTurnsAnimation,
                    child: const Icon(
                      Icons.arrow_back_ios_new_outlined,
                    ),
                  ),
                ],
              ),
            ),
            SizeTransition(
              sizeFactor: _animationController.imageScaleAnimation,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    widget.imageAsset,
                    width: widget.imageSize,
                    height: widget.imageSize,
                  ),
                  if (widget.otherContent != null)
                    Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: SizeTransition(
                        sizeFactor: _animationController.otherContentScaleAnimation,
                        axis: Axis.vertical,
                        child: widget.otherContent,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
