import 'package:flutter/material.dart';

class ReusbaleRow extends StatelessWidget {
  final String value, value1;
  final IconData? iconData;
  // IconData? iconData1;
  final VoidCallback? onPress;
  ReusbaleRow(
      {required this.value,
      this.iconData,
      // this.iconData1,
      this.onPress,
      required this.value1});

  @override
  Widget build(BuildContext context) {
    // return ListTile(
    //   title: Text(
    //     value,
    //     style: TextStyle(fontWeight: FontWeight.bold),
    //     maxLines: 1,
    //     overflow: TextOverflow.ellipsis,
    //   ),
    //   leading: Icon(iconData),
    //   trailing: Text(value1, style: TextStyle(fontSize: 16)),
    // );
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "$value:",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 20),
              Text(
                value1,
                style: TextStyle(
                  fontSize: 15,
                  // fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
