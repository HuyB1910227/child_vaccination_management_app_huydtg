import 'package:flutter/material.dart';

class AvatarImage extends StatelessWidget {
  final dynamic imageProvider;

  final double imageRadius;

  const AvatarImage({
    Key? key,
    this.imageProvider,
    this.imageRadius = 90.0,
  }): super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: const Color.fromARGB(255, 255, 187, 207),
      radius: imageRadius,
      child: CircleAvatar(
        radius: imageRadius - 5,
        backgroundImage: imageProvider,
      ),
    );
  }
}
