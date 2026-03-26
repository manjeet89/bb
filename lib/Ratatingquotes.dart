import 'dart:async';
import 'package:flutter/material.dart';

class RotatingQuotes extends StatefulWidget {
  final List<String> quotes;
  final Duration duration;

  const RotatingQuotes({
    super.key,
    required this.quotes,
    this.duration = const Duration(seconds: 5),
  });

  @override
  State<RotatingQuotes> createState() => _RotatingQuotesState();
}

class _RotatingQuotesState extends State<RotatingQuotes> {
  int currentIndex = 0;
  Timer? timer;

  @override
  void initState() {
    super.initState();

    timer = Timer.periodic(widget.duration, (Timer t) {
      setState(() {
        currentIndex = (currentIndex + 1) % widget.quotes.length;
      });
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 500),
      child: Text(
        widget.quotes[currentIndex],
        key: ValueKey(currentIndex),
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
      ),
    );
  }
}
