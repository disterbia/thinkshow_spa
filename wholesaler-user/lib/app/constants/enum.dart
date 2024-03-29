enum FindIDPasswordTabIndex {
  findID,
  findPassword,
}

enum UserHomeTabs {
  home,
  best,
  newProduct,
  dingdong,
  dingPick,
}

enum UseBottomNavTabs {
  home,
  store,
  moabogi,
  favorites,
  my_page,
}

/// show rating as number. ex: 4.5. Or show rating as star icon
enum ProductRatingType {
  number,
  star,
}

/// [OrderStatus]
/// 100 → 결제완료
/// 200 → 상품준비중
/// 300 → 배송시작
/// 400 → 배송중
/// 500 → 배송완료
/// 600 → 구매확정
/// 1000 → 주문취소
/// 1100 → 교환신청
/// 1102 → 교환완료
/// 1200 → 반품신청
/// 1205 → 반품완료
class OrderStatus {
  /// 결제완료
  static const int payFinished = 100;

  /// 상품준비중
  static const int preparingProduct = 200;

  /// 배송시작
  static const int deliveryStart = 300;

  /// 배송중
  static const int delivering = 400;

  /// 배송완료
  static const int deliveryFinished = 500;

  /// 구매확정
  static const int deliveryConfirmed = 600;

  /// 주문취소
  static const int cancelOrder = 1000;

  /// 교환신청
  static const int exchangeApply = 1100;

  /// 교환완료
  static const int exchangeFinished = 1102;

  /// 반품신청
  static const int returnApply = 1200;

  /// 반품완료
  static const int returnFinished = 1205;
}

class OrderInquiryPeriod {
  static const String total = 'total';
  static const String threeMonth = '3month';
  static const String oneMonth = '1month';
  static const String during = 'during';
}

/// Cart Select All, item
enum CartCheckboxType {
  selectAllCheckbox,
  productCheckbox,
}

class ProductSizeType {
  static const String shoulder_cross_length = '어깨단면';
  static const String chest_cross_length = '가슴단면';
  static const String armhole = '암홀';
  static const String arm_straight_length = '소매길이';
  static const String arm_cross_length = '소매통단면';
  static const String sleeve_cross_length = '소매끝단';
  static const String bottom_cross_length = '밑단길이';
  static const String strap = '스트랩';
  static const String total_entry_length = '총길이';
  static const String waist_cross_length = '허리단면';
  static const String hip_cross_length = '엉덩이단면';
  static const String bottom_top_cross_length = '밑위길이';
  static const String thigh_cross_length = '허벅지단면';
  static const String open = '트임';
  static const String lining = '안감';

  static const String entrance_cross_length = '입구단면';
  static const String breadth = '폭';
  static const String diameter = '지름';
  static const String width = '가로';
  static const String height = '세로';
  static const String handle_height = '손잡이끈높이';
  static const String handle_length = '끈길이(최대)';
  static const String front_heel_height = '앞굽높이';
  static const String back_heel_height = '뒷굽높이';
  static const String calf_cross_length = '종아리단면';
  static const String weight = '무게';
  static const String foot_width = '발볼넓이';

  static const String necklace_breadth = '팬던트(폭)';
  static const String necklace_total_entry_length = '총길이(연장줄포함)';
  static const String earring_total_entry_length = '침길이';
  static const String clock_diameter = '메달지름';
  static const String clock_breadth = '끈폭넓이';
  static const String total_length = '총장';
  static const String total_length2 = '총장';
  static const String entrace_circum = '입구둘레';
  static const String total_height = '총높이';
  

}

// ProductThicknessType ['thick' or 'middle' or 'thin']
class ProductThicknessType {
  static const String thick = 'thick';
  static const String middle = 'middle';
  static const String thin = 'thin';
}

// ProductSeethroughType ['high' or 'middle' or 'none']
class ProductSeethroughType {
  static const String high = 'high';
  static const String middle = 'middle';
  static const String none = 'none';
}

// ProductFlexibilityType ['high' or 'middle' or'none' or 'banding']
class ProductFlexibilityType {
  static const String high = 'high';
  static const String middle = 'middle';
  static const String none = 'none';
  static const String banding = 'banding';
}

enum ClothCareGuideId {
  handWash,
  dryCleaning,
  waterWash,
  separateWash,
  woolWash,
  noBleach,
  noIron,
  noLaundryMachine,
}

enum PrivacyOrTerms {
  privacy,
  terms,
}
