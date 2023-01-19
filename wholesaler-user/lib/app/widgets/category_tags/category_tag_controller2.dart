// import 'package:get/get.dart';
// import 'package:wholesaler_user/app/data/api_provider.dart';
// import 'package:wholesaler_user/app/widgets/category_tags/cloth_category2.dart';

// class CategoryTagController2 extends GetxController {
//   uApiProvider _apiProvider = uApiProvider();

//   // RxInt selectedMainCatIndex = 0.obs;
//   // RxInt selectedSubCatIndex = 0.obs;
//   // RxBool isDingDongTab = false.obs; // For Dingdong tab: show "인기", for all other pages, show "ALL"

//   RxList<ClothCategory2> clothCategory = <ClothCategory2>[].obs;

//   @override
//   void onInit() {
//     getAllCategory();
//     super.onInit();
//   }

//   getAllCategory() async {
//     final list = await _apiProvider.getAllCategory() as List;
//     // print(list);
//     //     print(list);
//     // print(list);

//     clothCategory.value = list.map((i) => ClothCategory2.fromJson(i)).toList();
//   }

//   getAllItems() {}
// }
