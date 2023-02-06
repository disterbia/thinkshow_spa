import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wholesaler_user/app/constants/colors.dart';
import 'package:wholesaler_user/app/constants/styles.dart';
import 'package:wholesaler_user/app/constants/variables.dart';
import 'package:wholesaler_user/app/data/cache_provider.dart';
import 'package:wholesaler_user/app/models/inquiry_model.dart';
import 'package:wholesaler_user/app/modules/auth/user_login_page/views/user_login_view.dart';
import 'package:wholesaler_user/app/modules/product_detail/controller/tab_3_inquiry_controller.dart';
import 'package:wholesaler_user/app/modules/product_detail/views/tab3_inquiry_dialog.dart';

class Tab3InquiryView extends GetView {
  Tab3InquiryController ctr = Get.put(Tab3InquiryController());
  Tab3InquiryView();

  init() {
    ctr.init();
  }

  @override
  Widget build(BuildContext context) {
    init();
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 20),
          MyVars.isUserProject() ? _writeInquiryButton() : SizedBox.shrink(),
          SizedBox(height: 20),
          Divider(thickness: 5, color: MyColors.grey3),
          SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              '문의',
              style: MyTextStyles.f16_bold.copyWith(color: MyColors.black2),
            ),
          ),
          SizedBox(height: 20),
          Obx(
            () => ListView.separated(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: ctr.inquires.length,
              separatorBuilder: (BuildContext context, int index) =>
                  SizedBox(width: 14),
              itemBuilder: (BuildContext context, int index) {
                return _expandedQuestionBox(ctr.inquires[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _writeInquiryButton() {
    // return Padding(
    //   padding: const EdgeInsets.symmetric(horizontal: 15),
    //   child: OutlinedButton(
    //     onPressed: (() {
    //       if (CacheProvider().getToken().isEmpty) {
    //         Get.to(() => User_LoginPageView());
    //         return;
    //       }
    //       Get.to(() => InquityRegisterView());
    //     }),
    //     child: Text(
    //       '문의하기',
    //       style: MyTextStyles.f14.copyWith(color: MyColors.black1),
    //     ),
    //   ),
    // );

    return Container(
      height: Get.height / 17,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(MyColors.grey1),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            onPressed: () {
              if (CacheProvider().getToken().isEmpty) {
                Get.to(() => User_LoginPageView());
                return;
              }
              Get.to(() => InquityRegisterView());
            },
            child: Text("상품 문의하기",
                style: MyTextStyles.f16_bold.copyWith(color: MyColors.black2))),
      ),
    );
  }

  Widget _expandedQuestionBox(InquiryModel inquiryModel) {
    print(
        '_expandedQuestionBox inquiryModel isSecret: ${inquiryModel.isSecret} isMine: ${inquiryModel.isMine} content: ${inquiryModel.content}');
    return inquiryModel.isSecret! && !inquiryModel.isMine! ||
            !inquiryModel.isAnswer!
        // secret design
        ? _secretItemorAnsweredBuilder(inquiryModel)
        // Not Secret design
        : _notSecretItemBuilder(inquiryModel);
  }

  SizedBox _verticalDivider() {
    return SizedBox(
      height: 15,
      child: VerticalDivider(
        thickness: 1,
        color: MyColors.grey2,
      ),
    );
  }

  // _listTileTitle(InquiryModel questionModel) {
  //   return Column(
  //     children: [

  //     ],
  //   );
  // }

  Widget _questionTitle(InquiryModel item) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              item.content!,
              style: MyTextStyles.f14.copyWith(color: MyColors.grey2),
            ),
            SizedBox(width: 10),
            if (item.isSecret! && !item.isMine!)
              Image.asset(
                'assets/shared_images_icons/ic_lock.png',
                width: 16,
              )
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          children: [
            _AnswerTextBuilder(item.isAnswer!),
            _verticalDivider(),
            Text(
              item.writer.toString(),
              style: MyTextStyles.f12.copyWith(color: MyColors.grey10),
            ),
            _verticalDivider(),
            Text(
              item.createdAt.toString(),
              style: MyTextStyles.f12.copyWith(color: MyColors.grey10),
            )
          ],
        )
      ],
    );
  }

  Widget _question(InquiryModel item) {
    return Row(
      children: [
        Flexible(flex: 1, child: _questionMark()),
        Flexible(
          flex: 4,
          child: Text(
            item.content.toString(),
            style: MyTextStyles.f14.copyWith(color: MyColors.black2),
          ),
        )
      ],
    );
  }

  Widget _questionMark() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          height: 30,
          width: 30,
          decoration: BoxDecoration(
              color: MyColors.orange1,
              borderRadius: BorderRadius.all(Radius.circular(2))),
          child: Center(
            child: Text(
              'Q',
              style:
                  TextStyle(fontWeight: FontWeight.w800, color: MyColors.black),
            ),
          )),
    );
  }

  Widget _answer(InquiryModel item) {
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: MyColors.grey1,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            item.answerContent.toString(),
            style: MyTextStyles.f14.copyWith(color: MyColors.grey10),
          ),
          Row(
            children: [
              Text(
                ctr.product.store.name!,
                style: MyTextStyles.f12.copyWith(color: MyColors.grey10),
              ),
              // _verticalDivider(),
              // Text(
              //   '슬로우 엔드',
              //   style: MyTextStyles.f12.copyWith(color: MyColors.grey10),
              // ),
            ],
          )
        ],
      ),
    );
  }

  Widget _answerMark() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          height: 30,
          width: 30,
          decoration: BoxDecoration(
              color: MyColors.orange2,
              borderRadius: BorderRadius.all(Radius.circular(2))),
          child: Center(
            child: Text(
              'A',
              style:
                  TextStyle(fontWeight: FontWeight.w800, color: MyColors.white),
            ),
          )),
    );
  }

  _AnswerTextBuilder(bool isAnswered) {
    return Text(
      isAnswered ? '답변완료' : '미답변',
      style: MyTextStyles.f12.copyWith(color: MyColors.black2),
    );
  }

  _secretItemorAnsweredBuilder(InquiryModel inquiryModel) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          // SizedBox(height: 20),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  inquiryModel.content!,
                  style: MyTextStyles.f14.copyWith(color: MyColors.grey2),
                ),
              ),
              SizedBox(width: 10),
              if (inquiryModel.isSecret! && !inquiryModel.isMine!)
                Image.asset(
                  'assets/shared_images_icons/ic_lock.png',
                  width: 14,
                )
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: [
              _AnswerTextBuilder(inquiryModel.isAnswer!),
              _verticalDivider(),
              Text(
                inquiryModel.writer!,
                style: MyTextStyles.f12.copyWith(color: MyColors.grey10),
              ),
              _verticalDivider(),
              Text(
                inquiryModel.createdAt.toString(),
                style: MyTextStyles.f12.copyWith(color: MyColors.grey10),
              )
            ],
          ),
          SizedBox(height: 20),
          inquiryModel.isAnswer! ? _answer(inquiryModel) : SizedBox.shrink(),

          Divider(
            color: MyColors.grey3,
          ),
          // Container(width: double.infinity, height: 2, color: MyColors.grey1),
        ],
      ),
    );
  }

  _notSecretItemBuilder(InquiryModel inquiryModel) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Container(
          //   child: Theme(
          //     data: ThemeData().copyWith(dividerColor: Colors.transparent),
          //     child: ExpansionTile(
          //       childrenPadding: EdgeInsets.only(top: 10),
          //       tilePadding: EdgeInsets.all(15),
          //       title: _questionTitle(inquiryModel),
          //       children: [
          //         Container(
          //           color: MyColors.grey3,
          //           child: Padding(
          //             padding: const EdgeInsets.all(8.0),
          //             child: Column(
          //               children: [
          //                 _question(inquiryModel),
          //                 SizedBox(height: 20),
          //                 _answer(inquiryModel),
          //               ],
          //             ),
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
          _questionTitle(inquiryModel),
          // _question(inquiryModel),
          SizedBox(height: 20),
          _answer(inquiryModel),
          Divider(
            color: MyColors.grey3,
          )
        ],
      ),
    );
  }
}
