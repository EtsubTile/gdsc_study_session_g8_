//import 'dart:js';

import 'package:flutter/material.dart';

class CustomPageRoute extends PageRouteBuilder {
  final Widget child;
  CustomPageRoute({
    required this.child,
  }) : super(
          transitionDuration: const Duration(seconds: 6),
          pageBuilder: (context, animation, secondaryAnimation) => child,
        );
  @override
  Widget buildTransition(BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation, Widget child) =>
      ScaleTransition(
          //position: Tween<Offset>(begin: const Offset(-1, 0), end: Offset.zero)
           //   .animate(animation),
          scale: animation,
          child: child);
}
