
import 'package:flutter/material.dart';

class ImageRoundButton extends StatefulWidget {
  final GestureTapCallback onPressed;
  final String imagePath;

  static const Color normalColor = Color(0xA0FFFFFF);
  static const Color pressedColor = Color(0xA0A0A0A0);

  final double? top;
  final double? right;
  final double? bottom;
  final double? left;
  final double size;

  ImageRoundButton({
    required this.onPressed,
    required this.imagePath,
    this.top,
    this.right,
    this.bottom,
    this.left,
    required this.size,
  }) : super(key: Key(imagePath));

  @override
  _ImageRoundButtonState createState() => _ImageRoundButtonState();
}

class _ImageRoundButtonState extends State<ImageRoundButton> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.9).animate(_controller);
    _colorAnimation = ColorTween(begin: ImageRoundButton.normalColor, end: ImageRoundButton.pressedColor).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    _controller.forward();
  }

  void _onTapUp(TapUpDetails details) {
    _controller.reverse();
    widget.onPressed();
  }

  void _onTapCancel() {
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: widget.top,
      right: widget.right,
      bottom: widget.bottom,
      left: widget.left,
      width: widget.size,
      height: widget.size,
      child: GestureDetector(
        onTapDown: _onTapDown,
        onTapUp: _onTapUp,
        onTapCancel: _onTapCancel,
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: AnimatedBuilder(
            animation: _colorAnimation,
            builder: (context, child) {
              return _imageContainer(_colorAnimation.value);
            },
          ),
        ),
      ),
    );
  }

  Container _imageContainer(Color? color) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(widget.size / 2),
        color: color,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            offset: Offset(0, 2),
            blurRadius: 6,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Align(
        alignment: Alignment.center,
        child: Container(
          height: widget.size - 15,
          width: widget.size - 15,
          child: Image.asset(
            widget.imagePath,
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}