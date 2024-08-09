import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class CarouselWithIndicator extends StatefulWidget {
  final List<String> imgList;

  const CarouselWithIndicator({super.key, required this.imgList});

  @override
  State<CarouselWithIndicator> createState() => _CarouselWithIndicatorState();
}

class _CarouselWithIndicatorState extends State<CarouselWithIndicator> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          items: widget.imgList.map((item) {
            return SizedBox(
              width: MediaQuery.of(context).size.width,
              child: CachedNetworkImage(
                imageUrl: item,
                fit: BoxFit.cover,
                width: double.infinity,
                // placeholder: (context, url) =>
                //     const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            );
          }).toList(),
          options: CarouselOptions(
            autoPlay: true,
            enlargeCenterPage: false,
            aspectRatio: 16 / 9,
            viewportFraction: 1.0,
            onPageChanged: (index, reason) {
              setState(() {
                _current = index;
              });
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: widget.imgList.map((url) {
            int index = widget.imgList.indexOf(url);
            return Container(
              width: 8.0,
              height: 8.0,
              margin:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _current == index
                    ? const Color.fromARGB(228, 149, 147, 147)
                    : const Color.fromRGBO(0, 0, 0, 0.4),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}

class CarouselExample extends StatelessWidget {
  final List<String> imgList = [
    'https://canvas.tamashaweb.com/jazzlive/uploads/slider/TMSH-1719651399431.webp?id=18',
    'https://canvas.tamashaweb.com/jazzlive/uploads/slider/TMSH-1719687382438.webp?id=76',
    'https://canvas.tamashaweb.com/jazzlive/uploads/slider/1712646446.webp?id=63',
    'https://canvas.tamashaweb.com/jazzlive/uploads/slider/1687867558.webp?id=41',
    'https://canvas.tamashaweb.com/jazzlive/uploads/slider/TMSH-1718963507632.webp?id=98',
    'https://canvas.tamashaweb.com/jazzlive/uploads/slider/TMSH-1718961584917.webp?id=99',
  ];

  CarouselExample({super.key});

  @override
  Widget build(BuildContext context) {
    return CarouselWithIndicator(imgList: imgList);
  }
}
