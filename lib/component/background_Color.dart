import 'package:flutter/material.dart';
import 'package:pd_project/constants/AppColors.dart';

class Background_Color extends StatefulWidget {
  final Widget? childs;
  const Background_Color({Key? key, this.childs}) : super(key: key);

  @override
  State<Background_Color> createState() => _Background_ColorState();
}

class _Background_ColorState extends State<Background_Color> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height,
    decoration: BoxDecoration(
    gradient: LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [AppColors.blue, Colors.white]
    ),
    ),child: widget.childs,
    );
  }
}

class Background_Image extends StatefulWidget {
  final Widget? childs;
  final String? images;
  const Background_Image({Key? key, this.childs, this.images}) : super(key: key);

  @override
  State<Background_Image> createState() => _Background_ImageState();
}

class _Background_ImageState extends State<Background_Image> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
          image: DecorationImage(image:
          AssetImage(widget.images.toString()),fit: BoxFit.cover)),child: widget.childs,
    );
  }
}

