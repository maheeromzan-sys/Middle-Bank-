import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../state.dart';
import '../theme.dart';
import '../widgets.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _c = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1400),
  )..repeat();

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 2800), () {
      if (mounted) Navigator.of(context).pushReplacementNamed('/welcome');
    });
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(gradient: Brand.navyGradient),
        child: SafeArea(
          child: Column(
            children: [
              const Spacer(flex: 3),
              TweenAnimationBuilder<double>(
                tween: Tween(begin: 0.6, end: 1),
                duration: const Duration(milliseconds: 900),
                curve: Curves.easeOutBack,
                builder: (_, v, child) =>
                    Opacity(opacity: v.clamp(0, 1), child: Transform.scale(scale: v, child: child)),
                child: const ShieldLogo(size: 110, onDark: true),
              ),
              const SizedBox(height: 22),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 32),
                child: BrandTitle(fontSize: 38, onDark: true),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Text(
                  context.t('slogan'),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const Spacer(flex: 2),
              // Loading animation: three bouncing dots.
              AnimatedBuilder(
                animation: _c,
                builder: (_, __) => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(3, (i) {
                    final phase = (_c.value + i * 0.18) % 1.0;
                    final lift = math.sin(phase * math.pi) * 12;
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 6),
                      width: 12,
                      height: 12,
                      transform: Matrix4.translationValues(0, -lift, 0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: i == 1 ? const Color(0xFF4FE3A8) : Colors.white,
                      ),
                    );
                  }),
                ),
              ),
              const SizedBox(height: 14),
              Text(
                context.t('loading'),
                style: TextStyle(color: Colors.white.withAlpha(200), fontSize: 13),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: 18),
                child: Text(
                  context.t('demo_banner'),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white.withAlpha(150), fontSize: 11),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
