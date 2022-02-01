library horizontal_list;

import 'package:flutter/material.dart';

class HorizontalListView extends StatefulWidget {
  ///List of widget to populate horizontal scroll.
  final List<Widget> list;

  ///Icon to show in next button
  final Icon iconPrevious;

  ///Icon to show in next button
  final Icon iconNext;

  ///On click listener when next button was clicked.
  final VoidCallback? onNextPressed;

  ///On click listener when previous button was clicked.
  final VoidCallback? onPreviousPressed;

  ///Duration of animation when click on button next or previous. Default is 500 milliseconds.
  ///
  /// Duration(milliseconds: 500);
  final Duration durationAnimation;

  ///Curve to animation when click on button next or previous. Default is [Curves.ease]
  final Curve curveAnimation;

  ///Size of scroll offset.
  ///
  ///The size that scroll will go when click on button next or previous, the default is 300.
  final int scrollSize;

  const HorizontalListView({
    required this.list,
    required this.iconPrevious,
    required this.iconNext,
    this.onNextPressed,
    this.onPreviousPressed,
    this.durationAnimation = const Duration(milliseconds: 500),
    this.curveAnimation = Curves.ease,
    this.scrollSize = 300,
    Key? key,
  }) : super(key: key);

  @override
  State<HorizontalListView> createState() => _HorizontalScrollState();
}

class _HorizontalScrollState extends State<HorizontalListView> {
  final ScrollController _controller = ScrollController();

  var _reachEnd = false;
  var _startScroll = false;

  _listener() {
    final maxScroll = _controller.position.maxScrollExtent;
    final minScroll = _controller.position.minScrollExtent;
    if (_controller.offset >= maxScroll) {
      _reachEnd = true;
    }
    if (_controller.offset <= minScroll) {
      _reachEnd = false;
    }
    setState(() {
      _startScroll = _controller.offset > minScroll;
    });
  }

  @override
  void initState() {
    _controller.addListener(_listener);
    super.initState();
  }

  @override
  void dispose() {
    _controller.removeListener(_listener);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Positioned(
        top: 0.0,
        bottom: 0,
        left: 50.0,
        right: 50.0,
        child: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          scrollDirection: Axis.horizontal,
          controller: _controller,
          itemBuilder: (context, index) {
            return widget.list[index];
          },
          itemCount: widget.list.length,
        ),
      ),
      Visibility(
        visible: !_reachEnd,
        child: Align(
            alignment: Alignment.centerRight,
            child: IconButton(
              icon: widget.iconNext,
              onPressed: _reachEnd
                  ? null
                  : () {
                      if (widget.onNextPressed != null) {
                        widget.onNextPressed!();
                      }
                      _controller.animateTo(_controller.offset + widget.scrollSize,
                          duration: widget.durationAnimation,
                          curve: widget.curveAnimation);
                    },
            )),
      ),
      Visibility(
        visible: _startScroll,
        child: Align(
            alignment: Alignment.centerLeft,
            child: IconButton(
              icon: widget.iconPrevious,
              onPressed: _startScroll
                  ? () {
                      if (widget.onPreviousPressed != null) {
                        widget.onPreviousPressed!();
                      }
                      _controller.animateTo(_controller.offset - widget.scrollSize,
                          duration: widget.durationAnimation,
                          curve: widget.curveAnimation);
                    }
                  : null,
            )),
      )
    ]);
  }
}
