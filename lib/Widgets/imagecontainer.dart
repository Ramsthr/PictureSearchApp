import 'package:animalsearchapp/Screens/showscreen.dart';
import 'package:flutter/material.dart';
import 'package:pexels_api/pexels_api.dart';

class ImageContainer extends StatelessWidget {
  final PexelsPhoto image;
  const ImageContainer({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ShowScreen(
              image: image,
            ),
          ),
        );
      },
      child: SizedBox(
        width: width * 0.07,
        height: height * 0.07,
        child: Image.network(image.get(ImageFormats.small)!),
      ),
    );
  }
}
