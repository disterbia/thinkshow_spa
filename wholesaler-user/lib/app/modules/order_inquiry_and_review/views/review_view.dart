import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:wholesaler_user/app/constants/colors.dart';
import 'package:wholesaler_user/app/constants/styles.dart';
import 'package:wholesaler_user/app/models/product_model.dart';
import 'package:wholesaler_user/app/modules/order_inquiry_and_review/controllers/review_controller.dart';
import 'package:wholesaler_user/app/widgets/custom_appbar.dart';

class ReviewView extends GetView {
  ReviewController ctr = Get.put(ReviewController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          CustomAppbar(title: '리뷰', isBackEnable: true, hasHomeButton: false),
      body: DefaultTabController(
        length: 2,
        initialIndex: 0,
        child: Column(
          children: [
            // SizedBox(height: 20),
            TabBar(
              labelColor: Colors.black,
              indicatorColor: Colors.black,
              tabs: [
                Tab(text: '작성 가능한 리뷰'),
                Tab(text: '작성한 리뷰'),
              ],
            ),
            Container(
              height: context.height - 190,
              child: TabBarView(
                children: [
                  _alreadyWriteReview(),
                  _writeReview(),
                  // _paragraphContainer(terms),
                  // _paragraphContainer(privacy),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _alreadyWriteReview() {
    return Obx(
      () => SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: ctr.items.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    pruductWidget(ctr.items[index].products[0]),
                    Divider(
                      color: MyColors.grey1,
                      endIndent: 15,
                      indent: 15,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '최대 적립 300P',
                          ),
                          ElevatedButton(
                            onPressed: () {},
                            child: Text('리뷰작성'),
                          ),
                        ],
                      ),
                    ),
                    Divider(thickness: 6, color: MyColors.grey3),
                  ],
                );
              },
            )
          ],
        ),
      ),
    );
  }

  Widget _writeReview() {
    return SingleChildScrollView(
      child: Column(
        children: [],
      ),
    );
  }

  Widget pruductWidget(Product product) {
    return Container(
      padding: EdgeInsets.all(15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: CachedNetworkImage(
              imageUrl: product.imgUrl,
              width: 80,
              height: 80,
              fit: BoxFit.fill,
              errorWidget: (context, url, error) => Icon(Icons.error),
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
