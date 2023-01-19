// import 'package:wholesaler_user/app/models/cloth_category_model2.dart';

// class ClothCategory2 {
//   int id;
//   String name;
//   int? parentId;
//   int depth;
//   bool isUse;
//   List<ClothCategoryModel2> subCategories;

//   ClothCategory2({
//     required this.id,
//     required this.name,
//     required this.parentId,
//     required this.depth,
//     required this.isUse,
//     required this.subCategories,
//   });

//   factory ClothCategory2.fromJson(Map<String, dynamic> json) {
//     var list = json['subCategoryList'] as List;
//     List<ClothCategoryModel2> subCategories =
//         list.map((i) => ClothCategoryModel2.fromJson(i)).toList();

//     return ClothCategory2(
//       id: json['id'],
//       name: json['name'],
//       parentId: json['parent_id'],
//       depth: json['depth'],
//       isUse: json['is_use'] == 'Y' ? true : false,
//       subCategories: subCategories,
//     );
//   }
// }
