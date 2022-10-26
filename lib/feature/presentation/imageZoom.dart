import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import 'package:sitaris/utils/utils.dart';

class ImageZoom extends StatelessWidget {
  const ImageZoom({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    String? imagePath = Get.arguments['imagePath'];
    String heroName = Get.arguments['heroName'];
    Uint8List? bytes = Get.arguments['bytes'];
    // bool file = Get.arguments['isFile'] ?? false;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Hero(
                tag: heroName,
                child: Container(
                  height: Utils.dynamicHeight(
                      100), //MediaQuery.of(context).size.height,
                  width: Utils.dynamicWidth(
                    100,
                  ), // MediaQuery.of(context).size.width,
                  child: (bytes != null)
                      ? PhotoView(
                          minScale: PhotoViewComputedScale.contained * 0.8,
                          maxScale: PhotoViewComputedScale.covered * 2,
                          imageProvider: MemoryImage(bytes))
                      : PhotoView(
                          minScale: PhotoViewComputedScale.contained * 0.8,
                          maxScale: PhotoViewComputedScale.covered * 2,
                          imageProvider:
                              CachedNetworkImageProvider(imagePath!)),
                )),
            Positioned(
              left: 25,
              top: 25,
              child: InkWell(
                onTap: () => Utils.navigateBack(context: context),
                child: Container(
                  width: 25.0,
                  height: 25.0,
                  decoration: new BoxDecoration(
                    color: Colors.black,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Icon(
                      Icons.close,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
