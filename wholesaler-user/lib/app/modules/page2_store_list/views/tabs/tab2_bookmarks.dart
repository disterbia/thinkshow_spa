import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wholesaler_partner/app/widgets/loading_widget.dart';
import 'package:wholesaler_user/app/constants/colors.dart';
import 'package:wholesaler_user/app/constants/styles.dart';
import 'package:wholesaler_user/app/models/store_model.dart';
import 'package:wholesaler_user/app/modules/main/controllers/user_main_controller.dart';
import 'package:wholesaler_user/app/modules/page2_store_detail/view/store_detail_view.dart';
import 'package:wholesaler_user/app/modules/page2_store_list/controllers/shopping_controller.dart';
import 'package:wholesaler_user/app/modules/page2_store_list/controllers/shopping_controller2.dart';
import 'package:wholesaler_user/app/modules/page2_store_list/views/tabs/tab1_ranking_view.dart';

class Tab2BookmarksView extends StatelessWidget {
  Page2StoreListController2 ctr = Get.put(Page2StoreListController2());

  String? prevPage = "bookmark";

  @override
  Widget build(BuildContext context) {
    ctr.getBookmarkedStoreData();
    return Obx(
          () => ctr.isLoading.value
          ? LoadingWidget()
          : ctr.stores.length == 0
          ? Container(
        child: Column(children: [
          SizedBox(
            height: 20,
          ),
          Image.asset("assets/images/mark.png", height: 70),
          SizedBox(
            height: 10,
          ),
          Text(
            "아직 즐겨찾기를 한 스토어가 없어요",
            style: TextStyle(color: Colors.grey),
          ),
          SizedBox(
            height: 5,
          ),
          Text("랭킹에서 즐겨찾기를 해보세요",
              style: TextStyle(color: Colors.grey)),
          SizedBox(
            height: 20,
          ),
          InkWell(
              onTap: () =>
                  Get.find<UserMainController>().changeTabIndex(1),
              child: Container(
                  width: 500 * 0.6,
                  color: MyColors.grey3,
                  height: 50,
                  child: Center(
                      child: Text("스토어 구경하러 가기",
                          style: TextStyle(color: Colors.grey)))))
        ]),
      )
          : Stack(
        children: [
          ListView.builder(
              itemCount: ctr.stores.length,
              controller: ctr.scrollController,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                print(ctr.stores[index].topImagePath);
                return _storeList(ctr.stores[index]);
              }),
          Positioned(
            bottom: 20,
            right: 20,
            child: SizedBox(
              width: 45,
              height: 45,
              child: FloatingActionButton(
                backgroundColor: Colors.white,
                child: Icon(Icons.arrow_upward_rounded),
                onPressed: () {
                  ctr.scrollController.jumpTo(0);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _storeList(Store store) {
    return GestureDetector(
      onTap: () {
        Get.to(
                () => StoreDetailView(
              storeId: store.id,
              prevPage: prevPage,
            ),
            preventDuplicates: true);
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
              Row(children: [
                _storeRankNum(store),
                SizedBox(width: 10),
                _storeImage(store),
                SizedBox(width: 10),
                _storeName(store),
                Spacer(),
                _starBuilder(store),
              ]),
              // Container(height: Get.height/6,
              //   child: ListView.separated(physics: NeverScrollableScrollPhysics(),
              //       itemCount: 4,
              //       scrollDirection: Axis.horizontal,
              //       separatorBuilder:(context, index) => SizedBox(width:2 ,) ,
              //       itemBuilder: (context, index) {
              //         if(store.topImagePath!.length<4){
              //           return Container();
              //         }
              //       return CachedNetworkImage(imageUrl: store.topImagePath![index],width: (500/4)-10,);
              //
              //     },),
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
    List<String> categoris =
    (store.categories!).map((item) => item as String).toList();
    String category = "";
    for (var i = 0; i < categoris.length; i++) {
      if (i == categoris.length - 1)
        category = category + categoris[i];
      else
        category = category + categoris[i] + "·";
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          store.name!,
          style: MyTextStyles.f16.copyWith(color: MyColors.black3),
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          categoris.isEmpty ? "스토어 정보 없음" : category,
          style: MyTextStyles.f12.copyWith(color: Colors.grey),
        ),
      ],
    );
  }

  Widget _starBuilder(Store store) {
    int favoriteCount = store.favoriteCount!.value;
    double temp = double.parse(favoriteCount.toString());
    String result = favoriteCount.toString();
    if (temp > 999) {
      result = (temp / 1000).toStringAsFixed(1) + "k";
    }
    return InkWell(
      onTap: () async {
        store.isBookmarked!.toggle();
        await ctr.starIconPressed(store);
        await ctr.getBookmarkedStoreData();
      },
      child: Obx(
            () => Column(
          children: [
            Icon(
              size: 30,
              store.isBookmarked!.isTrue ? Icons.star : Icons.star_border,
              color: MyColors.primary,
            ),
            Text(
              result,
              style: TextStyle(
                color: MyColors.grey4,
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
            )
          ],
        ),
      ),
    );
  }
}