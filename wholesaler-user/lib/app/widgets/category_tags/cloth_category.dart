// ignore_for_file: constant_identifier_names

import 'dart:developer';
import 'package:get/state_manager.dart';
import 'package:wholesaler_partner/app/constant/enums.dart';
import '../../models/cloth_category_model.dart';

class ClothCategory {
  String title;
  String icon;
  List<ClothCategoryModel> subCategories;
  String image;
  int? selectedSubcatIndex;
  int id;

  /// [isSelected] is used in partner -> product mgmt filter
  RxBool? isSelected;

  ClothCategory({
    required this.id,
    required this.title,
    required this.icon,
    required this.subCategories,
    required this.image,
    this.isSelected,
    this.selectedSubcatIndex,
  });

  static const ALL = "전체"; // all
  static const ACCESSORIES = "악세서리";
  static const BAG = "가방";
  static const SHOES = "슈즈";
  static const OUTER = "아우터"; // outer
  static const TOP = "상의"; // top
  static const PANTS = "바지"; // pants
  static const SKIRTS = "스커트"; // skirts
  static const ONE_PIECE = "원피스"; // onepiece
  static const SET = "투피스/세트";
  // static const STYLEING = "스타일링";

  static const List<String> titles = [
    ClothCategory.TOP,
    ClothCategory.OUTER,
    ClothCategory.ONE_PIECE,
    ClothCategory.PANTS,
    ClothCategory.SKIRTS,
    ClothCategory.SET,
    ClothCategory.SHOES,
    ClothCategory.BAG,
    ClothCategory.ACCESSORIES,
    // ClothCategory.STYLEING,
  ];

  static const Map<String, String> icons = {
    ClothCategory.TOP: 'assets/shared_images_icons/ic_cat_top.png',
    ClothCategory.OUTER: 'assets/shared_images_icons/ic_cat_outer.png',
    ClothCategory.ONE_PIECE: 'assets/shared_images_icons/ic_cat_onepiece.png',
    ClothCategory.PANTS: 'assets/shared_images_icons/ic_cat_pants.png',
    ClothCategory.SKIRTS: 'assets/shared_images_icons/ic_cat_skirts.png',
    ClothCategory.SET: 'assets/shared_images_icons/ic_cat_set.png',
    ClothCategory.SHOES: 'assets/shared_images_icons/ic_cat_shoes.png',
    ClothCategory.BAG: 'assets/shared_images_icons/ic_cat_bag.png',
    ClothCategory.ACCESSORIES:
        'assets/shared_images_icons/ic_cat_accessories.png',
    // ClothCategory.STYLEING: 'assets/shared_images_icons/ic_cat_accessories.png',
  };

  static Map<String, List<ClothCategoryModel>> subCats = {
    ClothCategory.TOP: getAllItems()
        .where((element) => element.parentId == ClothMainCategoryEnum.TOP)
        .toList(),
    ClothCategory.OUTER: getAllItems()
        .where((element) => element.parentId == ClothMainCategoryEnum.OUTER)
        .toList(),
    ClothCategory.ONE_PIECE: getAllItems()
        .where((element) => element.parentId == ClothMainCategoryEnum.ONE_PIECE)
        .toList(),
    ClothCategory.PANTS: getAllItems()
        .where((element) => element.parentId == ClothMainCategoryEnum.PANTS)
        .toList(),
    ClothCategory.SKIRTS: getAllItems()
        .where((element) => element.parentId == ClothMainCategoryEnum.SKIRTS)
        .toList(),
    ClothCategory.SET: getAllItems()
        .where((element) => element.parentId == ClothMainCategoryEnum.SET)
        .toList(),
    ClothCategory.ACCESSORIES: getAllItems()
        .where(
            (element) => element.parentId == ClothMainCategoryEnum.ACCESSORIES)
        .toList(),
    ClothCategory.SHOES: getAllItems()
        .where((element) => element.parentId == ClothMainCategoryEnum.SHOES)
        .toList(),
    ClothCategory.BAG: getAllItems()
        .where((element) => element.parentId == ClothMainCategoryEnum.BAG)
        .toList(),

    // ClothCategory.STYLEING: getAllItems()
    //     .where((element) => element.parentId == ClothMainCategoryEnum.STYLEING)
    //     .toList(),
  };

