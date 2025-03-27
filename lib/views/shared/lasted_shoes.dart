import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class LastestShoes extends StatelessWidget {
  const LastestShoes({
    super.key,
    required this.imageUrl,
    this.onTap,
  });

  final String imageUrl;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
            height: MediaQuery.of(context).size.height * 0.15,
            decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.all(Radius.circular(16)),
                boxShadow: [
                  BoxShadow(
                      color: Colors.white,
                      spreadRadius: 1,
                      blurRadius: 0.8,
                      offset: Offset(0, 1))
                ]),
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              fit: BoxFit.contain,
            )),
      ),
    );
  }
}
