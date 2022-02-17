library horizontal_list;

import 'dart:async';
import 'dart:developer';

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

  ///If true, enable manual scroll, if false disable manual scroll and can only be scrolled by [iconNext] and [iconPrevious].
  ///
  /// Default is true.
  final bool enableManualScroll;

  const HorizontalListView({
    required this.height,
    required this.width,
    required this.list,
    this.iconPrevious,
    this.iconNext,
    this.onNextPressed,
    this.onPreviousPressed,
    this.durationAnimation = const Duration(milliseconds: 500),
    this.curveAnimation = Curves.ease,
    this.scrollSize = 300,
    this.enableManualScroll = true,
    Key? key,
  }) : super(key: key);

  @override
  State<HorizontalListView> createState() => _HorizontalScrollState();
}

class _HorizontalScrollState extends State<HorizontalListView> {
  final ScrollController _controller = ScrollController();

  var _reachEnd = true;
  var _startScroll = false;

  _listener() {
    if (_controller.hasClients) {
      final maxScroll = _controller.position.maxScrollExtent;
      final minScroll = _controller.position.minScrollExtent;
      setState(() {
        log('minScroll $minScroll, maxScroll $maxScroll, offset ${_controller.offset}');
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
            itemBuilder: (context, index) {
              return widget.list[index];
            },
            itemCount: widget.list.length,
          ),
        ),
        widget.iconPrevious != null
            ? Visibility(
                visible: _startScroll,
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      icon: widget.iconPrevious!,
                      onPressed: _startScroll
                          ? () {
                              double value =
                                  _controller.offset - widget.scrollSize;
                              if (value < widget.scrollSize) {
                                value = _controller.position.minScrollExtent;
                              }
                              _controller.animateTo(value,
                                  duration: widget.durationAnimation,
                                  curve: widget.curveAnimation);
                              if (widget.onPreviousPressed != null) {
                                widget.onPreviousPressed!();
                              }
                            }
                          : null,
                    )),
              )
            : Container(),
        widget.iconNext != null
            ? Visibility(
                visible: !_reachEnd,
                child: Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      icon: widget.iconNext!,
                      onPressed: _reachEnd
                          ? null
                          : () {
                              double value =
                                  _controller.offset + widget.scrollSize;
                              if (value <=
                                  _controller.position.maxScrollExtent) {
                                var diff =
                                    _controller.position.maxScrollExtent -
                                        value;
                                if (diff < value && diff < widget.scrollSize) {
                                  value += diff;
                                }
                              } else {
                                value = _controller.position.maxScrollExtent;
                              }
                              _controller.animateTo(value,
                                  duration: widget.durationAnimation,
                                  curve: widget.curveAnimation);
                              if (widget.onNextPressed != null) {
                                widget.onNextPressed!();
                              }
                            },
                    )),
              )
            : Container(),
      ]),
    );
  }
}
