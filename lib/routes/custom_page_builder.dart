import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

enum TransitionType {
  fade,
  rotation,
  size,
  scale,
  leftToRight,
  rightToLeft,
  topToBottom,
  bottomToTop
}

class CustomPageBuilder {
  static CustomTransitionPage<T> getTransitionPage<T>(
      {required BuildContext context,
      required GoRouterState state,
      required Widget child,
      Object? arguments,
      bool fullscreenDialog = false,
      bool maintainState = true,
      bool opaque = true,
      TransitionType? transitionType}) {
    return CustomTransitionPage<T>(
        key: state.pageKey,
        child: child,
        transitionDuration: const Duration(milliseconds: 500),
        arguments: arguments,
        fullscreenDialog: fullscreenDialog,
        maintainState: maintainState,
        opaque: opaque,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          switch (transitionType) {
            case TransitionType.fade:
              return FadeTransition(opacity: animation, child: child);
            case TransitionType.rotation:
              return RotationTransition(turns: animation, child: child);
            case TransitionType.size:
              return SizeTransition(sizeFactor: animation, child: child);
            case TransitionType.scale:
              return ScaleTransition(scale: animation, child: child);
            case TransitionType.leftToRight:
              return SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(-1.0, 0.0),
                  end: Offset.zero,
                ).animate(animation),
                child: child,
              );
            case TransitionType.rightToLeft:
              return SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(1.0, 0.0),
                  end: Offset.zero,
                ).animate(animation),
                child: child,
              );
            case TransitionType.topToBottom:
              return SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0.0, -1.0),
                  end: Offset.zero,
                ).animate(animation),
                child: child,
              );
            case TransitionType.bottomToTop:
              return SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0.0, 1.0),
                  end: Offset.zero,
                ).animate(animation),
                child: child,
              );
            default:
              return FadeTransition(opacity: animation, child: child);
          }
        });
  }
}
