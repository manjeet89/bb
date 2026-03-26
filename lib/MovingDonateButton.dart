import 'package:bb/utils/app_colors.dart';
import 'package:flutter/material.dart';

class MovingDonateButton extends StatefulWidget {
  final VoidCallback onTap;

  const MovingDonateButton({super.key, required this.onTap});

  @override
  State<MovingDonateButton> createState() => _MovingDonateButtonState();
}

class _MovingDonateButtonState extends State<MovingDonateButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 2));

    _animation = Tween<double>(
      begin: -25,
      end: 25,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _controller.repeat(reverse: true); // 🔄 left-right animation
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.translate(offset: Offset(_animation.value, 0), child: child);
      },
      child: FloatingActionButton.extended(
        backgroundColor:AppColors.successGreen,
        onPressed: widget.onTap,
        icon:  Icon(Icons.favorite, color: AppColors.errorRed,
        
        ),
        label: const Text(
          "Donate Now",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
