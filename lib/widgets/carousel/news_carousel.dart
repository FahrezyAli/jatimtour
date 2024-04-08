import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:jatimtour/constants.dart';
import 'package:jatimtour/widgets/buttons/circle_button.dart';

class NewsCarousel extends StatefulWidget {
  const NewsCarousel({super.key});

  @override
  State<NewsCarousel> createState() => _NewsCarouselState();
}

class _NewsCarouselState extends State<NewsCarousel> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CarouselSlider(
          items: [
            Image.asset('assets/images/banyuwangi.png'),
            Image.asset('assets/images/music_fest.png'),
            Image.asset('assets/images/kawah_ijen.png'),
            Image.asset('assets/images/sunrise.png'),
          ],
          options: CarouselOptions(
            aspectRatio: 1.98 / 1,
            viewportFraction: 1,
            autoPlay: true,
          ),
        ),
        Positioned(
          left: 0.0,
          right: 0.0,
          top: kIsWeb ? 500.0 : 125.0,
          child: Center(
            child: CircleButton(
              color: Colors.white,
              text: const Text(
                "Read More→",
                style: TextStyle(
                    fontFamily: "Inter",
                    fontSize: kIsWeb ? 15.0 : 11.0,
                    fontWeight: FontWeight.bold),
              ),
              onTap: () => Modular.to.navigate(articleRoute),
            ),
          ),
        ),
      ],
    );
  }
}
