import 'dart:math';

import 'package:get/state_manager.dart';
import 'package:wholesaler_user/app/data/images_dummy.dart';

class Store {
  int id;
  String? name;
  RxString? imgUrl;
  String imgAssetUrl = 'assets/icons/ic_store.png';
  int? rank;
  RxBool? isBookmarked;
  int? totalProducts;
  int? totalStoreLiked;
  RxInt? favoriteCount;
  RxList<dynamic>? topImagePath;
  List<dynamic>? categories;

  Store({
    required this.id,
    this.name,
    this.rank,
    this.imgUrl,
    this.isBookmarked,
    this.totalProducts,
    this.totalStoreLiked,
    this.favoriteCount,
    this.topImagePath,
    this.categories
  });
}
