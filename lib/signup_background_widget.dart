import 'package:flutter/material.dart';
import 'dart:ui';

class SignUpBackgroundWidget extends StatelessWidget {
  final Widget? child;
  const SignUpBackgroundWidget({Key? key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Gradient background
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF36399D),
                Color(0xFF3C4BAE),
              ],
            ),
          ),
        ),
        // 1. Large circle top right (#48319B, 60% opacity) - copied exactly from login
        Positioned(
          top: -120,
          right: -70,
          child: Container(
            width: 300,
            height: 300,
            decoration: BoxDecoration(
              color: const Color(0xFF48319B),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.12),
                  blurRadius: 28,
                  spreadRadius: 2,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
          ),
        ),
        // 2. Full circle on left middle (#2D4BAB, 70% opacity) - copied exactly from login
        Positioned(
          top: 260,
          left: -80,
          child: Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF48319B), // بنفسجي غامق فوق (مثل الخلفية الرئيسية)
                  Color(0xFF3C4BAE), // أزرق تحت (مثل الخلفية)
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.10),
                  blurRadius: 22,
                  spreadRadius: 1.5,
                  offset: const Offset(0, 7),
                ),
              ],
            ),
          ),
        ),
        // 3. Large circle bottom right (#496AC4) with subtle white border - copied exactly from login
        Positioned(
          bottom: -60,
          right: -80,
          child: Container(
            width: 290,
            height: 290,
            decoration: BoxDecoration(
              color: const Color(0xFF496AC4),
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white.withOpacity(0.7), width: 0),
            ),
          ),
        ),
        // Child widget (form, etc.)
        if (child != null)
          Positioned.fill(child: child!),
      ],
    );
  }
}
