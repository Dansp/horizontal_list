library horizontal_list;

import 'dart:async';

import 'package:flutter/material.dart';

class HorizontalListView extends StatefulWidget {
  ///Height of widget
  final double height;

  ///Width of widget
  final double width;

  ///List of widget to populate horizontal scroll.
  final List<Widget> list;

  ///Icon to show in next button
  final Icon? iconPrevious;

  ///Icon to show in next button
  final Icon? iconNext;

  ///On click listener when index changed;
  ///NOTE: Only will work with `enableManualScroll` false.
  final Function(int index)? onChanged;

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

  ///Item width.
  ///
  ///The width of item in list. Default is 300.
  final double itemWidth;

  ///Start from end of list
  ///
  ///Default is false;
  final bool isStartedFromEnd;

  ///If true, enable manual scroll, if false disable manual scroll and can only be scrolled by [iconNext] and [iconPrevious].
  ///
  /// Default is true.
  final bool enableManualScroll;

  const HorizontalListView({
    required this.height,
    required this.width,
    required this.list,
    this.itemWidth = 300,
    this.iconPrevious,
    this.iconNext,
    this.onChanged,
    this.onNextPressed,
    this.onPreviousPressed,
    this.durationAnimation = const Duration(milliseconds: 500),
    this.curveAnimation = Curves.ease,
    this.enableManualScroll = true,
    this.isStartedFromEnd = false,
    Key? key,
  }) : super(key: key);

  @override
  State<HorizontalListView> createState() => _HorizontalScrollState();
}

class _HorizontalScrollState extends State<HorizontalListView> {
  final ScrollController _controller = ScrollController();
  int _index = 0;
  var _reachEnd = true;
  var _startScroll = false;

  _listener() {
    if (_controller.hasClients) {
      final maxScroll = _controller.position.maxScrollExtent;
      final minScroll = _controller.position.minScrollExtent;
      setState(() {
        if (_controller.offset <= minScroll && maxScroll > 0) {
          _reachEnd = false;
        }
        _reachEnd = _controller.offset >= maxScroll;
        _startScroll = _controller.offset > minScroll;
      });
    }
  }

  @override
  void initState() {
    _controller.addListener(_listener);
    super.initState();
    if (!_controller.hasClients) {
      _waitWhile(() => !_controller.hasClients).then((value) {
        if (widget.isStartedFromEnd) {
          _index = widget.list.length - 1;
          _controller.jumpTo(_index * (widget.itemWidth - 100));

          if (!widget.enableManualScroll) {
            widget.onChanged?.call(_index);
          }
        }
        _listener();
      });
    }
  }

  ///Wait to wait a bool variable to change
  Future _waitWhile(bool Function() test,
      [Duration pollInterval = Duration.zero]) {
    var completer = Completer();
    check() {
      if (!test()) {
        completer.complete();
      } else {
        Timer(pollInterval, check);
      }
    }

    check();
    return completer.future;
  }

  @override
  void dispose() {
    _controller.removeListener(_listener);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: Stack(children: [
        Positioned(
          top: 0.0,
          bottom: 0,
          left: widget.iconPrevious != null ? 50.0 : 0,
          right: widget.iconNext != null ? 50.0 : 0,
          child: ListView.builder(
            physics: widget.enableManualScroll
                ? const ClampingScrollPhysics()
                : const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.horizontal,
            controller: _controller,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return SizedBox(
                  width: widget.itemWidth - 100, child: widget.list[index]);
            },
            itemCount: widget.list.length,
          ),
        ),
        widget.iconPrevious != null
            ? Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  icon: widget.iconPrevious!,
                  onPressed: _startScroll
                      ? () async {
                          _index -= 1;
                          if (_index < 0) {
                            _index = 0;
                          }

                          await _controller.animateTo(
                              _index * (widget.itemWidth - 100),
                              duration: widget.durationAnimation,
                              curve: widget.curveAnimation);
                          if (!widget.enableManualScroll) {
                            widget.onChanged?.call(_index);
                          }
                          widget.onPreviousPressed?.call();
                        }
                      : null,
                ))
            : Container(),
        widget.iconNext != null
            ? Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  icon: widget.iconNext!,
                  onPressed: _reachEnd
                      ? null
                      : () async {
                          _index += 1;
                          if (_index > widget.list.length - 1) {
                            _index = widget.list.length - 1;
                          }
                          await _controller.animateTo(
                              _index * (widget.itemWidth - 100),
                              duration: widget.durationAnimation,
                              curve: widget.curveAnimation);

                          if (!widget.enableManualScroll) {
                            widget.onChanged?.call(_index);
                          }
                          widget.onNextPressed?.call();
                        },
                ))
            : Container(),
      ]),
    );
  }
}
