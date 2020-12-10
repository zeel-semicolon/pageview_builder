import 'dart:math';

import 'package:flutter/material.dart';

class DotsIndicator extends AnimatedWidget {
  DotsIndicator({
    this.controller,
    this.itemCount,
    this.onPageSelected,
    this.color: Colors.green,
  }) : super(listenable: controller);
  final PageController controller;
  final int itemCount;
  final ValueChanged<int> onPageSelected;
  final Color color;
  static const double _kDotSize = 8.0;
  static const double _kMaxZoom = 2.0;
  static const double _kDotSpacing = 25.0;

  Widget _buildDot(int index) {
    double selectedness = Curves.easeOut.transform(
      max(
        0.0,
        1.0 - ((controller.page ?? controller.initialPage) - index).abs(),
      ),
    );
    double zoom = 1.0 + (_kMaxZoom - 1.0) * selectedness;
    return new Container(
      width: _kDotSpacing,
      child: new Center(
        child: new Material(
          color: color,
          type: MaterialType.circle,
          child: new Container(
            width: _kDotSize * zoom,
            height: _kDotSize * zoom,
            child: new InkWell(
              onTap: () => onPageSelected(index),
            ),
          ),
        ),
      ),
    );
  }

  Widget build(BuildContext context) {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: new List<Widget>.generate(itemCount, _buildDot),
    );
  }
}

class Introduction extends StatefulWidget {
  @override
  _IntroductionState createState() => _IntroductionState();
}

class _IntroductionState extends State<Introduction> {
  final _controller = new PageController();
  static const _kDuration = const Duration(milliseconds: 300);
  static const _kCurve = Curves.ease;
  // final _kArrowColor = Colors.black.withOpacity(0.8);

  final List<Widget> _pages = <Widget>[
    Container(
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image(
            fit: BoxFit.contain,
            image: AssetImage(
              "assets/images/intro_image1.jpg",
            ),
          ),
        ],
      ),
    ),
    new ConstrainedBox(
      constraints: const BoxConstraints.expand(),
      child: Center(
        child: Image(
          fit: BoxFit.contain,
          image: AssetImage(
            "assets/images/intro_image2.png",
          ),
        ),
      ),
    ),
    new ConstrainedBox(
      constraints: const BoxConstraints.expand(),
      child: Center(
        child: Image(
          fit: BoxFit.contain,
          image: AssetImage(
            "assets/images/intro_image3.jpg",
          ),
        ),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        // alignment: Alignment.center,
        children: [
          Image(
            fit: BoxFit.fill,
            width: MediaQuery.of(context).size.width,
            image: AssetImage(
              "assets/images/curve_image.png",
            ),
          ),
          Positioned(
            right: 100,
            top: 80,
            child: Text(
              "How to use App",
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
              ),
              // textAlign: TextAlign.center,
            ),
          ),
          PageView.builder(
            scrollDirection: Axis.horizontal,
            physics: AlwaysScrollableScrollPhysics(),
            controller: _controller,
            itemBuilder: (BuildContext context, int index) {
              return _pages[index % _pages.length];
            },
            itemCount: 3,
          ),
          Positioned(
            bottom: 0.0,
            left: 0.0,
            child: Container(
              // color: Colors.grey[800].withOpacity(0.5),
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: DotsIndicator(
                  controller: _controller,
                  itemCount: _pages.length,
                  onPageSelected: (int page) {
                    _controller.animateToPage(
                      page,
                      duration: _kDuration,
                      curve: _kCurve,
                    );
                  },
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 10.0,
            right: 0.0,
            child: Container(
              height: 50,
              padding: EdgeInsets.fromLTRB(20, 15, 30, 10),
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  bottomLeft: Radius.circular(30),
                ),
              ),
              child: Text(
                "Skip...",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          )
        ],
      ),
    );
  }
}

// Widget build(BuildContext context) {
//   return new Row(
//     mainAxisAlignment: MainAxisAlignment.center,
//     children: new List<Widget>.generate(itemCount, _buildDot),
//   );
// }