  static const Map<String, String> clothImages = {
    ClothCategory.TOP: 'assets/shared_images_icons/ic_cat_top.png',
    ClothCategory.OUTER: 'assets/shared_images_icons/ic_cat_outer.png',
    ClothCategory.ONE_PIECE: 'assets/shared_images_icons/ic_cat_onepiece.png',
    ClothCategory.PANTS: 'assets/shared_images_icons/ic_cat_pants.png',
    ClothCategory.SKIRTS: 'assets/shared_images_icons/ic_cat_skirts.png',
    ClothCategory.SET: 'assets/shared_images_icons/ic_cat_set.png',
    ClothCategory.SHOES: 'assets/shared_images_icons/ic_cat_shoes.png',
    ClothCategory.BAG: 'assets/shared_images_icons/ic_cat_bag.png',
    ClothCategory.ACCESSORIES:
        'assets/shared_images_icons/ic_cat_accessories.png',
    // ClothCategory.STYLEING: 'assets/shared_images_icons/ic_cat_accessories.png',
  };

  static List<ClothCategoryModel> getAllMainCat() {
    List<ClothCategoryModel> tempClothCetegories =
        getAllItems().where((element) => element.depth == 0).toList();
    return tempClothCetegories;
  }

  static List<ClothCategoryModel> getAllSubcatTitles(
      {required int mainCatIndex}) {
    List<ClothCategoryModel> tempClothCetegories = getAllItems()
        .where(
            (element) => element.depth != 0 && element.parentId == mainCatIndex)
        .toList();
    return tempClothCetegories;
  }

  // we have two diffrent icon designs. One used in USER app, another used in PARTNER app
  static List<ClothCategory> getAll() {
    List<ClothCategoryModel> mainCats = getAllMainCat();

    return [
      for (int i = 0; i < mainCats.length; i++)
        ClothCategory(
          id: i + 1,
          title: mainCats[i].name,
          icon: icons[mainCats[i].name]!,
          subCategories: subCats[mainCats[i].name] ?? [],
          image: clothImages[mainCats[i].name]!,
          isSelected: false.obs,
        ),
    ];
  }

