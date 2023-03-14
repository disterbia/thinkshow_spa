import 'package:cached_network_image/cached_network_image.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:wholesaler_user/app/Constants/colors.dart';
import 'package:wholesaler_user/app/Constants/styles.dart';
import 'package:wholesaler_user/app/models/product_model.dart';
import 'package:wholesaler_user/app/utils/utils.dart';

class ProductInquiryView extends StatelessWidget {
  Product product;
  ProductInquiryView({required this.product});

  @override
  Widget build(BuildContext context) {
    print(product.images![0]);

    return Container(
      padding: EdgeInsets.all(15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: ExtendedImage.network(clearMemoryCacheWhenDispose:true,enableMemoryCache:false,enableLoadState: false,cacheWidth: 1024,cacheHeight: 1365,
           product.images![0],
              width: 80,
              height: 80,
              fit: BoxFit.fill,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Container(
              height: 80,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    child: Text(
                      product.title,
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                      style: MyTextStyles.f16.copyWith(
                          color: MyColors.black3, fontWeight: FontWeight.w400),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),

                  // Flexible(
                  //   child: Text(
                  //     '04 여기에 어떤 내용이 들어가야할지 모르겠어요 걍 키워드 넣으면 되는건가요??? 하지만 우리는 제품한테 따로 키워드를 붙이지 않았는걸요;;; / 20mm / (7,000원) / BEST / BEST',
                  //     overflow: TextOverflow.ellipsis,
                  //     style:
                  //         MyTextStyles.f12.copyWith(color: MyColors.grey10),
                  //     maxLines: 4,
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
          SizedBox(
            width: 15,
          ),
          Text(
            Utils.numberFormat(number: product.price!, suffix: '원'),
            style: MyTextStyles.f16
                .copyWith(color: MyColors.black3, fontWeight: FontWeight.bold),
          ),
          // showArrowIcon
          //     ? Image.asset(
          //         'assets/icons/ico_arrow03.png',
          //         height: 18,
          //       )
          //     : SizedBox.shrink()
        ],
      ),
    );
  }
}
