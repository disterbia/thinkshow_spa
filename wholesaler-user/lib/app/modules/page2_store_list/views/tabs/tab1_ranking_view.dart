import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:wholesaler_partner/app/widgets/loading_widget.dart';
import 'package:wholesaler_user/app/constants/colors.dart';
import 'package:wholesaler_user/app/constants/styles.dart';
import 'package:wholesaler_user/app/models/store_model.dart';
import 'package:wholesaler_user/app/modules/page2_store_detail/view/store_detail_view.dart';
import 'package:wholesaler_user/app/modules/page2_store_list/controllers/shopping_controller.dart';

class Tab1RankingView extends StatelessWidget {
  Page2StoreListController ctr = Get.put(Page2StoreListController());
  String? prevPage = "rank";
  final RxList<bool> _selected = <bool>[true, false].obs;

  @override
  Widget build(BuildContext context) {
    ctr.getRankedStoreData();
    return Obx(
      () => ctr.isLoading.value
          ? LoadingWidget()
          : SingleChildScrollView(
              controller: ctr.scrollController,
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10.0, top: 10),
                      child: ToggleButtons(
                        //direction: vertical ? Axis.vertical : Axis.horizontal,
                        onPressed: (int index) {
                          if (index == 0) ctr.getMostStoreData();
                          if (index == 1) ctr.getRankedStoreData();
                          // The button that is tapped is set to true, and the others to false.
                          for (int i = 0; i < _selected.length; i++) {
                            _selected[i] = i == index;
                          }
                        },
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8)),
                        selectedColor: Colors.white,
                        fillColor: MyColors.primary,
                        color: Colors.grey,
                        constraints: const BoxConstraints(
                          minHeight: 25.0,
                          minWidth: 25.0,
                        ),
                        isSelected: _selected,
                        children: [Text(" 추천순 "), Text(" 인기순 ")],
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
    );
  }

  Widget _storeList(Store store, BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => StoreDetailView(
              storeId: store.id,
              prevPage: prevPage,
            ),preventDuplicates: true);
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
                        child: CachedNetworkImage(
                          fit: BoxFit.fitHeight,
                          imageUrl: store.topImagePath![0],
                          height: 100,
                        ),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(4),
                            bottomLeft: Radius.circular(4)),
                      )),
                      SizedBox(width: 2),
                      Expanded(
                          child: CachedNetworkImage(
                        fit: BoxFit.fitHeight,
                        imageUrl: store.topImagePath![1],
                        height: 100,
                      )),
                      SizedBox(width: 2),
                      Expanded(
                          child: CachedNetworkImage(
                        fit: BoxFit.fitHeight,
                        imageUrl: store.topImagePath![2],
                        height: 100,
                      )),
                      SizedBox(width: 2),
                      Expanded(
                          child: ClipRRect(
                              child: CachedNetworkImage(
                                fit: BoxFit.fitHeight,
                                imageUrl: store.topImagePath![3],
                                height: 100,
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
              //         return SizedBox(width: 500*0.2,
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
            height: Get.height / 3,
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
                      height: 140,
                      child: Row(
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                Get.to(() => StoreDetailView(
                                  storeId: ctr.sameId[0],
                                  prevPage: prevPage,
                                ),preventDuplicates: true);
                              },
                              child: Container(
                                child: Stack(
                                  children: [
                                    Container(
                                        child: Center(
                                                child: ClipRRect(
                                                  child:  ctr.mainImage[0] == ""
                                                      ? Image.asset(
                                                        "assets/icons/ic_store.png",
                                                      )
                                                      :CachedNetworkImage(
                                                    imageUrl: ctr.mainImage[0],
                                                    fit: BoxFit.fill,
                                                  ),
                                                  borderRadius: BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(10.0),
                                                      topRight:
                                                          Radius.circular(10.0)),
                                                ),
                                              ),
                                        height: 120),
                                    Align(
                                        alignment: Alignment.bottomCenter,
                                        child: Container(
                                          child: Center(
                                                  child: CircleAvatar(
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(2),
                                                    child: ClipOval(
                                                      child: ctr.subImage[0] == ""
                                                          ? Image.asset(
                                                        "assets/icons/ic_store.png",
                                                      ):CachedNetworkImage(
                                                        imageUrl: ctr.subImage[0],
                                                      ),
                                                    ),
                                                  ),
                                                  radius: 50,
                                                    backgroundColor: Colors.white,
                                                )),
                                          width: 50,
                                          height: 50,
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
                                Get.to(() => StoreDetailView(
                                  storeId: ctr.sameId[1],
                                  prevPage: prevPage,
                                ),preventDuplicates: true);
                              },
                              child: Container(
                                child: Stack(
                                  children: [
                                    Container(
                                        child: Center(
                                                child: ClipRRect(
                                                  child:  ctr.mainImage[1] == ""
                                                      ? Image.asset(
                                                    "assets/icons/ic_store.png",
                                                  )
                                                      :CachedNetworkImage(
                                                    imageUrl: ctr.mainImage[1],
                                                    fit: BoxFit.fill,
                                                  ),
                                                  borderRadius: BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(10.0),
                                                      topRight:
                                                          Radius.circular(10.0)),
                                                ),
                                              ),
                                        height: 120),
                                    Align(
                                        alignment: Alignment.bottomCenter,
                                        child: Container(
                                          child:Center(
                                              child: CircleAvatar(
                                                child: Padding(
                                                  padding: const EdgeInsets.all(2),
                                                  child:  ctr.subImage[1] == ""
                                                      ? Image.asset(
                                                    "assets/icons/ic_store.png",
                                                  )
                                                      : ClipOval(
                                                    child: CachedNetworkImage(
                                                      imageUrl: ctr.subImage[1],
                                                    ),
                                                  ),
                                                ),
                                                radius: 50,
                                                backgroundColor: Colors.white,
                                              )),
                                          width: 50,
                                          height: 50,
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
          store.favoriteCount!.value+=1;
          result.value= (store.favoriteCount!.value).toString();
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
        }else{
          store.favoriteCount!.value-=1;
          result.value= (store.favoriteCount!.value).toString();
          if (temp >= 1000) {
            result.value = (temp / 1000).toStringAsFixed(1) + "k";
          }
        }

      },
      child: Obx(
        () => Column(
          children: [
            Icon(
              size: 25,
              store.isBookmarked!.isTrue ? Icons.star : Icons.star_border,
              color: MyColors.primary,
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
