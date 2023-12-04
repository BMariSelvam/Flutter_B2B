import 'package:b2b/Helper/colors.dart';
import 'package:b2b/Helper/fonts.dart';
import 'package:b2b/Model/ProductModel1.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Helper/assets.dart';

class HeroScreen extends StatelessWidget {
  final Product item;

  const HeroScreen({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.mainTheme,
        elevation: 0,
        iconTheme: const IconThemeData(color: MyColors.white),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text(
          'Product',
          style: TextStyle(
            fontFamily: MyFont.myFont,
            fontWeight: FontWeight.bold,
            color: MyColors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Hero(
          tag: item,
          child: BuildImage(),
        ),
      ),
    );
  }

  BuildImage() => AspectRatio(
        aspectRatio: 1,
        child: item.productImagePath != null
            ? ("${item.productImagePath}".isNotEmpty)
                ? Image.network('${item.productImagePath}', fit: BoxFit.fill)
                : Image.asset(Assets.noImage)
            : const Icon(Icons.error),
      );
}
