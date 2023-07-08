import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

import '../constants/AppColors.dart';

class ProductDetailImageViewScreen extends StatefulWidget {
  List imageurl = [];
  ProductDetailImageViewScreen({Key? key, required this.imageurl})
      : super(key: key);

  @override
  State<ProductDetailImageViewScreen> createState() =>
      _ProductDetailImageViewScreenState();
}

class _ProductDetailImageViewScreenState
    extends State<ProductDetailImageViewScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height * .10,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.blue,
        ),
        child: PhotoViewGallery.builder(
          scrollDirection: Axis.horizontal,
          builder: (BuildContext context, int index) {
            return PhotoViewGalleryPageOptions(
              imageProvider: NetworkImage(widget.imageurl[index]),
              initialScale: PhotoViewComputedScale.contained * 0.9,
            );
          },
          itemCount: widget.imageurl.length,
        ));
  }
}
