import 'package:flutter/material.dart';

import '../bloc/i_bloc.dart';

abstract mixin class FunctionCallWhenBottomReached<T extends IBloc> {
  final ScrollController bottomReachedScrollController = ScrollController();

  static const double bottomReachedThreshold = 0.9;

  void _onScroll() {
    if (_isBottom) onReachBottom();
  }

  void listenToScrollController() {
    bottomReachedScrollController.addListener(_onScroll);
  }

  void onReachBottom();

  bool get _isBottom {
    if (!bottomReachedScrollController.hasClients) return false;
    final maxScroll = bottomReachedScrollController.position.maxScrollExtent;
    final currentScroll = bottomReachedScrollController.offset;
    return currentScroll >= (maxScroll * bottomReachedThreshold);
  }

  void disposeFunctionCallWhenBottomReached() {
    bottomReachedScrollController
      ..removeListener(_onScroll)
      ..dispose();
  }
}
