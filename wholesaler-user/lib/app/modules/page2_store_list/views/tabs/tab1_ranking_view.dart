import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wholesaler_partner/app/widgets/loading_widget.dart';
import 'package:wholesaler_user/app/constants/colors.dart';
import 'package:wholesaler_user/app/constants/styles.dart';
import 'package:wholesaler_user/app/models/store_model.dart';
import 'package:wholesaler_user/app/modules/page2_store_detail/view/store_detail_view.dart';
import 'package:wholesaler_user/app/modules/page2_store_list/controllers/shopping_controller.dart';

class Tab1RankingView extends StatelessWidget {
  Page2StoreListController ctr = Get.put(Page2StoreListController());
  String? prevPage = "rank";

  @override
  Widget build(BuildContext context) {
    ctr.getRankedStoreData();
    return Obx(
      () => ctr.isLoading.value
          ? LoadingWidget()
          : ListView.builder(
              itemCount: ctr.stores.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return _storeList(ctr.stores[index]);
              }),
    );
  }

  Widget _storeList(Store store) {
    return GestureDetector(
      onTap: () {
        Get.to(() => StoreDetailView(
              storeId: store.id,
              prevPage: prevPage,
            ));
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: MyColors.grey6),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10,),
              Row(children: [
                _storeRankNum(store),
                SizedBox(width: 10),
                _storeImage(store),
                SizedBox(width: 10),
                _storeName(store),
                Spacer(),
                _starBuilder(store),
              ]),
              SizedBox(height: 10,),
              Builder(
                builder: (context) {
                  if(store.topImagePath!.length<4) return Container();
                  return Row(children: [
                    Expanded(child: CachedNetworkImage(fit: BoxFit.fitHeight, imageUrl: store.topImagePath![0],height: 100,)),
                    SizedBox(width: 2),
                    Expanded(child: CachedNetworkImage(fit: BoxFit.fitHeight, imageUrl: store.topImagePath![1],height: 100,)),
                    SizedBox(width: 2),
                    Expanded(child: CachedNetworkImage(fit: BoxFit.fitHeight, imageUrl: store.topImagePath![2],height: 100,)),
                    SizedBox(width: 2),
                    Expanded(child: CachedNetworkImage(fit: BoxFit.fitHeight, imageUrl: store.topImagePath![3],height: 100,)),
                  ],);
                }
              ),
              SizedBox(height: 5,)
              // Container(
              //   height: Get.height/6,
              //   child: ListView.separated(
              //     physics: NeverScrollableScrollPhysics(),
              //       scrollDirection: Axis.horizontal,
              //       itemBuilder: (context, index) {
              //         return SizedBox(width: Get.width*0.2,
              //           child: CachedNetworkImage(fit: BoxFit.fitHeight,
              //               imageUrl: store.topImagePath![index]),
              //         );
              //       },
              //       separatorBuilder: (context, index) => SizedBox(
              //             width: 2,
              //           ),
              //       itemCount: store.topImagePath!.length),
              // )
            ],
          ),
        ),
      ),
    );
  }

  Widget _storeRankNum(Store store) {
    return Text(
      store.rank.toString(),
      style: MyTextStyles.f16.copyWith(color: MyColors.grey8),
    );
  }

  Widget _storeImage(Store store) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(50),
      child: store.imgUrl != null
          ? CachedNetworkImage(
              imageUrl: store.imgUrl!.value,
              width: 50,
              height: 50,
              fit: BoxFit.cover,
              // placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
            )
          : Image.asset(
              'assets/icons/ic_store.png',
              width: 50,
            ),
    );
  }

  Widget _storeName(Store store) {
    return Text(
      store.name!,
      style: MyTextStyles.f16.copyWith(color: MyColors.black3),
    );
  }

  Widget _starBuilder(Store store) {
    int favoriteCount = store.favoriteCount!.value;
    double temp = double.parse(favoriteCount.toString());
    String result=favoriteCount.toString();
    if(temp>999){
      result= (temp / 1000).toStringAsFixed(1) +"k";
    }
    return InkWell(
      onTap: () {
        store.isBookmarked!.toggle();
        ctr.starIconPressed(store);
      },
      child: Obx(
        () => Column(
          children: [
            Icon(
              size: 25,
              store.isBookmarked!.isTrue ? Icons.star : Icons.star_border,
              color: MyColors.primary,
            ),
            Text(result,
              style: TextStyle(color: MyColors.grey4,fontSize: 12,fontWeight: FontWeight.w700, ),)
          ],
        ),
      ),
    );
  }
}