  static List<ClothCategoryModel> getAllItems() {
    return [
      ClothCategoryModel(
          id: ClothMainCategoryEnum.TOP,
          name: '상의',
          parentId: null,
          depth: 0,
          isUse: true),
      ClothCategoryModel(
          id: ClothMainCategoryEnum.OUTER,
          name: '아우터',
          parentId: null,
          depth: 0,
          isUse: true),
      ClothCategoryModel(
          id: ClothMainCategoryEnum.ONE_PIECE,
          name: '원피스',
          parentId: null,
          depth: 0,
          isUse: true),
      ClothCategoryModel(
          id: ClothMainCategoryEnum.PANTS,
          name: '바지',
          parentId: null,
          depth: 0,
          isUse: true),

      ClothCategoryModel(
          id: ClothMainCategoryEnum.SKIRTS,
          name: '스커트',
          parentId: null,
          depth: 0,
          isUse: true),

      ClothCategoryModel(
          id: ClothMainCategoryEnum.SET,
          name: '투피스/세트',
          parentId: null,
          depth: 0,
          isUse: true),
      ClothCategoryModel(
          id: ClothMainCategoryEnum.SHOES,
          name: '슈즈',
          parentId: null,
          depth: 0,
          isUse: true),
      ClothCategoryModel(
          id: ClothMainCategoryEnum.BAG,
          name: '가방',
          parentId: null,
          depth: 0,
          isUse: true),
      ClothCategoryModel(
          id: ClothMainCategoryEnum.ACCESSORIES,
          name: '악세서리',
          parentId: null,
          depth: 0,
          isUse: true),

      // ClothCategoryModel(
      //     id: ClothMainCategoryEnum.STYLEING,
      //     name: '스타일링',
      //     parentId: null,
      //     depth: 0,
      //     isUse: true),

      /** 상의 */
      ClothCategoryModel(
          id: 11,
          name: '티셔츠',
          parentId: ClothMainCategoryEnum.TOP,
          depth: 1,
          isUse: true),
      ClothCategoryModel(
          id: 12,
          name: '블라우스&셔츠',
          parentId: ClothMainCategoryEnum.TOP,
          depth: 1,
          isUse: true),
      ClothCategoryModel(
          id: 13,
          name: '니트&스웨터',
          parentId: ClothMainCategoryEnum.TOP,
          depth: 1,
          isUse: true),
      ClothCategoryModel(
          id: 14,
          name: '맨투맨',
          parentId: ClothMainCategoryEnum.TOP,
          depth: 1,
          isUse: true),
      ClothCategoryModel(
          id: 15,
          name: '후드',
          parentId: ClothMainCategoryEnum.TOP,
          depth: 1,
          isUse: true),
      ClothCategoryModel(
          id: 16,
          name: '뷔스티에&슬리브리스',
          parentId: ClothMainCategoryEnum.TOP,
          depth: 1,
          isUse: true),
      ClothCategoryModel(
          id: 17,
          name: '베스트',
          parentId: ClothMainCategoryEnum.TOP,
          depth: 1,
          isUse: true),

      /** 아우터 */
      ClothCategoryModel(
          id: 18,
          name: '코트',
          parentId: ClothMainCategoryEnum.OUTER,
          depth: 1,
          isUse: true),
      ClothCategoryModel(
          id: 19,
          name: '자켓',
          parentId: ClothMainCategoryEnum.OUTER,
          depth: 1,
          isUse: true),
      ClothCategoryModel(
          id: 20,
          name: '점퍼',
          parentId: ClothMainCategoryEnum.OUTER,
          depth: 1,
          isUse: true),
      ClothCategoryModel(
          id: 21,
          name: '가디건',
          parentId: ClothMainCategoryEnum.OUTER,
          depth: 1,
          isUse: true),
      ClothCategoryModel(
          id: 22,
          name: '무스탕&퍼',
          parentId: ClothMainCategoryEnum.OUTER,
          depth: 1,
          isUse: true),
      ClothCategoryModel(
          id: 23,
          name: '베스트',
          parentId: ClothMainCategoryEnum.OUTER,
          depth: 1,
          isUse: true),

      /**원피스 */
      ClothCategoryModel(
          id: 24,
          name: '미니원피스',
          parentId: ClothMainCategoryEnum.ONE_PIECE,
          depth: 1,
          isUse: true),
      ClothCategoryModel(
          id: 25,
          name: '미디원피스',
          parentId: ClothMainCategoryEnum.ONE_PIECE,
          depth: 1,
          isUse: true),
      ClothCategoryModel(
          id: 26,
          name: '롱원피스',
          parentId: ClothMainCategoryEnum.ONE_PIECE,
          depth: 1,
          isUse: true),
      ClothCategoryModel(
          id: 27,
          name: '점프슈트',
          parentId: ClothMainCategoryEnum.ONE_PIECE,
          depth: 1,
          isUse: true),

      /** 바지 */
      ClothCategoryModel(
          id: 28,
          name: '슬랙스',
          parentId: ClothMainCategoryEnum.PANTS,
          depth: 1,
          isUse: true),
      ClothCategoryModel(
          id: 29,
          name: '면바지',
          parentId: ClothMainCategoryEnum.PANTS,
          depth: 1,
          isUse: true),
      ClothCategoryModel(
          id: 30,
          name: '데님',
          parentId: ClothMainCategoryEnum.PANTS,
          depth: 1,
          isUse: true),
      ClothCategoryModel(
          id: 31,
          name: '조거&트레이닝',
          parentId: ClothMainCategoryEnum.PANTS,
          depth: 1,
          isUse: true),
      ClothCategoryModel(
          id: 32,
          name: '반바지',
          parentId: ClothMainCategoryEnum.PANTS,
          depth: 1,
          isUse: true),

      /**스커트 */
      ClothCategoryModel(
          id: 33,
          name: '미니스커트',
          parentId: ClothMainCategoryEnum.SKIRTS,
          depth: 1,
          isUse: true),
      ClothCategoryModel(
          id: 34,
          name: '미디스커트',
          parentId: ClothMainCategoryEnum.SKIRTS,
          depth: 1,
          isUse: true),
      ClothCategoryModel(
          id: 35,
          name: '롱스커트',
          parentId: ClothMainCategoryEnum.SKIRTS,
          depth: 1,
          isUse: true),

      /**투피스/세트 */
      ClothCategoryModel(
          id: 36,
          name: '치마세트',
          parentId: ClothMainCategoryEnum.SET,
          depth: 1,
          isUse: true),
      ClothCategoryModel(
          id: 37,
          name: '바지세트',
          parentId: ClothMainCategoryEnum.SET,
          depth: 1,
          isUse: true),

      /** 신발 */
      ClothCategoryModel(
          id: 38,
          name: '샌들',
          parentId: ClothMainCategoryEnum.SHOES,
          depth: 1,
          isUse: true),
      ClothCategoryModel(
          id: 39,
          name: '플랫',
          parentId: ClothMainCategoryEnum.SHOES,
          depth: 1,
          isUse: true),
      ClothCategoryModel(
          id: 40,
          name: '로퍼',
          parentId: ClothMainCategoryEnum.SHOES,
          depth: 1,
          isUse: true),
      ClothCategoryModel(
          id: 41,
          name: '부츠',
          parentId: ClothMainCategoryEnum.SHOES,
          depth: 1,
          isUse: true),
      ClothCategoryModel(
          id: 42,
          name: '힐',
          parentId: ClothMainCategoryEnum.SHOES,
          depth: 1,
          isUse: true),
      ClothCategoryModel(
          id: 43,
          name: '스니커즈',
          parentId: ClothMainCategoryEnum.SHOES,
          depth: 1,
          isUse: true),

      /** 가방 */
      ClothCategoryModel(
          id: 44,
          name: '백팩&클러치',
          parentId: ClothMainCategoryEnum.BAG,
          depth: 1,
          isUse: true),
      ClothCategoryModel(
          id: 45,
          name: '숄더백',
          parentId: ClothMainCategoryEnum.BAG,
          depth: 1,
          isUse: true),
      ClothCategoryModel(
          id: 46,
          name: '크로스백',
          parentId: ClothMainCategoryEnum.BAG,
          depth: 1,
          isUse: true),
      ClothCategoryModel(
          id: 47,
          name: '토트백',
          parentId: ClothMainCategoryEnum.BAG,
          depth: 1,
          isUse: true),
      ClothCategoryModel(
          id: 48,
          name: '에코백',
          parentId: ClothMainCategoryEnum.BAG,
          depth: 1,
          isUse: true),

      /** 악세사리 */
      ClothCategoryModel(
          id: 49,
          name: '양말',
          parentId: ClothMainCategoryEnum.ACCESSORIES,
          depth: 1,
          isUse: true),
      ClothCategoryModel(
          id: 50,
          name: '스타킹',
          parentId: ClothMainCategoryEnum.ACCESSORIES,
          depth: 1,
          isUse: true),
      ClothCategoryModel(
          id: 51,
          name: '목걸이',
          parentId: ClothMainCategoryEnum.ACCESSORIES,
          depth: 1,
          isUse: true),
      ClothCategoryModel(
          id: 52,
          name: '귀걸이',
          parentId: ClothMainCategoryEnum.ACCESSORIES,
          depth: 1,
          isUse: true),
      ClothCategoryModel(
          id: 53,
          name: '모자',
          parentId: ClothMainCategoryEnum.ACCESSORIES,
          depth: 1,
          isUse: true),
      ClothCategoryModel(
          id: 54,
          name: '헤어밴드',
          parentId: ClothMainCategoryEnum.ACCESSORIES,
          depth: 1,
          isUse: true),
      ClothCategoryModel(
          id: 55,
          name: '헤어핀/집게',
          parentId: ClothMainCategoryEnum.ACCESSORIES,
          depth: 1,
          isUse: true),
      ClothCategoryModel(
          id: 56,
          name: '헤어스크런치',
          parentId: ClothMainCategoryEnum.ACCESSORIES,
          depth: 1,
          isUse: true),
      ClothCategoryModel(
          id: 57,
          name: '벨트',
          parentId: ClothMainCategoryEnum.ACCESSORIES,
          depth: 1,
          isUse: true),
      ClothCategoryModel(
          id: 58,
          name: '시계',
          parentId: ClothMainCategoryEnum.ACCESSORIES,
          depth: 1,
          isUse: true),
      ClothCategoryModel(
          id: 59,
          name: '머플러',
          parentId: ClothMainCategoryEnum.ACCESSORIES,
          depth: 1,
          isUse: true),
      ClothCategoryModel(
          id: 60,
          name: '장갑',
          parentId: ClothMainCategoryEnum.ACCESSORIES,
          depth: 1,
          isUse: true),
      ClothCategoryModel(
          id: 61,
          name: '이너웨어(상의)',
          parentId: ClothMainCategoryEnum.ACCESSORIES,
          depth: 1,
          isUse: true),
      ClothCategoryModel(
          id: 62,
          name: '이너웨어(하의)',
          parentId: ClothMainCategoryEnum.ACCESSORIES,
          depth: 1,
          isUse: true),

      // ////// 아우터
      // ClothCategoryModel(
      //     id: 7, name: '가디건', parentId: 1, depth: 1, isUse: true),
      // ClothCategoryModel(id: 8, name: '자켓', parentId: 1, depth: 1, isUse: true),
      // ClothCategoryModel(id: 9, name: '코트', parentId: 1, depth: 1, isUse: true),
      // ClothCategoryModel(
      //     id: 10, name: '점퍼', parentId: 1, depth: 1, isUse: true),
      // ClothCategoryModel(
      //     id: 11, name: '야상', parentId: 1, depth: 1, isUse: true),
      // ClothCategoryModel(
      //     id: 12, name: '베스트', parentId: 1, depth: 1, isUse: true),
      // ClothCategoryModel(
      //     id: 13, name: '패딩', parentId: 1, depth: 1, isUse: true),
      // /////// 상의
      // ClothCategoryModel(
      //     id: 14, name: '티셔츠', parentId: 2, depth: 1, isUse: true),
      // ClothCategoryModel(
      //     id: 15, name: '니트/스웨터', parentId: 2, depth: 1, isUse: true),
      // ClothCategoryModel(
      //     id: 16, name: '셔츠/남방', parentId: 2, depth: 1, isUse: true),
      // ClothCategoryModel(
      //     id: 17, name: '맨투맨', parentId: 2, depth: 1, isUse: true),
      // ClothCategoryModel(
      //     id: 18, name: '후드', parentId: 2, depth: 1, isUse: true),
      // ClothCategoryModel(
      //     id: 19, name: '블라우스', parentId: 2, depth: 1, isUse: true),
      // ClothCategoryModel(
      //     id: 20, name: '민소매/나시', parentId: 2, depth: 1, isUse: true),
      // //// 바지
      // ClothCategoryModel(
      //     id: 21, name: '일자바지', parentId: 3, depth: 1, isUse: true),
      // ClothCategoryModel(
      //     id: 22, name: '슬랙스팬츠', parentId: 3, depth: 1, isUse: true),
      // ClothCategoryModel(
      //     id: 23, name: '반바지', parentId: 3, depth: 1, isUse: true),
      // ClothCategoryModel(
      //     id: 24, name: '와이드팬츠', parentId: 3, depth: 1, isUse: true),
      // ClothCategoryModel(
      //     id: 25, name: '스키니팬츠', parentId: 3, depth: 1, isUse: true),
      // ClothCategoryModel(
      //     id: 26, name: '부츠컷팬츠', parentId: 3, depth: 1, isUse: true),
      // ClothCategoryModel(
      //     id: 27, name: '조거팬츠', parentId: 3, depth: 1, isUse: true),
      // ClothCategoryModel(
      //     id: 28, name: '치마바지', parentId: 3, depth: 1, isUse: true),
      // ClothCategoryModel(
      //     id: 29, name: '멜빵바지', parentId: 3, depth: 1, isUse: true),
      // ClothCategoryModel(
      //     id: 30, name: '크롭팬츠', parentId: 3, depth: 1, isUse: true),
      // ClothCategoryModel(
      //     id: 31, name: '배기팬츠', parentId: 3, depth: 1, isUse: true),
      // ClothCategoryModel(
      //     id: 32, name: '레깅스', parentId: 3, depth: 1, isUse: true),
      // ////// 스커트
      // ClothCategoryModel(
      //     id: 33, name: '미니스커트', parentId: 4, depth: 1, isUse: true),
      // ClothCategoryModel(
      //     id: 34, name: '미디스커트', parentId: 4, depth: 1, isUse: true),
      // ClothCategoryModel(
      //     id: 35, name: '롱스커트', parentId: 4, depth: 1, isUse: true),
      // //// 원피스
      // ClothCategoryModel(
      //     id: 36, name: '미니원피스', parentId: 5, depth: 1, isUse: true),
      // ClothCategoryModel(
      //     id: 37, name: '미디원피스', parentId: 5, depth: 1, isUse: true),
      // ClothCategoryModel(
      //     id: 38, name: '롱원피스', parentId: 5, depth: 1, isUse: true),
      // ClothCategoryModel(
      //     id: 39, name: '점푸슈트', parentId: 5, depth: 1, isUse: true),
      // ///// 세트
      // ClothCategoryModel(
      //     id: 40, name: '투피스', parentId: 6, depth: 1, isUse: true),
      // ClothCategoryModel(
      //     id: 41, name: '세트', parentId: 6, depth: 1, isUse: true),
    ];
  }

  static String getTitleAt(int index) {
    return getAllMainCat()[index].name;
  }

  /// [getCategoryIdAt] returns the hard coded category id
  ///
  /// it gets the index of the selected chip as input
  ///
  /// example: Mini Skirt category id is: 33
  static int getCategoryIdAt(int index) {
    // log('selected item: ' + getAllItems().elementAt(index).id.toString() + ' name ' + getAllItems().elementAt(index).name);
    return getAllItems().elementAt(index).id;
  }
}
