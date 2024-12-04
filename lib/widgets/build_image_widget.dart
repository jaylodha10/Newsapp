import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class BuildImage {
  String? image;
  String? name;
  int? index;
  BuildImage({this.image, this.index, this.name});

  Widget buildImage(
      BuildContext context, String image, int index, String name) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 05),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: CachedNetworkImage(
              height: 250,
              fit: BoxFit.cover,
              width: MediaQuery.of(context).size.width,
              imageUrl: image,
            ),
          ),
          Container(
            height: 250,
            padding: const EdgeInsets.only(left: 10),
            margin: const EdgeInsets.only(top: 170),
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10)),
              color: Colors.black45,
            ),
            child: Center(
              child: Text(
                name,
                maxLines: 2,
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
            ),
          )
        ],
      ),
    );
  }
}
