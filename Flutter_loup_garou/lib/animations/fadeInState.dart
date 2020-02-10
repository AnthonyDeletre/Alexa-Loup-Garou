import 'package:flutter/material.dart';

class FadeInState extends StatefulWidget {

  final Widget child;
  FadeInState({@required this.child});

  @override
  createState() => _FadeInState();
}

class _FadeInState extends State<FadeInState> with SingleTickerProviderStateMixin{

  AnimationController _controller;
  Animation _animation;

  @override
  void initState(){
    super.initState();
    _controller = AnimationController(
      vsync: this, 
      duration: Duration(milliseconds: 500)
    );
    _animation = Tween(
      begin: 0.0, 
      end: 1.0,
    ).animate(_controller);
  }

  @override
  dispose(){
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext buildContext){

    _controller.forward();
    return FadeTransition(
      opacity: _animation,
      child: widget.child,
    );
  }
}