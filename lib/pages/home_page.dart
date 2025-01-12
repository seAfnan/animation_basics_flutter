import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage>
    with SingleTickerProviderStateMixin {
  double _circleSize = 100;
  final Tween<double> _backgroundScaleTween =
      Tween<double>(begin: 0.1, end: 1.0);

  AnimationController? _starIconAnimationController;

  @override
  void initState() {
    super.initState();
    _starIconAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   title: const Text('Homepage'),
        // ),
        body: Container(
      child: Stack(clipBehavior: Clip.none, children: [
        _pageBackground(),
        Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [_circleAnimButton(), _starIcon()])
      ]),
    ));
  }

  Widget _pageBackground() {
    return TweenAnimationBuilder(
      tween: _backgroundScaleTween,
      curve: Curves.easeInOutCubicEmphasized,
      duration: const Duration(seconds: 2),
      builder: (context, double scale, child) => Transform.scale(
        scale: scale,
        child: child,
      ),
      child: Container(color: const Color.fromARGB(255, 102, 0, 255)),
    );
  }

  Widget _circleAnimButton() {
    return Center(
      child: GestureDetector(
          onTap: () {
            setState(() {
              _circleSize = _circleSize == 100 ? 200 : 100;
            });
          },
          child: AnimatedContainer(
            duration: const Duration(seconds: 2),
            // curve: Curves.bounceInOut,
            width: _circleSize,
            height: _circleSize,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 197, 218, 45),
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: Text(
                'Tap me!',
                style: TextStyle(color: Colors.white),
              ),
            ),
          )),
    );
  }

  Widget _starIcon() {
    return AnimatedBuilder(
        animation: _starIconAnimationController!.view,
        builder: (context, child) {
          return Transform.rotate(
              angle: _starIconAnimationController!.value * 2 * 3.14159,
              child: child);
        },
        child: const Icon(Icons.star, size: 100, color: Colors.white));
  }
}
