import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../app/common/ui_helpers.dart';

const String defaultPic = 'assets/images/placeholder.png';

class ImageBuilder extends StatelessWidget {
  const ImageBuilder({
    super.key,
    required this.image,
    this.fit = BoxFit.cover,
    required this.height,
    this.width,
    this.circle = false,
    this.file = false,
    this.color,
    this.loading = false,
    this.errorUploading = false,
    this.onRetry,
  });
  final String image;
  final BoxFit fit;
  final double height;
  final double? width;
  final bool circle;
  final bool file;
  final Color? color;
  final bool loading;
  final bool errorUploading;
  final VoidCallback? onRetry;

  bool _isUrl(String? string) {
    if (string == null) return false;
    final RegExp urlExp = RegExp(
      r'^((ftp|http|https)://|(www))[a-z0-9-]+(.[a-z0-9-]+)+(:[0-9]{1,5})?(/.*)?$',
    );
    return urlExp.hasMatch(string);
  }

  bool _isSvg(String? string) {
    if (string == null || string.isEmpty) return false;
    if (string.contains('.svg')) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
            decoration: BoxDecoration(
              shape: circle ? BoxShape.circle : BoxShape.rectangle,
              borderRadius: circle
                  ? null
                  : const BorderRadius.all(Radius.circular(tinySize)),
              image: file && !_isUrl(image) && image != ''
                  ? DecorationImage(image: FileImage(File(image)), fit: fit)
                  : image != "" && _isUrl(image)
                      ? DecorationImage(image: NetworkImage(image), fit: fit)
                      : _isSvg(image)
                          ? null
                          : DecorationImage(
                              image: AssetImage(
                                (image != '') ? image : defaultPic,
                              ),
                              fit: fit,
                            ),
            ),
            height: height,
            width: width ?? height,
            child: CachedNetworkImage(
                imageUrl: image,
                height: height,
                width: width,
                fit: fit,
                imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        shape: circle ? BoxShape.circle : BoxShape.rectangle,
                        borderRadius: circle
                            ? null
                            : const BorderRadius.all(Radius.circular(tinySize)),
                        image: DecorationImage(image: imageProvider, fit: fit),
                      ),
                    ),
                placeholder: (context, url) =>
                    Stack(alignment: Alignment.center, children: [
                      Container(
                          decoration: BoxDecoration(
                              borderRadius: circle
                                  ? null
                                  : const BorderRadius.all(Radius.circular(10)),
                              shape:
                                  circle ? BoxShape.circle : BoxShape.rectangle,
                              image: DecorationImage(
                                  image: const AssetImage(defaultPic),
                                  fit: fit))),
                      _loadingBuilder()
                    ]),
                errorWidget: (context, url, error) => Container(
                    decoration: BoxDecoration(
                        borderRadius: circle
                            ? null
                            : const BorderRadius.all(Radius.circular(10)),
                        shape: circle ? BoxShape.circle : BoxShape.rectangle,
                        image: DecorationImage(
                            image: const AssetImage(defaultPic), fit: fit))))),
        if (loading) _loadingBuilder(),
        if (errorUploading) _retryBuilder(),
      ],
    );
  }

  _loadingBuilder() {
    return Container(
        height: height,
        width: width ?? height,
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius:
              circle ? null : const BorderRadius.all(Radius.circular(10)),
          shape: circle ? BoxShape.circle : BoxShape.rectangle,
        ),
        child: CircularProgressIndicator());
  }

  _retryBuilder() {
    return GestureDetector(
      onTap: onRetry,
      child: Container(
        height: height,
        width: width ?? height,
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(.75),
          borderRadius:
              circle ? null : const BorderRadius.all(Radius.circular(10)),
          shape: circle ? BoxShape.circle : BoxShape.rectangle,
        ),
        child: const Icon(Icons.refresh, color: Colors.red, size: 35),
      ),
    );
  }
}
