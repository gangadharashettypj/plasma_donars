/*
 * @Author GS
 */
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:plasma_donars/common_widgets/button_widget.dart';
import 'package:plasma_donars/common_widgets/image_widget.dart';
import 'package:plasma_donars/common_widgets/photo_viewer.dart';
import 'package:plasma_donars/navigator/navigator.dart';
import 'package:plasma_donars/resources/colors.dart';
import 'package:plasma_donars/utils/upload_util.dart';

class PictureUploaderWidget extends StatefulWidget {
  final Function(String) onPictureUploadComplete;
  String url;
  final double width, height;
  final String noImageText;
  final String imageText;
  final bool isSquare;
  final IconData placeholder;
  final BoxFit boxFit;
  final bool autoSize;
  PictureUploaderWidget({
    this.onPictureUploadComplete,
    this.url,
    this.noImageText = 'Add',
    this.imageText = 'Change',
    this.width = 170,
    this.height = 170,
    this.isSquare = false,
    this.placeholder,
    this.boxFit,
    this.autoSize = true,
  }) {
    if (url == '') {
      url = null;
    }
  }
  @override
  _PictureUploaderWidgetState createState() => _PictureUploaderWidgetState();
}

class _PictureUploaderWidgetState extends State<PictureUploaderWidget> {
  Image selectedImage;
  Uint8List selectedBytes;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Neumorphic(
          style: NeumorphicStyle(
            depth: -2,
            shadowDarkColor: MyColors.neuShadowDarkColor,
            shadowDarkColorEmboss: MyColors.neuShadowDarkColor,
            shadowLightColor: MyColors.neuShadowDarkColor,
            shadowLightColorEmboss: MyColors.neuShadowDarkColor,
            boxShape: widget.isSquare
                ? NeumorphicBoxShape.roundRect(BorderRadius.circular(4))
                : NeumorphicBoxShape.circle(),
          ),
          child: Container(
            margin: EdgeInsets.all(3),
            child: InkWell(
              borderRadius: BorderRadius.all(
                Radius.circular(
                  widget.isSquare ? 0 : 100,
                ),
              ),
              onTap: () async {
                if (widget.url == null && selectedImage == null) {
                  String url = await UploadUtil.uploadImage(
                    onImagePick: (image, bytes) {
                      setState(() {
                        selectedImage = image;
                        selectedBytes = bytes;
                      });
                    },
                    folderPath: 'feeds_image',
                  );
                  if (url == null) {
                    setState(() {
                      selectedImage = null;
                    });
                    return;
                  }
                  setState(() {
                    selectedImage = null;
                    widget.url = url;
                    widget.onPictureUploadComplete?.call(url);
                  });
                  return;
                }
                NavigationService.instance.push(context, PhotoViewer.route,
                    arguments: PhotoViewerArgs(
                        imageUrl: widget.url,
                        image: selectedImage,
                        imageBytes: selectedBytes,
                        onChangeClicked: () async {
                          String url = await UploadUtil.uploadImage(
                              onImagePick: (image, bytes) {
                            setState(() {
                              selectedImage = image;
                              selectedBytes = bytes;
                            });
                          });
                          setState(() {
                            selectedImage = null;
                            widget.url = url;
                            widget.onPictureUploadComplete?.call(url);
                          });
                        }));
              },
              child: ClipRRect(
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    widget.isSquare ? 0 : 100,
                  ),
                ),
                child: Stack(
                  children: [
                    getImageWidget(),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: ButtonWidget(
                        title: widget.url == null && selectedImage == null
                            ? widget.noImageText
                            : widget.imageText,
                        onPressed: () async {
                          String url = await UploadUtil.uploadImage(
                              onImagePick: (image, bytes) {
                            setState(() {
                              selectedImage = image;
                              selectedBytes = bytes;
                            });
                          });
                          setState(() {
                            selectedImage = null;
                            widget.url = url;
                            widget.onPictureUploadComplete?.call(url);
                          });
                        },
                        depth: 3,
                        fontSize: 20,
                        buttonBoxShape: NeumorphicBoxShape.rect(),
                        color: MyColors.textColor,
                      ),
                    ),
                    if (!widget.isSquare && selectedImage != null)
                      Center(
                        child: Container(
                          width: widget.width + 40,
                          height: widget.height + 40,
                          child: CircularProgressIndicator(),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  dynamic getImageWidget() {
    if (selectedImage != null) {
      return Container(
        child: Column(
          children: [
            Container(
              width: widget.autoSize == true ? null : widget.width,
              height: widget.autoSize == true ? null : widget.height,
              child: selectedImage,
            ),
            if (widget.isSquare) LinearProgressIndicator(),
          ],
        ),
      );
    } else if (widget.url != null) {
      return ImageWidget(
        imageLocation: widget.url,
        boxFit: widget.boxFit ?? BoxFit.fill,
        width: widget.autoSize == true ? null : widget.width,
        height: widget.autoSize == true ? null : widget.height,
      );
    } else {
      return Container(
        width: widget.width,
        height: widget.height,
        child: Center(
          child: NeumorphicIcon(
            widget.placeholder ?? Icons.image,
            size: 80,
            style: NeumorphicStyle(
              depth: 3,
              color: MyColors.textColor,
            ),
          ),
        ),
      );
    }
  }
}
