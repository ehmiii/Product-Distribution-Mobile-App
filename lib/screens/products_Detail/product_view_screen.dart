import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pd_project/constants/AppColors.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class Product_View_Screen extends StatefulWidget {
  List? imageurl = [];
  Product_View_Screen({Key? key, this.imageurl}) : super(key: key);

  @override
  State<Product_View_Screen> createState() => _Product_View_ScreenState();
}

class _Product_View_ScreenState extends State<Product_View_Screen> {
  @override
  void initState() {
    super.initState();
  }

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
              imageProvider: NetworkImage(widget.imageurl![index]),
              initialScale: PhotoViewComputedScale.contained * 0.9,
            );
          },
          itemCount: widget.imageurl!.length,
        ));
    // return Scaffold(
    //   body: Center(child: Container(
    //     child: ListView.builder(
    //       scrollDirection: Axis.horizontal,
    //       itemCount: widget.imageurl!.length,
    //       itemBuilder: (context, index) {
    //         return Container(
    //           height: MediaQuery.of(context).size.height *.10,
    //           // width: MediaQuery.of(context).size.width *10,
    //           child: ClipRRect(
    //             child: CachedNetworkImage(imageBuilder: (context, imageProvider) {
    //               return Image.network(widget.imageurl![index],fit: BoxFit.contain,);
    //             },
    //               imageUrl: widget.imageurl![index],
    //               placeholder: (context, url){
    //               return  Center(child: Container(height:
    //               MediaQuery.of(context).size.height *.4,
    //                 child: Center(child: CircularProgressIndicator()),));
    //               },
    //               errorWidget: (context, url, error) => Icon(Icons.error_outline),
    //             ),
    //           ),
    //         );
    //
    //        // child:
    //
    //
    //       },
    //     ),
    //   ),),
    // );
  }
}
