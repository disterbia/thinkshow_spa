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

class Page2StoreListController2 extends GetxController {
  uApiProvider _apiProvider = uApiProvider();

  RxList<Store> stores = <Store>[].obs;
  RxBool isLoading = false.obs;
  ScrollController scrollController = ScrollController();

  Future<void> getRankedStoreData() async {
    Future.delayed(Duration.zero, () => isLoading.value = true);

    bool result = await uApiProvider().chekToken();

    if (!result) {
      print('logout');
      mSnackbar(message: '로그인 후 이용 가능합니다.');
       mFuctions.userLogout();
    } else {
      stores.value = await _apiProvider.getStoreRanking(offset: 0, limit: 80);
    }
    Future.delayed(Duration.zero, () =>  isLoading.value = false);
  }

  Future<void> getBookmarkedStoreData() async {
    isLoading.value = true;
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

    isLoading.value = false;
  }

  Future<void> starIconPressed(Store store) async {
    isLoading.value=true;
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


      if (store.isBookmarked!.value) {
        mSnackbar(message: '즐겨찾기에 추가 되었습니다.');
      } else {
        mSnackbar(message: '즐겨찾기가 취소 되었습니다.');
      }

    isLoading.value=false;
  }
}
