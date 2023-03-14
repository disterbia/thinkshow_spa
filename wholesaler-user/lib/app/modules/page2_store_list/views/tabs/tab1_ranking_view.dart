import 'package:cached_network_image/cached_network_image.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:wholesaler_partner/app/widgets/loading_widget.dart';
import 'package:wholesaler_user/app/Constants/variables.dart';
import 'package:wholesaler_user/app/constants/colors.dart';
import 'package:wholesaler_user/app/constants/styles.dart';
import 'package:wholesaler_user/app/models/store_model.dart';
import 'package:wholesaler_user/app/modules/page2_store_detail/view/store_detail_view.dart';
import 'package:wholesaler_user/app/modules/page2_store_list/controllers/shopping_controller.dart';

class Tab1RankingView extends StatelessWidget {
  Page2StoreListController ctr = Get.put(Page2StoreListController());
  String? prevPage = "rank";

  List<DropdownMenuItem<String>> itemsBuilder(List<String> itemStrings) {
    return itemStrings.map<DropdownMenuItem<String>>((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Text(value),
      );
    }).toList();
  }
  @override
  Widget build(BuildContext context) {
    if (ctr.selected == 0) ctr.getMostStoreData();
    if (ctr.selected == 1) ctr.getRankedStoreData();
    return Obx(
      () => ctr.isLoading.value
          ? LoadingWidget()
          : Stack(
              children: [
                SingleChildScrollView(
                  controller: ctr.scrollController,
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10.0, top: 10),
                          child:   DropdownButton(
                            hint: Text(ctr.dropDownItem[ctr.selected.value]),
                            items: itemsBuilder(ctr.dropDownItem),
                            onChanged: (String? newValue) {
                              ctr.selected.value =
                                  ctr.dropDownItem.indexOf(newValue!);
                              if (ctr.selected == 0) ctr.getMostStoreData();
                              if (ctr.selected == 1) ctr.getRankedStoreData();

                            },
                          ),
                        ),
                      ),
                      ListView.builder(
                          itemCount: ctr.stores.length,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return _storeList(ctr.stores[index], context);
                          }),
                    ],
                  ),
                ),
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

  Widget _storeList(Store store, BuildContext context) {
    return InkWell(
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
              SizedBox(
                height: 10,
              ),

              Row(children: [
                _storeRankNum(store),
                SizedBox(width: 10),
                _storeImage(store),
                SizedBox(width: 10),
                _storeName(store),
                Spacer(),
                _starBuilder(store, context),
              ]),
              SizedBox(
                height: 10,
              ),
              Builder(builder: (context) {
                if (store.topImagePath!.length < 4) return Container();
                return Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(20)),
                  child: Row(
                    children: [
                      Expanded(
                          child: ClipRRect(
                        child: ExtendedImage.network( store.topImagePath![0],
                          clearMemoryCacheWhenDispose:true,enableMemoryCache:false,enableLoadState: false,
                          //cacheHeight:100 ,//cacheWidth: (500/4).ceil(),
                          fit: BoxFit.fitHeight,

                          height: GetPlatform.isMobile?100:150,
                        ),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(4),
                            bottomLeft: Radius.circular(4)),
                      )),
                      SizedBox(width: 2),
                      Expanded(
                          child: ExtendedImage.network( store.topImagePath![1],
                            clearMemoryCacheWhenDispose:true,enableMemoryCache:false,enableLoadState: false,
                            //cacheHeight:100 ,//cacheWidth: (500/4).ceil(),
                            fit: BoxFit.fitHeight,
                            height: GetPlatform.isMobile?100:150,
                      )),
                      SizedBox(width: 2),
                      Expanded(
                          child: ExtendedImage.network(store.topImagePath![2],
                            clearMemoryCacheWhenDispose:true,enableMemoryCache:false,enableLoadState: false,
                            //cacheHeight:100 ,//cacheWidth: (500/4).ceil(),
                            fit: BoxFit.fitHeight,

                            height: GetPlatform.isMobile?100:150,
                      )),
                      SizedBox(width: 2),
                      Expanded(
                          child: ClipRRect(
                              child: ExtendedImage.network(
                                store.topImagePath![3],
                                clearMemoryCacheWhenDispose:true,enableMemoryCache:false,enableLoadState: false,
                                //cacheHeight:100 ,//cacheWidth: (500/4).ceil(),
                                fit: BoxFit.fitHeight,
                                height: GetPlatform.isMobile?100:150,
                              ),
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(4),
                                  bottomRight: Radius.circular(4)))),
                    ],
                  ),
                );
              }),
              SizedBox(
                height: 5,
              )
              // Container(
              //   height: Get.height/6,
              //   child: ListView.separated(
              //     physics: NeverScrollableScrollPhysics(),
              //       scrollDirection: Axis.horizontal,
              //       itemBuilder: (context, index) {
              //         return SizedBox(width: GetPlatform.isMobile?Get.width:500*0.2,
              //           child: ExtendedImage.network(clearMemoryCacheWhenDispose:true,enableMemoryCache:false,enableLoadState: false,cacheWidth: 1024,cacheHeight: 1365,fit: BoxFit.fitHeight,
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
          ? ExtendedImage.network(clearMemoryCacheWhenDispose:true,enableMemoryCache:false,enableLoadState: false,cacheWidth: 1024,cacheHeight: 1365,
          store.imgUrl!.value,
              width: 50,
              height: 50,
              fit: BoxFit.cover,
              // placeholder: (context, url) => CircularProgressIndicator(),

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
          style: MyTextStyles.f16_bold.copyWith(color: Colors.black),
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

  // void changeSystemColor(Color color){
  //   SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
  //     systemNavigationBarColor: color,
  //     systemNavigationBarIconBrightness: Brightness.dark,
  //   ));
  // }

  void showModal(Store store, BuildContext context) {
    // changeSystemColor(Colors.pink);
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        context: context,
        builder: (context) {
          return Container(
            height: 300,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
            ),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: Container(
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 8, bottom: 20),
                      width: 60,
                      height: 5,
                      decoration: BoxDecoration(
                        color: MyColors.grey3,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    Text(
                      "${store.name}와 비슷한 스토어",
                      style:
                          MyTextStyles.f16_bold.copyWith(color: Colors.black),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 180,
                      child: Row(
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                Get.to(
                                    () => StoreDetailView(
                                          storeId: ctr.sameId[0],
                                          prevPage: prevPage,
                                        ),
                                    preventDuplicates: true);
                              },
                              child: Container(
                                child: Stack(
                                  children: [
                                    Container(
                                        child: Center(
                                          child: ClipRRect(
                                            child: ctr.mainImage[0] == ""
                                                ? Image.asset(
                                                    "assets/icons/ic_store.png",
                                                  )
                                                : ExtendedImage.network(clearMemoryCacheWhenDispose:true,enableMemoryCache:false,enableLoadState: false,cacheWidth: 1024,cacheHeight: 1365,
                                                   ctr.mainImage[0],
                                              width: GetPlatform.isMobile?(Get.width/2)-20:(500/2)-20,
                                                    fit: BoxFit.fill,
                                                  ),
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(10.0),
                                                topRight:
                                                    Radius.circular(10.0)),
                                          ),
                                        ),
                                        height: 130),
                                    Align(
                                        alignment: Alignment.bottomCenter,
                                        child: Column(mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            Container(
                                              child: Center(
                                                  child: CircleAvatar(
                                                child: Padding(
                                                  padding: const EdgeInsets.all(2),
                                                  child: ClipOval(
                                                    child: ctr.subImage[0] == ""
                                                        ? Image.asset(
                                                            "assets/icons/ic_store.png",
                                                          )
                                                        : ExtendedImage.network(clearMemoryCacheWhenDispose:true,enableMemoryCache:false,enableLoadState: false,cacheWidth: 1024,cacheHeight: 1365,

                                                                ctr.subImage[0],
                                                          ),
                                                  ),
                                                ),
                                                radius: 50,
                                                backgroundColor: Colors.white,
                                              )),
                                              width: 50,
                                              height: 50,
                                            ),
                                            Text(ctr.storeName[0]!,style: MyTextStyles.f18_bold,)
                                          ],
                                        ))
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                Get.to(
                                    () => StoreDetailView(
                                          storeId: ctr.sameId[1],
                                          prevPage: prevPage,
                                        ),
                                    preventDuplicates: true);
                              },
                              child: Container(
                                child: Stack(
                                  children: [
                                    Container(
                                        child: Center(
                                          child: ClipRRect(
                                            child: ctr.mainImage[1] == ""
                                                ? Image.asset(
                                                    "assets/icons/ic_store.png",
                                                  )
                                                : ExtendedImage.network(clearMemoryCacheWhenDispose:true,enableMemoryCache:false,enableLoadState: false,cacheWidth: 1024,cacheHeight: 1365,
                                                     ctr.mainImage[1],
                                              width: GetPlatform.isMobile?(Get.width/2)-20:(500/2)-20,
                                                    fit: BoxFit.fill,
                                                  ),
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(10.0),
                                                topRight:
                                                    Radius.circular(10.0)),
                                          ),
                                        ),
                                        height: 130),
                                    Align(
                                        alignment: Alignment.bottomCenter,
                                        child: Column(mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            Container(
                                              child: Center(
                                                  child: CircleAvatar(
                                                child: Padding(
                                                  padding: const EdgeInsets.all(2),
                                                  child: ctr.subImage[1] == ""
                                                      ? Image.asset(
                                                          "assets/icons/ic_store.png",
                                                        )
                                                      : ClipOval(
                                                          child: ExtendedImage.network(clearMemoryCacheWhenDispose:true,enableMemoryCache:false,enableLoadState: false,cacheWidth: 1024,cacheHeight: 1365,

                                                                ctr.subImage[1],
                                                          ),
                                                        ),
                                                ),
                                                radius: 50,
                                                backgroundColor: Colors.white,
                                              )),
                                              width: 50,
                                              height: 50,
                                            ),
                                            Text(ctr.storeName[1]!,style: MyTextStyles.f18_bold,)
                                          ],
                                        ))
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                    )
                    // Container(
                    //   padding: EdgeInsets.all(8),
                    //   height: 200,color: Colors.white,
                    //   alignment: Alignment.center,
                    //   child: Text('Modal'),
                    // ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  Widget _starBuilder(Store store, BuildContext context) {
    double temp = double.parse(store.favoriteCount!.value.toString());
    RxString result = store.favoriteCount!.value.toString().obs;
    if (temp >= 1000) {
      result.value = (temp / 1000).toStringAsFixed(1) + "k";
    }
    return InkWell(
      onTap: () async {
        store.isBookmarked!.toggle();
        await ctr.starIconPressed(store);
        if (store.isBookmarked!.value) {
          store.favoriteCount!.value += 1;
          result.value = (store.favoriteCount!.value).toString();
          if (temp >= 1000) {
            result.value = (temp / 1000).toStringAsFixed(1) + "k";
          }
          showModal(store, context);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.black,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            content: Container(
                height: 40, child: Center(child: Text("즐겨찾기에 추가 되었습니다."))),
            padding: EdgeInsets.only(top: 10, bottom: 10, left: 20),
            duration: Duration(seconds: 1),
          ));
        } else {
          store.favoriteCount!.value -= 1;
          result.value = (store.favoriteCount!.value).toString();
          if (temp >= 1000) {
            result.value = (temp / 1000).toStringAsFixed(1) + "k";
          }
        }
      },
      child: Obx(
        () => Column(
          children: [
            Image.asset(
                height: 25,
                store.isBookmarked!.isTrue ? "assets/icons/ico_star_on.png" : "assets/icons/ico_star_off.png",
              ),

            Text(
              result.value,
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
