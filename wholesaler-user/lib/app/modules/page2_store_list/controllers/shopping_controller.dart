import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wholesaler_user/app/data/api_provider.dart';
import 'package:wholesaler_user/app/data/cache_provider.dart';
import 'package:wholesaler_user/app/models/store_model.dart';
import 'package:wholesaler_user/app/modules/auth/user_login_page/views/user_login_view.dart';
import 'package:wholesaler_user/app/widgets/snackbar.dart';
import 'package:wholesaler_user/app/constants/functions.dart';

class Page2StoreListController extends GetxController {
  uApiProvider _apiProvider = uApiProvider();

  RxList<Store> stores = <Store>[].obs;
  RxBool isLoading = false.obs;
  ScrollController scrollController = ScrollController();
  RxList<String> mainImage=<String>[].obs;
  RxList<String> subImage=<String>[].obs;
  RxList<String> storeName=<String>[].obs;
  RxList<int> sameId=<int>[].obs;
  RxInt selected = 0.obs;
  final RxList<String> dropDownItem= <String>["최신순","인기순","리뷰순"].obs;
  // Future<void> getRankedStoreData() async {
  //   Future.delayed(Duration.zero, () => isLoading.value = true);
  //
  //   bool result = await uApiProvider().chekToken();
  //
  //   if (!result) {
  //     print('logout');
  //     mSnackbar(message: '로그인 후 이용 가능합니다.');
  //      mFuctions.userLogout();
  //   } else {
  //     stores.value = await _apiProvider.getStoreRanking(offset: 0, limit: 80);
  //   }
  //   Future.delayed(Duration.zero, () =>  isLoading.value = false);
  // }
  Future<void> getMostStoreData() async {
    Future.delayed(Duration.zero, () => isLoading.value = true);

    bool result = await uApiProvider().chekToken();

    if (!result) {
      print('logout');
      mSnackbar(message: '로그인 후 이용 가능합니다.');
       mFuctions.userLogout();
    } else {
      stores.value = await _apiProvider.getMostStoreData(offset: 0, limit: 80);
    }
    Future.delayed(Duration.zero, () =>  isLoading.value = false);
  }
  Future<void> getNewestStoreData() async {
    Future.delayed(Duration.zero, () => isLoading.value = true);

    bool result = await uApiProvider().chekToken();

    if (!result) {
      print('logout');
      mSnackbar(message: '로그인 후 이용 가능합니다.');
      mFuctions.userLogout();
    } else {
      stores.value = await _apiProvider.getNewestStoreData(offset: 0, limit: 80);
    }
    Future.delayed(Duration.zero, () =>  isLoading.value = false);
  }

  Future<void> getReviewStoreData() async {
    Future.delayed(Duration.zero, () => isLoading.value = true);

    bool result = await uApiProvider().chekToken();

    if (!result) {
      print('logout');
      mSnackbar(message: '로그인 후 이용 가능합니다.');
      mFuctions.userLogout();
    } else {
      stores.value = await _apiProvider.getReviewStoreData(offset: 0, limit: 80);
    }
    Future.delayed(Duration.zero, () =>  isLoading.value = false);
  }


  Future<void> getBookmarkedStoreData() async {
    Future.delayed(Duration.zero, () => isLoading.value = true);

    bool result = await uApiProvider().chekToken();

    if (!result) {
      print('logout');
      mSnackbar(message: '로그인 후 이용 가능합니다.');
       mFuctions.userLogout();
    } else {
      stores.value = await _apiProvider.getStorebookmarked();
    }
    // if (CacheProvider().getToken().isEmpty) {
    //   WidgetsBinding.instance.addPostFrameCallback((_) {
    //      mFuctions.userLogout();
    //   });
    // } else {
    //   Future.delayed(Duration.zero,() => isLoading.value=true);

    //   stores.value = await _apiProvider.getStorebookmarked();
    // }

    Future.delayed(Duration.zero, () => isLoading.value = false);
  }

  Future<void> starIconPressed(Store store) async {
    if (CacheProvider().getToken().isEmpty) {
      mSnackbar(message: '로그인 후 이용 가능합니다.');
       mFuctions.userLogout();
      return;
    }

    bool result = await uApiProvider().chekToken();
    if (!result) {
      print('logout');
      mSnackbar(message: '로그인 후 이용 가능합니다.');
       mFuctions.userLogout();
      return;
    }
    log('store id ${store.id}');

    String response = await _apiProvider.putAddStoreFavorite(storeId: store.id);

    Map<String,dynamic> json =jsonDecode(response);
       mainImage.clear();
      subImage.clear();
      sameId.clear();
      if (store.isBookmarked!.value) {
        for(var imgUrl in json["similar_store_list"]){
          String? mainImageTemp = imgUrl["store_main_image_url"];
          String? subImageTemp = imgUrl["store_thumbnail_image_url"];
          String? name = imgUrl["store_name"];
          sameId.add(imgUrl["store_id"]);
          storeName.add(imgUrl["store_name"]);
          if(mainImageTemp!=null){
            mainImage.add(imgUrl["store_main_image_url"]);
          }else {
            mainImage.add("");
          }
          if(subImageTemp!=null){
            subImage.add(imgUrl["store_thumbnail_image_url"]);
          }else{
            subImage.add("");
          }

        }
        //mSnackbar(message: '스토어 찜 설정이 완료되었습니다.');
      } else {
         mSnackbar(message: '즐겨찾기가 취소 되었습니다.');
      }

  }
}
