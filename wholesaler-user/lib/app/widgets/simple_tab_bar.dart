import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wholesaler_user/app/constants/colors.dart';
import 'package:wholesaler_user/app/constants/dimens.dart';
import 'package:wholesaler_user/app/constants/styles.dart';
import 'package:wholesaler_user/app/modules/main/controllers/user_main_controller.dart';
import 'package:wholesaler_user/app/modules/page1_home/controllers/page1_home_controller.dart';
import 'package:wholesaler_user/app/widgets/category_tags/category_tag_controller.dart';

class SimpleTabBar extends StatefulWidget {
  final Key? key;
  final List<Widget>? tabBarViews;
  final List<Widget>? tabs;
  final Color? borderColor;
  final int initialIndex;


  SimpleTabBar({
    required this.initialIndex,
    final this.tabBarViews,
    final this.tabs,
    final this.key,
    final this.borderColor,
  })  : assert(tabs != null, 'tabs must not be null'),
        assert(tabBarViews != null, 'tabBarViews must not be null');

  @override
  _SimpleTabBarState createState() => _SimpleTabBarState();
}

class _SimpleTabBarState extends State<SimpleTabBar> with SingleTickerProviderStateMixin {
  TabController? _tabController;
  CategoryTagController categoryTagCtr = Get.put(CategoryTagController());
  Page1HomeController ctr = Get.put(Page1HomeController());
  UserMainController c = Get.find<UserMainController>();

  @override
  void initState() {
    _tabController = TabController(length: widget.tabBarViews!.length, vsync: this, initialIndex: widget.initialIndex);
    _tabController!.addListener((){
      ctr.tabBarIndex.value=_tabController!.index;
      ctr.storeIndex.value=_tabController!.index;
    });
    super.initState();
  }

  @override
  Widget build(final BuildContext context) => Obx(
    () {
      if(c.changed.value>0) {
          _tabController!.index = 0;
        }
        return Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: MyColors.white,
              // border: Border(
              //   bottom: BorderSide(color: MyColors.grey1),
              // ),
            ),
            height: 45,
            child: TabBar(onTap: (index) {
              if (index == 3)
                categoryTagCtr.isDingDongTab.value = true;
              else
                categoryTagCtr.isDingDongTab.value = false;
            },
              labelStyle: MyTextStyles.f14.copyWith(color: MyColors.subTitle),
              controller: _tabController,
              indicator: BoxDecoration(
                color: MyColors.white,
                border: Border(
                  bottom: BorderSide(width: 3, color: MyColors.black),
                ),
              ),
              labelColor: MyColors.black,
              unselectedLabelColor: Colors.grey,
              tabs: widget.tabs!,
              labelPadding: EdgeInsets.zero,
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: widget.tabBarViews!,
            ),
          ),
        ],
      );

    }
  );

  @override
  void dispose() {
    super.dispose();
    _tabController!.dispose();
  }
}
