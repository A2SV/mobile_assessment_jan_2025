import 'package:flutter/material.dart';
import 'package:mobile_assessment_jan_2025/app/common/app_text_style.dart';
import 'package:mobile_assessment_jan_2025/app/common/ui_helpers.dart';
import 'package:mobile_assessment_jan_2025/models/product.dart';
import 'package:mobile_assessment_jan_2025/widgets/image_builder.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class CustomeListWidget extends StatelessWidget {
  const CustomeListWidget({super.key, required this.product, this.onTap});
  final Product product;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onTap,
        child: Card(
            elevation: 0,
            child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  boxShadow: [
                    BoxShadow(
                        // ignore: deprecated_member_use
                        color: Colors.black.withOpacity(.05),
                        blurRadius: 1.0,
                        offset: const Offset(1, 1),
                        spreadRadius: 1)
                  ],
                ),
                child: Row(children: [
                  ImageBuilder(
                      image: product.image, height: screenWidth(context) * .25),
                  horizontalSpaceSmall,
                  Expanded(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                        Text(product.title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: bold),
                        Text(product.category,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: light.copyWith(color: Colors.grey)),
                        verticalSpaceTiny,
                        Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              RatingBarIndicator(
                                  rating: 3,
                                  itemSize: 18,
                                  itemCount: 1,
                                  itemPadding:
                                      const EdgeInsets.only(right: 0.0),
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                        onTap: () {},
                                        child: const Icon(Icons.star,
                                            color: Colors.amber));
                                  }),
                              Text(
                                product.rating.rate.toStringAsFixed(1),
                                style: bold.copyWith(color: Colors.black38),
                              ),
                              Text(
                                '(${product.rating.count} reviews)',
                                style: regular.copyWith(
                                  color: Colors.grey,
                                ),
                              )
                            ]),
                        verticalSpaceTiny,
                        Text(
                          '\$${product.price}',
                          style: extraBold,
                        )
                      ])),
                  horizontalSpaceMiddle
                ]))));
  }
}
