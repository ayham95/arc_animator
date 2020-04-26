library arc_animator;
import 'package:flutter/material.dart';

typedef OffsetChange = Function(Offset);

/// A [Tween] that interpolates an [Offset] along a circular arc.
///
/// This class specializes the interpolation of [Tween<Offset>] so that instead
/// of a straight line, the intermediate points follow the arc of a circle in a
/// manner consistent with material design principles.
///
/// The arc's radius is related to the bounding box that contains the [begin]
/// and [end] points. If the bounding box is taller than it is wide, then the
/// center of the circle will be horizontally aligned with the end point.
/// Otherwise the center of the circle will be aligned with the begin point.
/// The arc's sweep is always less than or equal to 90 degrees.
/// /// See also:
///
///  * [Tween], for a discussion on how to use interpolation objects.
///  * [MaterialRectArcTween], which extends this concept to interpolating [Rect]s.
class ArcAnimator extends StatefulWidget {
  /// Creates a [Tween] for animating [Offset]s along a circular arc.

  /// The beginning offset. Where the [child} is initially at.
  final Offset begin;

  /// The end offset
  final Offset end;
  final Widget child;
  final AnimationController controller;
  final Curve curve;
  final statusListener;
  final OffsetChange offsetChanging;

  const ArcAnimator({Key key,
    this.begin = Offset.zero,
    this.end = Offset.zero,
    this.child,
    this.controller,
    this.curve = Curves.linear,
    this.statusListener, this.offsetChanging})
      : assert(child != null),
        assert(controller != null),
        super(key: key);

  @override
  _ArcAnimatorState createState() => _ArcAnimatorState();
}

class _ArcAnimatorState extends State<ArcAnimator> {
  Animation beginTween;
  Animation endTween;

  bool start = true;

  @override
  void initState() {
    beginTween = MaterialPointArcTween(begin: widget.begin, end: widget.end)
        .chain(CurveTween(curve: widget.curve))
        .animate(widget.controller)
      ..addListener(() {
        setState(() {});
      });
    endTween = MaterialPointArcTween(begin: widget.end, end: widget.begin)
        .chain(CurveTween(curve: widget.curve))
        .animate(widget.controller)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          setState(() {
            start = !start;
          });
          widget.controller.reset();
        }
      });
    widget.controller
        ..addStatusListener((status) {
      if (widget.statusListener != null) widget.statusListener(status);
    })..addListener(() {if(widget.offsetChanging!= null) widget.offsetChanging(start ? beginTween.value : endTween.value);});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: start ? beginTween.value : endTween.value,
      child: widget.child,
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
