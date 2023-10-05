import 'package:flutter/material.dart';
import 'package:pexels_api/pexels_api.dart';

class ShowScreen extends StatelessWidget {
  PexelsPhoto image;
  ShowScreen({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    String photographer = image.photographer!;
    String photographerUrl = image.photographerURL!;
    String url = image.url!;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black12,
        title: const Text("Animal Search App"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.network(image.get(ImageFormats.original)!),
          Text(photographer),
          Text(photographerUrl),
          Text(url),
        ],
      ),
    );
  }
}
