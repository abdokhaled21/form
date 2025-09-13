import 'package:flutter/material.dart';
import 'dart:ui';

class BackgroundWidget extends StatelessWidget {
  final Widget? child;
  const BackgroundWidget({Key? key, this.child}) : super(key: key);

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
        // 1. Large circle top right (#48319B, 60% opacity) - أكبر + شادو على البوردر
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
        // 2. Small transparent circle top right (glass effect)
        Positioned(
          top: 110,
          right: 80,
          child: Container(
            width: 98,
            height: 98,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.03),
                  blurRadius: 10,
                  spreadRadius: 1,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: ClipOval(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
                child: Container(
                  width: 90,
                  height: 90,
                  decoration: const BoxDecoration(
                    color: Colors.transparent,
                    shape: BoxShape.circle,
                  ),
                  child: Container(
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.09),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        // 3. Full circle on left middle (#2D4BAB, 70% opacity) يظهر منها 2/3 فقط
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
        // 4. Background rounded rectangle (full width, gradient from left, fade bottom)
        Positioned(
          bottom: -70,
          left: -20,
          right: -20,
          child: ShaderMask(
            shaderCallback: (Rect bounds) {
              return LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.white,
                  Colors.white.withAlpha(0),
                ],
                stops: [0.7, 1.0],
              ).createShader(bounds);
            },
            blendMode: BlendMode.dstIn,
            child: Container(
              height: 350,
              margin: const EdgeInsets.symmetric(horizontal: 18),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(90)),
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Color(0xFF496AC4),
                    Color(0xFF3C4BAE),
                  ],
                ),
              ),
            ),
          ),
        ),
        // 5. Small transparent circle on background rectangle
        Positioned(
          bottom: 200,
          left: 60,
          child: Container(
            width: 110,
            height: 110,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.07),
              shape: BoxShape.circle,
            ),
          ),
        ),
        // 6. Large circle bottom right (#496AC4) with subtle white border (أكبر وبوردر أرفع)
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
