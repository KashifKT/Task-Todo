import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class AutoImageSlider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CarouselSlider(
        options: CarouselOptions(
          height: 250,
          autoPlay: true,                  // 🔥 Auto slide ON
          autoPlayInterval: Duration(seconds: 3), // Slide every 3 seconds
          autoPlayAnimationDuration: Duration(milliseconds: 800),
          enlargeCenterPage: true,
          viewportFraction: 1.0,
        ),

        items: [
          "assets/icon/app_icon.png",
          "assets/icon/2.png",
          "assets/icon/3.png",
        ].map((imagePath) {
          return Image.asset(
            imagePath,
            fit: BoxFit.cover,
            width: double.infinity,
          );
        }).toList(),
      ),
    );
  }
}
