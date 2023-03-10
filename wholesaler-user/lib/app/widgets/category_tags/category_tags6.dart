import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wholesaler_user/app/constants/colors.dart';
import 'package:wholesaler_user/app/constants/styles.dart';
import 'package:wholesaler_user/app/models/cloth_category_model.dart';
import 'package:wholesaler_user/app/widgets/category_tags/category_chip_widget.dart';
import 'package:wholesaler_user/app/widgets/category_tags/category_tag_controller2.dart';
import 'package:wholesaler_user/app/widgets/category_tags/category_tag_controller5.dart';
import 'package:wholesaler_user/app/widgets/category_tags/category_tag_controller6.dart';
import 'package:wholesaler_user/app/widgets/category_tags/cloth_category.dart';

class HorizontalChipList6 {
  CategoryTagController6 ctr = Get.put(CategoryTagController6());

  // ############ Cloth categories
  Widget getAllMainCat(
      {required List<String> categoryList, required Function() onTapped}) {
    List<ChipWidget> categoryChips = [];
    // Add ALL chip
    print(ctr.selectedMainCatIndex.value);
    categoryChips.add(
      ChipWidget(
          title: ctr.isDingDongTab.isTrue ? "인기" : ClothCategory.ALL,
          onTap: () {
            ctr.selectedMainCatIndex.value = 0;
            onTapped();
          },
          isSelected: ctr.selectedMainCatIndex.value == 0 ? true : false),
    );

    // Add main or sub categories: ex: shirt,
    for (int i = 0; i < categoryList.length; i++) {
      categoryChips.add(
        ChipWidget(
            title: categoryList[i],
            onTap: () {
              ctr.selectedMainCatIndex.value =
                  i + 1; // the reason for i+1 instead of i: i==0 is "ALL" chip
              onTapped();
            },
            isSelected:
                (i + 1) == ctr.selectedMainCatIndex.value ? true : false),
      );
    }

    // ctr.selectedMainCatIndex.value = 0;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Wrap(
        spacing: 10,
        crossAxisAlignment: WrapCrossAlignment.end,
        alignment: WrapAlignment.end,
        children: [...categoryChips],
      ),
    );
  }

  Widget getAllSubcat(
      {required List<ClothCategoryModel> subCatList,
      required Function(ClothCategoryModel) onTapped,
      required int parentId}) {
    List<ChipWidget> categoryChips = [];
    // Add ALL chip
    ClothCategoryModel allClothCatModel = ClothCategoryModel(
        id: parentId,
        name: ClothCategory.ALL,
        parentId: parentId,
        depth: 0,
        isUse: false);

    categoryChips.add(
      ChipWidget(
          title: ClothCategory.ALL,
          onTap: () {
            ctr.selectedMainCatIndex.value = 0;
            onTapped(allClothCatModel);
          },
          isSelected: ctr.selectedMainCatIndex.value == 0 ? true : false),
    );

    // Add main or sub categories: ex: shirt,
    for (int i = 0; i < subCatList.length; i++) {
      categoryChips.add(
        ChipWidget(
            title: subCatList[i].name,
            onTap: () {
              ctr.selectedMainCatIndex.value =
                  i + 1; // the reason for i+1 instead of i: i==0 is "ALL" chip
              onTapped(subCatList[i]);
            },
            isSelected:
                (i + 1) == ctr.selectedMainCatIndex.value ? true : false),
      );
    }
    ctr.selectedMainCatIndex.value = 0;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Wrap(
        spacing: 10,
        crossAxisAlignment: WrapCrossAlignment.end,
        alignment: WrapAlignment.end,
        children: [...categoryChips],
      ),
    );
  }

  Widget getIconTextList({required Function(int) onPressed}) {
    double screenWidth = GetPlatform.isMobile?Get.width:500;

    List<ClothCategory> clothCategories = ClothCategory.getAll();
    return Container(
      alignment: Alignment.center,
      width: screenWidth,
      height: 150,
      // child: ListView.builder(
      //     scrollDirection: Axis.horizontal,
      //     physics: NeverScrollableScrollPhysics(),
      //     itemCount: clothCategories.length,
      //     shrinkWrap: true,
      //     itemBuilder: (context, index) {
      //       return ClothCategoryItemBuilder(
      //         clothCategory: clothCategories.elementAt(index),
      //         height: screenWidth / clothCategories.length - 25,
      //         width: screenWidth / clothCategories.length - 25,
      //         onTap: () => onPressed(index),
      //       );
      //     }),
      child: GridView.builder(
        itemCount: clothCategories.length,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 5, //1 개의 행에 보여줄 item 개수
          childAspectRatio: 1 / 1, //item 의 가로 1, 세로 2 의 비율
          mainAxisSpacing: 0, //수평 Padding
          crossAxisSpacing: 0, //수직 Padding
        ),
        itemBuilder: (context, index) {
          return ClothCategoryItemBuilder(
            clothCategory: clothCategories.elementAt(index),
            // height: screenWidth / clothCategories.length - 25,
            // width: screenWidth / clothCategories.length - 25,
            height: 25,
            width: 25,
            onTap: () => onPressed(index),
          );
        },
      ),
    );
  }

  Widget ClothCategoryItemBuilder(
      {required ClothCategory clothCategory,
      required VoidCallback onTap,
      required double height,
      required double width}) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
                color: Color(0xFFFFF1DA),
                borderRadius: BorderRadius.circular(15)),
            child: Image.asset(
              clothCategory.icon,
              height: height,
              width: width,
              fit: BoxFit.fill,
            ),
          ),
          SizedBox(height: 5),
          Text(
            clothCategory.title,
            style: MyTextStyles.f12.copyWith(color: MyColors.black1),
          ),
        ],
      ),
    );
  }
}
