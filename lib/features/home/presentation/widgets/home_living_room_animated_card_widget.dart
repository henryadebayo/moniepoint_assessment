import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:moniepoint_assessment/core/core.dart';

/// Slider call to action component
class SlideAction extends StatefulWidget {
  /// Create a new instance of the widget
  const SlideAction({
    super.key,
    this.sliderButtonIconSize = 24,
    this.sliderButtonIconPadding = 5,
    this.sliderButtonYOffset = 0,
    this.sliderRotate = true,
    this.height = 70,
    this.outerColor,
    this.borderRadius = 52,
    this.elevation = 6,
    this.animationDuration = const Duration(milliseconds: 300),
    this.reversed = false,
    this.alignment = Alignment.center,
    this.submittedIcon,
    this.onSubmit,
    this.child,
    this.innerColor,
    this.text,
    this.textStyle,
    this.sliderButtonIcon,
    this.sliderInitialProgress,
    this.sliderButtonIconPosition,
  });

  /// The size of the sliding icon
  final double sliderButtonIconSize;

  /// Tha padding of the sliding icon
  final double sliderButtonIconPadding;

  /// The offset on the y axis of the slider icon
  final double sliderButtonYOffset;

  /// If the slider icon rotates
  final bool sliderRotate;

  /// The child that is rendered instead of the default Text widget
  final Widget? child;

  /// The height of the component
  final double height;

  /// The color of the inner circular button, of the tick icon of the text.
  /// If not set, this attribute defaults to primaryIconTheme.
  final Color? innerColor;

  /// The color of the external area and of the arrow icon.
  /// If not set, this attribute defaults to accentColor from your theme.
  final Color? outerColor;

  /// The text showed in the default Text widget
  final String? text;

  /// Text style which is applied on the Text widget.
  ///
  /// By default, the text is colored using [innerColor].
  final TextStyle? textStyle;

  /// The borderRadius of the sliding icon and of the background
  final double borderRadius;

  /// Callback called on submit
  /// If this is null the component will not animate to complete
  final VoidCallback? onSubmit;

  /// Elevation of the component
  final double elevation;

  /// The widget to render instead of the default icon
  final Widget? sliderButtonIcon;

  /// The widget to render instead of the default submitted icon
  final Widget? submittedIcon;

  /// The duration of the animations
  final Duration animationDuration;

  /// If true the widget will be reversed
  final bool reversed;

  /// the alignment of the widget once it's submitted
  final Alignment alignment;

  final double? sliderInitialProgress;

  final double? sliderButtonIconPosition;

  @override
  SlideActionState createState() => SlideActionState();
}

/// Use a GlobalKey to access the state. This is the only way to call [SlideActionState.reset]
class SlideActionState extends State<SlideAction> with TickerProviderStateMixin {
  final GlobalKey _containerKey = GlobalKey();
  final GlobalKey _sliderKey = GlobalKey();
  double _dx = 0;
  double _maxDx = 0;

  double get _progress => _dx == 0 ? 0 : _dx / _maxDx;
  double _endDx = 0;
  final double _dz = 1;
  double? _containerWidth;
  late AnimationController _checkAnimationController;
  late AnimationController _shrinkAnimationController;
  late AnimationController _resizeAnimationController;
  late AnimationController _cancelAnimationController;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: widget.alignment,
      child: Transform(
        alignment: Alignment.center,
        transform: Matrix4.rotationY(widget.reversed ? pi : 0),
        child: Container(
          key: _containerKey,
          height: widget.height,
          width: _containerWidth,
          constraints: _containerWidth != null ? null : BoxConstraints.expand(height: widget.height),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            color: AppColors.white.withOpacity(0.3),
            border: Border.all(
              color: AppColors.white.withOpacity(0.1),
            ),
          ),
          child: Material(
            elevation: widget.elevation,
            color: (widget.outerColor ?? Theme.of(context).colorScheme.secondary).withOpacity(0.01),
            borderRadius: BorderRadius.circular(widget.borderRadius),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(widget.borderRadius),
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 5,
                  sigmaY: 5,
                ),
                child: Stack(
                  alignment: Alignment.center,
                  clipBehavior: Clip.none,
                  children: <Widget>[
                    Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.rotationY(widget.reversed ? pi : 0),
                      child: widget.child ??
                          Text(
                            widget.text!,
                            textAlign: TextAlign.center,
                            style: widget.textStyle ??
                                TextStyle(
                                  color: widget.innerColor ?? Theme.of(context).primaryIconTheme.color,
                                  fontSize: 24,
                                ),
                          ),
                    ),
                    Positioned(
                      left: widget.sliderButtonYOffset,
                      child: Transform.scale(
                        scale: _dz,
                        origin: Offset(_dx, 0),
                        child: Transform.translate(
                          offset: Offset(widget.sliderButtonIconPosition ?? _dx, 0),
                          child: Container(
                            key: _sliderKey,
                            child: GestureDetector(
                              onHorizontalDragUpdate: onHorizontalDragUpdate,
                              onHorizontalDragEnd: (details) async {
                                _endDx = _dx;
                                if (_progress <= 0.98 || widget.onSubmit == null) {
                                  await _cancelAnimation();
                                } else {
                                  unawaited(_cancelAnimation());
                                  widget.onSubmit!();
                                }
                              },
                              child: Material(
                                borderRadius: BorderRadius.circular(widget.borderRadius),
                                color: widget.innerColor ?? Theme.of(context).primaryIconTheme.color,
                                child: Container(
                                  padding: EdgeInsets.all(widget.sliderButtonIconPadding),
                                  child: Transform.rotate(
                                    angle: widget.sliderRotate ? -pi * _progress : 0,
                                    child: Center(
                                      child: widget.sliderButtonIcon ??
                                          Icon(
                                            Icons.arrow_forward,
                                            size: widget.sliderButtonIconSize,
                                            color: widget.outerColor ?? Theme.of(context).colorScheme.secondary,
                                          ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void onHorizontalDragUpdate(DragUpdateDetails details) {
    setState(() {
      _dx = (_dx + details.delta.dx).clamp(0.0, _maxDx);
    });
  }

  /// Call this method to revert the animations
  Future<void> reset() async {
    await _checkAnimationController.reverse().orCancel;

    await _shrinkAnimationController.reverse().orCancel;

    await _resizeAnimationController.reverse().orCancel;

    await _cancelAnimation();
  }

  Future<void> _cancelAnimation() async {
    _cancelAnimationController.reset();
    final animation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: _cancelAnimationController,
        curve: Curves.fastOutSlowIn,
      ),
    );

    animation.addListener(() {
      if (mounted) {
        setState(() {
          _dx = _endDx - (_endDx * animation.value);
        });
      }
    });
    await _cancelAnimationController.forward().orCancel;
  }

  @override
  void initState() {
    super.initState();

    _cancelAnimationController = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );
    _checkAnimationController = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );
    _shrinkAnimationController = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );

    _resizeAnimationController = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final containerBox = _containerKey.currentContext!.findRenderObject()! as RenderBox;
      _containerWidth = containerBox.size.width;

      final sliderBox = _sliderKey.currentContext!.findRenderObject()! as RenderBox;
      final sliderWidth = sliderBox.size.width;

      _maxDx = _containerWidth! - (sliderWidth / 2) - 40 - widget.sliderButtonYOffset;
    });
  }

  @override
  void dispose() {
    _cancelAnimationController.dispose();
    _checkAnimationController.dispose();
    _shrinkAnimationController.dispose();
    _resizeAnimationController.dispose();
    super.dispose();
  }
}
