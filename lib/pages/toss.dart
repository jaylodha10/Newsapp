import 'dart:math';

import 'package:flutter/material.dart';

class MyTossState extends StatefulWidget {
  const MyTossState({super.key});

  @override
  State<MyTossState> createState() => _MyTossStateState();
}

class _MyTossStateState extends State<MyTossState>
    with SingleTickerProviderStateMixin {
  String _result = "Heads or Tails?";
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _isHeads = true;
  bool _isPreload = true; // Controls whether to show the preload screen

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reset();
        setState(() {
          _result = Random().nextBool() ? "Heads" : "Tails";
          _isHeads = _result == "Heads";
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _tossCoin() {
    setState(() {
      _result = "Flipping...";
    });
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Coin Toss"),
        backgroundColor: Colors.green,
        centerTitle: true,
      ),
      body: _isPreload ? _buildPreloadScreen() : _buildCoinTossScreen(),
    );
  }

  Widget _buildPreloadScreen() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'images/flipcoin.png',
            width: 150,
            height: 150,
          ),
          const SizedBox(height: 100),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _isPreload = false;
              });
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
              backgroundColor: Colors.green,
            ),
            child: const Text(
              "Get Started",
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCoinTossScreen() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              final flip = _animation.value * 2 * pi;
              return Transform(
                alignment: Alignment.center,
                transform: Matrix4.rotationY(flip),
                child: Image.asset(
                  _isHeads ? 'images/heads.png' : 'images/tails.png',
                  width: 150,
                  height: 150,
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 20),
        Text(
          _result,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 80),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _tossCoin,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 10),
                backgroundColor: Colors.green,
              ),
              child: const Text(
                "Toss",
                style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
