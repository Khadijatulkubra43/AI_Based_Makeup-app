import 'package:flutter/material.dart';

class RatingBar extends StatefulWidget {
  final int count;
  final double maxRating;
  final double value;
  final double size;
  final double padding;
  final bool selectAble;
  final Color selectColor;
  final ValueChanged<String> onRatingUpdate;

  const RatingBar({super.key, 
    this.maxRating = 10.0,
    this.count = 5,
    this.value = 10.0,
    this.size = 20,
    this.padding = 4.0, // Default padding if not provided
    this.selectColor = Colors.blue,
    this.selectAble = false,
    required this.onRatingUpdate,
  });

  @override
  State<RatingBar> createState() => _RatingBarState();
}

class _RatingBarState extends State<RatingBar> {
  late double value;

  @override
  Widget build(BuildContext context) {
    value = widget.value;
    return Listener(
      onPointerDown: (PointerDownEvent event) {
        double x = event.localPosition.dx;
        if (x < 0) x = 0;
        pointValue(x);
      },
      onPointerMove: (PointerMoveEvent event) {
        double x = event.localPosition.dx;
        if (x < 0) x = 0;
        pointValue(x);
      },
      onPointerUp: (_) {},
      behavior: HitTestBehavior.deferToChild,
      child: buildRowRating(),
    );
  }

  void pointValue(double dx) {
    if (!widget.selectAble) return;

    if (dx >=
        widget.size * widget.count + widget.padding * (widget.count - 1)) {
      value = widget.maxRating;
    } else {
      for (double i = 1; i <= widget.count; i++) {
        if (dx > widget.size * i + widget.padding * (i - 1) &&
            dx < widget.size * i + widget.padding * i) {
          value = i * (widget.maxRating / widget.count);
          break;
        } else if (dx > widget.size * (i - 1) + widget.padding * (i - 1) &&
            dx < widget.size * i + widget.padding * i) {
          value = (dx - widget.padding * (i - 1)) /
              (widget.size * widget.count) *
              widget.maxRating;
          break;
        }
      }
    }

    setState(() {
      widget.onRatingUpdate(value.toStringAsFixed(1));
    });
  }

  Widget buildRowRating() {
    return Stack(
      children: <Widget>[
        Row(
          mainAxisSize: MainAxisSize.min,
          children: buildNormalRow(),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: buildRow(),
        ),
      ],
    );
  }

  List<Widget> buildRow() {
    int full = fullStars();
    List<Widget> children = [];
    for (int i = 0; i < full; i++) {
      children.add(Icon(
        Icons.star,
        color: widget.selectColor,
        size: widget.size,
      ));
      if (i < widget.count - 1) {
        children.add(SizedBox(width: widget.padding));
      }
    }

    if (full < widget.count) {
      children.add(ClipRect(
        clipper: SMClipper(rating: star() * widget.size),
        child: Icon(
          Icons.star,
          color: widget.selectColor,
          size: widget.size,
        ),
      ));
    }
    return children;
  }

  List<Widget> buildNormalRow() {
    List<Widget> children = [];
    for (int i = 0; i < widget.count; i++) {
      children.add(Icon(
        Icons.star,
        color: Colors.grey,
        size: widget.size,
      ));
      if (i < widget.count - 1) {
        children.add(SizedBox(width: widget.padding));
      }
    }
    return children;
  }

  int fullStars() {
    return (value / (widget.maxRating / widget.count)).floor();
  }

  double star() {
    return (value % (widget.maxRating / widget.count)) /
        (widget.maxRating / widget.count);
  }
}

class SMClipper extends CustomClipper<Rect> {
  final double rating;

  SMClipper({required this.rating});

  @override
  Rect getClip(Size size) {
    return Rect.fromLTRB(0.0, 0.0, rating, size.height);
  }

  @override
  bool shouldReclip(SMClipper oldClipper) {
    return rating != oldClipper.rating;
  }
}
