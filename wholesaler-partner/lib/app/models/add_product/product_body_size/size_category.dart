import 'package:wholesaler_partner/app/constant/enums.dart';
import 'package:wholesaler_partner/app/models/add_product/product_body_size/size_child.dart';

class SizeCategory {
  int seunghanTestValue;
  List<SizeChild> children;
  SizeCategory({
    required this.children,
    required this.seunghanTestValue,
  });

  static SizeCategory SOX = SizeCategory(
    seunghanTestValue: ClothSubCategoryEnum.SOX,
    children: [SizeChild.entrance_cross_length, SizeChild.total_entry_length],
  );

  static SizeCategory STOCKING = SizeCategory(
    seunghanTestValue: ClothSubCategoryEnum.STOCKING,
    children: [SizeChild.waist_cross_length, SizeChild.total_entry_length],
  );
  static SizeCategory NECKLACE = SizeCategory(
    seunghanTestValue: ClothSubCategoryEnum.NECKLACE,
    children: [SizeChild.breadth, SizeChild.total_entry_length],
  );
  static SizeCategory EARRING = SizeCategory(
    seunghanTestValue: ClothSubCategoryEnum.EARRING,
    children: [SizeChild.diameter, SizeChild.total_entry_length],
  );
  static SizeCategory HAT = SizeCategory(
    seunghanTestValue: ClothSubCategoryEnum.HAT,
    children: [SizeChild.entrance_cross_length, SizeChild.total_entry_length],
  );
  static SizeCategory HAIRBAND = SizeCategory(
    seunghanTestValue: ClothSubCategoryEnum.HAIRBAND,
    children: [SizeChild.breadth, SizeChild.total_entry_length],
  );
  static SizeCategory HAIRPIN = SizeCategory(
    seunghanTestValue: ClothSubCategoryEnum.HAIRPIN,
    children: [SizeChild.breadth, SizeChild.width, SizeChild.height],
  );
  static SizeCategory HAIRSCRUNCH = SizeCategory(
    seunghanTestValue: ClothSubCategoryEnum.HAIRSCRUNCH,
    children: [SizeChild.diameter],
  );
  static SizeCategory BELT = SizeCategory(
    seunghanTestValue: ClothSubCategoryEnum.BELT,
    children: [SizeChild.breadth, SizeChild.total_entry_length],
  );
  static SizeCategory CLOCK = SizeCategory(
    seunghanTestValue: ClothSubCategoryEnum.CLOCK,
    children: [
      SizeChild.diameter,
      SizeChild.breadth,
      SizeChild.total_entry_length
    ],
  );

  static SizeCategory MUFFLER = SizeCategory(
    seunghanTestValue: ClothSubCategoryEnum.MUFFLER,
    children: [SizeChild.breadth, SizeChild.total_entry_length],
  );
  static SizeCategory GLOVES = SizeCategory(
    seunghanTestValue: ClothSubCategoryEnum.GLOVES,
    children: [SizeChild.entrance_cross_length, SizeChild.total_entry_length],
  );
  static SizeCategory INNER_TOP = SizeCategory(
    seunghanTestValue: ClothSubCategoryEnum.INNER_TOP,
    children: [SizeChild.chest_cross_length, SizeChild.total_entry_length],
  );
  static SizeCategory INNER_PANTS = SizeCategory(
    seunghanTestValue: ClothSubCategoryEnum.INNER_PANTS,
    children: [SizeChild.waist_cross_length, SizeChild.total_entry_length],
  );
  //가방
  static SizeCategory BAGPACK = SizeCategory(
    seunghanTestValue: ClothSubCategoryEnum.BAGPACK,
    children: [
      SizeChild.width,
      SizeChild.height,
      SizeChild.breadth,
      SizeChild.handle_height,
      SizeChild.handle_length
    ],
  );
  static SizeCategory SHOULDERBAG = SizeCategory(
    seunghanTestValue: ClothSubCategoryEnum.SHOULDERBAG,
    children: [
      SizeChild.width,
      SizeChild.height,
      SizeChild.breadth,
      SizeChild.handle_height,
      SizeChild.handle_length
    ],
  );
  static SizeCategory CROSSBAG = SizeCategory(
    seunghanTestValue: ClothSubCategoryEnum.CROSSBAG,
    children: [
      SizeChild.width,
      SizeChild.height,
      SizeChild.breadth,
      SizeChild.handle_height,
      SizeChild.handle_length
    ],
  );
  static SizeCategory TOTEBAG = SizeCategory(
    seunghanTestValue: ClothSubCategoryEnum.TOTEBAG,
    children: [
      SizeChild.width,
      SizeChild.height,
      SizeChild.breadth,
      SizeChild.handle_height,
      SizeChild.handle_length
    ],
  );
  static SizeCategory ECHOBAG = SizeCategory(
    seunghanTestValue: ClothSubCategoryEnum.ECHOBAG,
    children: [
      SizeChild.width,
      SizeChild.height,
      SizeChild.breadth,
      SizeChild.handle_height,
      SizeChild.handle_length
    ],
  );
  //신발
  static SizeCategory SANDALS = SizeCategory(
    seunghanTestValue: ClothSubCategoryEnum.SANDALS,
    children: [
      SizeChild.front_heel_height,
      SizeChild.back_heel_height,
      SizeChild.foot_width
    ],
  );
  static SizeCategory FLAT = SizeCategory(
    seunghanTestValue: ClothSubCategoryEnum.FLAT,
    children: [
      SizeChild.front_heel_height,
      SizeChild.back_heel_height,
      SizeChild.foot_width
    ],
  );
  static SizeCategory LOAFER = SizeCategory(
    seunghanTestValue: ClothSubCategoryEnum.LOAFER,
    children: [
      SizeChild.front_heel_height,
      SizeChild.back_heel_height,
      SizeChild.foot_width
    ],
  );
  static SizeCategory BOOTS = SizeCategory(
    seunghanTestValue: ClothSubCategoryEnum.BOOTS,
    children: [
      SizeChild.front_heel_height,
      SizeChild.back_heel_height,
      SizeChild.foot_width,
      SizeChild.entrance_cross_length,
      SizeChild.calf_cross_length,
      SizeChild.height
    ],
  );
  static SizeCategory HELL = SizeCategory(
    seunghanTestValue: ClothSubCategoryEnum.HELL,
    children: [
      SizeChild.front_heel_height,
      SizeChild.back_heel_height,
      SizeChild.foot_width
    ],
  );
  static SizeCategory SNEAKERS = SizeCategory(
    seunghanTestValue: ClothSubCategoryEnum.SNEAKERS,
    children: [
      SizeChild.front_heel_height,
      SizeChild.back_heel_height,
      SizeChild.foot_width
    ],
  );
  //아우터
  static SizeCategory COAT = SizeCategory(
    seunghanTestValue: ClothSubCategoryEnum.COAT,
    children: [
      SizeChild.shoulder_cross_length,
      SizeChild.chest_cross_length,
      SizeChild.armhole,
      SizeChild.arm_straight_length,
      SizeChild.arm_cross_length,
      SizeChild.sleeve_cross_length,
      SizeChild.total_entry_length,
      SizeChild.lining,
      SizeChild.weight
    ],
  );
  static SizeCategory JACKET = SizeCategory(
    seunghanTestValue: ClothSubCategoryEnum.JACKET,
    children: [
      SizeChild.shoulder_cross_length,
      SizeChild.chest_cross_length,
      SizeChild.armhole,
      SizeChild.arm_straight_length,
      SizeChild.arm_cross_length,
      SizeChild.sleeve_cross_length,
      SizeChild.total_entry_length,
      SizeChild.lining,
      SizeChild.weight
    ],
  );
  static SizeCategory JUMPER = SizeCategory(
    seunghanTestValue: ClothSubCategoryEnum.JUMPER,
    children: [
      SizeChild.shoulder_cross_length,
      SizeChild.chest_cross_length,
      SizeChild.armhole,
      SizeChild.arm_straight_length,
      SizeChild.arm_cross_length,
      SizeChild.sleeve_cross_length,
      SizeChild.total_entry_length,
      SizeChild.lining,
      SizeChild.weight
    ],
  );
  static SizeCategory CARDIGAN = SizeCategory(
    seunghanTestValue: ClothSubCategoryEnum.CARDIGAN,
    children: [
      SizeChild.shoulder_cross_length,
      SizeChild.chest_cross_length,
      SizeChild.armhole,
      SizeChild.arm_straight_length,
      SizeChild.arm_cross_length,
      SizeChild.sleeve_cross_length,
      SizeChild.total_entry_length,
      SizeChild.lining,
      SizeChild.weight
    ],
  );
  static SizeCategory PER = SizeCategory(
    seunghanTestValue: ClothSubCategoryEnum.PER,
    children: [
      SizeChild.shoulder_cross_length,
      SizeChild.chest_cross_length,
      SizeChild.armhole,
      SizeChild.arm_straight_length,
      SizeChild.arm_cross_length,
      SizeChild.sleeve_cross_length,
      SizeChild.total_entry_length,
      SizeChild.lining,
      SizeChild.weight
    ],
  );

  static SizeCategory OUTER_BEST = SizeCategory(
    seunghanTestValue: ClothSubCategoryEnum.OUTER_BEST,
    children: [
      SizeChild.shoulder_cross_length,
      SizeChild.chest_cross_length,
      SizeChild.armhole,
      SizeChild.arm_straight_length,
      SizeChild.arm_cross_length,
      SizeChild.sleeve_cross_length,
      SizeChild.total_entry_length,
      SizeChild.lining,
      SizeChild.weight
    ],
  );
  static SizeCategory TSHIRT = SizeCategory(
    seunghanTestValue: ClothSubCategoryEnum.TSHIRT,
    children: [
      SizeChild.shoulder_cross_length,
      SizeChild.chest_cross_length,
      SizeChild.armhole,
      SizeChild.arm_straight_length,
      SizeChild.arm_cross_length,
      SizeChild.sleeve_cross_length,
      SizeChild.total_entry_length,
      SizeChild.lining,
      SizeChild.weight
    ],
  );
  static SizeCategory SHIRT = SizeCategory(
    seunghanTestValue: ClothSubCategoryEnum.SHIRT,
    children: [
      SizeChild.shoulder_cross_length,
      SizeChild.chest_cross_length,
      SizeChild.armhole,
      SizeChild.arm_straight_length,
      SizeChild.arm_cross_length,
      SizeChild.sleeve_cross_length,
      SizeChild.total_entry_length,
      SizeChild.lining,
      SizeChild.weight
    ],
  );
  static SizeCategory KNITWEAR = SizeCategory(
    seunghanTestValue: ClothSubCategoryEnum.KNITWEAR,
    children: [
      SizeChild.shoulder_cross_length,
      SizeChild.chest_cross_length,
      SizeChild.armhole,
      SizeChild.arm_straight_length,
      SizeChild.arm_cross_length,
      SizeChild.sleeve_cross_length,
      SizeChild.total_entry_length,
      SizeChild.lining,
      SizeChild.weight
    ],
  );
  static SizeCategory MTOM = SizeCategory(
    seunghanTestValue: ClothSubCategoryEnum.MTOM,
    children: [
      SizeChild.shoulder_cross_length,
      SizeChild.chest_cross_length,
      SizeChild.armhole,
      SizeChild.arm_straight_length,
      SizeChild.arm_cross_length,
      SizeChild.sleeve_cross_length,
      SizeChild.total_entry_length,
      SizeChild.lining,
      SizeChild.weight
    ],
  );
  static SizeCategory HOODIE = SizeCategory(
    seunghanTestValue: ClothSubCategoryEnum.HOODIE,
    children: [
      SizeChild.shoulder_cross_length,
      SizeChild.chest_cross_length,
      SizeChild.armhole,
      SizeChild.arm_straight_length,
      SizeChild.arm_cross_length,
      SizeChild.sleeve_cross_length,
      SizeChild.total_entry_length,
      SizeChild.lining,
      SizeChild.weight
    ],
  );
  static SizeCategory BUSTIER = SizeCategory(
    seunghanTestValue: ClothSubCategoryEnum.BUSTIER,
    children: [
      SizeChild.shoulder_cross_length,
      SizeChild.chest_cross_length,
      SizeChild.armhole,
      SizeChild.total_entry_length,
      SizeChild.lining,
    ],
  );
  static SizeCategory TOP_BEST = SizeCategory(
    seunghanTestValue: ClothSubCategoryEnum.TOP_BEST,
    children: [
      SizeChild.shoulder_cross_length,
      SizeChild.chest_cross_length,
      SizeChild.armhole,
      SizeChild.arm_straight_length,
      SizeChild.arm_cross_length,
      SizeChild.sleeve_cross_length,
      SizeChild.total_entry_length,
      SizeChild.lining,
      SizeChild.weight
    ],
  );

  //바지
  static SizeCategory SLACKS = SizeCategory(
    seunghanTestValue: ClothSubCategoryEnum.SLACKS,
    children: [
      SizeChild.waist_cross_length,
      SizeChild.hip_cross_length,
      SizeChild.thigh_cross_length,
      SizeChild.bottom_top_cross_length,
      SizeChild.bottom_cross_length,
      SizeChild.total_entry_length,
      SizeChild.lining
    ],
  );
  static SizeCategory COTTONPANTS = SizeCategory(
    seunghanTestValue: ClothSubCategoryEnum.COTTONPANTS,
    children: [
      SizeChild.waist_cross_length,
      SizeChild.hip_cross_length,
      SizeChild.thigh_cross_length,
      SizeChild.bottom_top_cross_length,
      SizeChild.bottom_cross_length,
      SizeChild.total_entry_length,
      SizeChild.lining
    ],
  );
  static SizeCategory DENIM = SizeCategory(
    seunghanTestValue: ClothSubCategoryEnum.DENIM,
    children: [
      SizeChild.waist_cross_length,
      SizeChild.hip_cross_length,
      SizeChild.thigh_cross_length,
      SizeChild.bottom_top_cross_length,
      SizeChild.bottom_cross_length,
      SizeChild.total_entry_length,
      SizeChild.lining
    ],
  );
  static SizeCategory TRAINING = SizeCategory(
    seunghanTestValue: ClothSubCategoryEnum.TRAINING,
    children: [
      SizeChild.waist_cross_length,
      SizeChild.hip_cross_length,
      SizeChild.thigh_cross_length,
      SizeChild.bottom_top_cross_length,
      SizeChild.bottom_cross_length,
      SizeChild.total_entry_length,
      SizeChild.lining
    ],
  );
  static SizeCategory SHORTS = SizeCategory(
    seunghanTestValue: ClothSubCategoryEnum.SHORTS,
    children: [
      SizeChild.waist_cross_length,
      SizeChild.hip_cross_length,
      SizeChild.thigh_cross_length,
      SizeChild.bottom_top_cross_length,
      SizeChild.bottom_cross_length,
      SizeChild.total_entry_length,
      SizeChild.lining
    ],
  );

  //치마
  static SizeCategory MINISKIRT = SizeCategory(
    seunghanTestValue: ClothSubCategoryEnum.MINISKIRT,
    children: [
      SizeChild.waist_cross_length,
      SizeChild.hip_cross_length,
      SizeChild.bottom_top_cross_length,
      SizeChild.total_entry_length,
      SizeChild.lining
    ],
  );
  static SizeCategory MIDISKIRT = SizeCategory(
    seunghanTestValue: ClothSubCategoryEnum.MIDISKIRT,
    children: [
      SizeChild.waist_cross_length,
      SizeChild.hip_cross_length,
      SizeChild.bottom_top_cross_length,
      SizeChild.total_entry_length,
      SizeChild.lining
    ],
  );
  static SizeCategory LONGSKIRT = SizeCategory(
    seunghanTestValue: ClothSubCategoryEnum.LONGSKIRT,
    children: [
      SizeChild.waist_cross_length,
      SizeChild.hip_cross_length,
      SizeChild.bottom_top_cross_length,
      SizeChild.total_entry_length,
      SizeChild.lining
    ],
  );
  //원피스
  static SizeCategory MINIONE = SizeCategory(
    seunghanTestValue: ClothSubCategoryEnum.MIDIONE,
    children: [
      SizeChild.shoulder_cross_length,
      SizeChild.chest_cross_length,
      SizeChild.armhole,
      SizeChild.arm_straight_length,
      SizeChild.arm_cross_length,
      SizeChild.waist_cross_length,
      SizeChild.hip_cross_length,
      SizeChild.bottom_cross_length,
      SizeChild.total_entry_length,
      SizeChild.lining
    ],
  );
  static SizeCategory MIDIONE = SizeCategory(
    seunghanTestValue: ClothSubCategoryEnum.MIDIONE,
    children: [
      SizeChild.shoulder_cross_length,
      SizeChild.chest_cross_length,
      SizeChild.armhole,
      SizeChild.arm_straight_length,
      SizeChild.arm_cross_length,
      SizeChild.waist_cross_length,
      SizeChild.hip_cross_length,
      SizeChild.bottom_cross_length,
      SizeChild.total_entry_length,
      SizeChild.lining
    ],
  );
  static SizeCategory LONGONE = SizeCategory(
    seunghanTestValue: ClothSubCategoryEnum.LONGONE,
    children: [
      SizeChild.shoulder_cross_length,
      SizeChild.chest_cross_length,
      SizeChild.armhole,
      SizeChild.arm_straight_length,
      SizeChild.arm_cross_length,
      SizeChild.waist_cross_length,
      SizeChild.hip_cross_length,
      SizeChild.bottom_cross_length,
      SizeChild.total_entry_length,
      SizeChild.lining
    ],
  );
  static SizeCategory JUMB = SizeCategory(
    seunghanTestValue: ClothSubCategoryEnum.JUMB,
    children: [
      SizeChild.shoulder_cross_length,
      SizeChild.chest_cross_length,
      SizeChild.armhole,
      SizeChild.arm_straight_length,
      SizeChild.arm_cross_length,
      SizeChild.waist_cross_length,
      SizeChild.hip_cross_length,
      SizeChild.bottom_top_cross_length,
      SizeChild.total_entry_length,
      SizeChild.lining
    ],
  );

  //치마셋
  static SizeCategory SKIRTSSET = SizeCategory(
    seunghanTestValue: ClothSubCategoryEnum.SKIRTSSET,
    children: [
      SizeChild.shoulder_cross_length,
      SizeChild.chest_cross_length,
      SizeChild.armhole,
      SizeChild.arm_straight_length,
      SizeChild.arm_cross_length,
      SizeChild.sleeve_cross_length,
      SizeChild.total_entry_length,
      SizeChild.lining,
      SizeChild.waist_cross_length,
      SizeChild.hip_cross_length,
      SizeChild.bottom_cross_length,
      SizeChild.total_entry_length,
      SizeChild.lining
    ],
  );
  //바지셋
  static SizeCategory PANTSSET = SizeCategory(
    seunghanTestValue: ClothSubCategoryEnum.PANTSSET,
    children: [
      SizeChild.shoulder_cross_length,
      SizeChild.chest_cross_length,
      SizeChild.armhole,
      SizeChild.arm_straight_length,
      SizeChild.arm_cross_length,
      SizeChild.sleeve_cross_length,
      SizeChild.total_entry_length,
      SizeChild.lining,
      SizeChild.waist_cross_length,
      SizeChild.hip_cross_length,
      SizeChild.thigh_cross_length,
      SizeChild.bottom_top_cross_length,
      SizeChild.bottom_cross_length,
      SizeChild.total_entry_length,
      SizeChild.lining
    ],
  );
  // static SizeCategory OUTER = SizeCategory(
  //   seunghanTestValue: ClothMainCategoryEnum.OUTER,
  //   children: [
  //     SizeChild.chest_cross_length,
  //     SizeChild.arm_straight_length,
  //     SizeChild.arm_cross_length,
  //     SizeChild.sleeve_cross_length,
  //     SizeChild.bottom_cross_length,
  //     SizeChild.open,
  //     SizeChild.total_entry_length,
  //   ],
  // );

  // //   ClothMainCategoryEnum.TOP: ['어깨간면', '가슴단면', '암홀', '팔기장', '팔단면', '소매단면', '밑단단면', '총기장'],
  // static SizeCategory TOP = SizeCategory(
  //   seunghanTestValue: ClothMainCategoryEnum.TOP,
  //   children: [
  //     SizeChild.shoulder_cross_length,
  //     SizeChild.chest_cross_length,
  //     SizeChild.armhole,
  //     SizeChild.arm_straight_length,
  //     SizeChild.arm_cross_length,
  //     SizeChild.sleeve_cross_length,
  //     SizeChild.bottom_cross_length,
  //     SizeChild.total_entry_length,
  //   ],
  // );

  // //   ClothMainCategoryEnum.PANTS: ['허리단면', '엉덩이단면', '밑위단면', '허벅지단면', '밑단단면', '총기장'],
  // static SizeCategory PANTS = SizeCategory(
  //   seunghanTestValue: ClothMainCategoryEnum.PANTS,
  //   children: [
  //     SizeChild.waist_cross_length,
  //     SizeChild.hip_cross_length,
  //     SizeChild.bottom_top_cross_length,
  //     SizeChild.thigh_cross_length,
  //     SizeChild.bottom_cross_length,
  //     SizeChild.total_entry_length,
  //   ],
  // );

  // //   ClothMainCategoryEnum.SKIRTS: ['허리단면', '엉덩이단면', '밑단단면', '트임', '안감', '총기장'],
  // static SizeCategory SKIRTS = SizeCategory(
  //   seunghanTestValue: ClothMainCategoryEnum.SKIRTS,
  //   children: [
  //     SizeChild.waist_cross_length,
  //     SizeChild.hip_cross_length,
  //     SizeChild.bottom_cross_length,
  //     SizeChild.strap,
  //     SizeChild.armhole,
  //     SizeChild.total_entry_length,
  //   ],
  // );

  // //   ClothMainCategoryEnum.ONE_PIECE: ['어깨간면', '가슴단면', '암홀', '팔기장', '팔단면', '소매단면', '밑단단면', '스트랩', '총기장'],
  // static SizeCategory ONE_PIECE = SizeCategory(
  //   seunghanTestValue: ClothMainCategoryEnum.ONE_PIECE,
  //   children: [
  //     SizeChild.shoulder_cross_length,
  //     SizeChild.chest_cross_length,
  //     SizeChild.armhole,
  //     SizeChild.arm_straight_length,
  //     SizeChild.arm_cross_length,
  //     SizeChild.sleeve_cross_length,
  //     SizeChild.bottom_cross_length,
  //     SizeChild.strap,
  //     SizeChild.total_entry_length,
  //   ],
  // );

  // //   ClothMainCategoryEnum.SET: ['어깨간면 SET', '가슴단면', '암홀', '허리단면', '엉덩이단면', '허벅지단면', '밑위길이/미단길이', '총'],
  // static SizeCategory SET = SizeCategory(
  //   seunghanTestValue: ClothMainCategoryEnum.SET,
  //   children: [
  //     SizeChild.shoulder_cross_length,
  //     SizeChild.chest_cross_length,
  //     SizeChild.armhole,
  //     SizeChild.waist_cross_length,
  //     SizeChild.hip_cross_length,
  //     SizeChild.bottom_top_cross_length,
  //     SizeChild.thigh_cross_length,
  //     SizeChild.bottom_cross_length,
  //     SizeChild.total_entry_length,
  //   ],
  // );

  static SizeCategory getWithCatId(int catId) {
    // if (catId == ClothMainCategoryEnum.OUTER) {
    //   return SizeCategory.OUTER;
    // }
    // if (catId == ClothMainCategoryEnum.TOP) {
    //   return SizeCategory.TOP;
    // }
    // if (catId == ClothMainCategoryEnum.PANTS) {
    //   return SizeCategory.PANTS;
    // }
    // if (catId == ClothMainCategoryEnum.SKIRTS) {
    //   return SizeCategory.SKIRTS;
    // }
    // if (catId == ClothMainCategoryEnum.ONE_PIECE) {
    //   return SizeCategory.ONE_PIECE;
    // }
    // if (catId == ClothMainCategoryEnum.SET) {
    //   return SizeCategory.SET;
    // }

    if (catId == ClothSubCategoryEnum.SOX) {
      return SizeCategory.SOX;
    }
    if (catId == ClothSubCategoryEnum.STOCKING) {
      return SizeCategory.STOCKING;
    }
    if (catId == ClothSubCategoryEnum.NECKLACE) {
      return SizeCategory.NECKLACE;
    }
    if (catId == ClothSubCategoryEnum.EARRING) {
      return SizeCategory.EARRING;
    }
    if (catId == ClothSubCategoryEnum.HAT) {
      return SizeCategory.HAT;
    }
    if (catId == ClothSubCategoryEnum.HAIRBAND) {
      return SizeCategory.HAIRBAND;
    }
    if (catId == ClothSubCategoryEnum.HAIRPIN) {
      return SizeCategory.HAIRPIN;
    }
    if (catId == ClothSubCategoryEnum.HAIRSCRUNCH) {
      return SizeCategory.HAIRSCRUNCH;
    }
    if (catId == ClothSubCategoryEnum.BELT) {
      return SizeCategory.BELT;
    }
    if (catId == ClothSubCategoryEnum.CLOCK) {
      return SizeCategory.CLOCK;
    }

    if (catId == ClothSubCategoryEnum.MUFFLER) {
      return SizeCategory.MUFFLER;
    }
    if (catId == ClothSubCategoryEnum.GLOVES) {
      return SizeCategory.GLOVES;
    }
    if (catId == ClothSubCategoryEnum.INNER_TOP) {
      return SizeCategory.INNER_TOP;
    }
    if (catId == ClothSubCategoryEnum.INNER_PANTS) {
      return SizeCategory.INNER_PANTS;
    }
    if (catId == ClothSubCategoryEnum.BAGPACK) {
      return SizeCategory.BAGPACK;
    }
    if (catId == ClothSubCategoryEnum.SHOULDERBAG) {
      return SizeCategory.SHOULDERBAG;
    }
    if (catId == ClothSubCategoryEnum.CROSSBAG) {
      return SizeCategory.CROSSBAG;
    }
    if (catId == ClothSubCategoryEnum.TOTEBAG) {
      return SizeCategory.TOTEBAG;
    }
    if (catId == ClothSubCategoryEnum.ECHOBAG) {
      return SizeCategory.ECHOBAG;
    }
    if (catId == ClothSubCategoryEnum.SANDALS) {
      return SizeCategory.SANDALS;
    }

    if (catId == ClothSubCategoryEnum.FLAT) {
      return SizeCategory.FLAT;
    }
    if (catId == ClothSubCategoryEnum.LOAFER) {
      return SizeCategory.LOAFER;
    }
    if (catId == ClothSubCategoryEnum.BOOTS) {
      return SizeCategory.BOOTS;
    }
    if (catId == ClothSubCategoryEnum.HELL) {
      return SizeCategory.HELL;
    }
    if (catId == ClothSubCategoryEnum.SNEAKERS) {
      return SizeCategory.SNEAKERS;
    }
    if (catId == ClothSubCategoryEnum.COAT) {
      return SizeCategory.COAT;
    }
    if (catId == ClothSubCategoryEnum.JACKET) {
      return SizeCategory.JACKET;
    }
    if (catId == ClothSubCategoryEnum.JUMPER) {
      return SizeCategory.JUMPER;
    }
    if (catId == ClothSubCategoryEnum.CARDIGAN) {
      return SizeCategory.CARDIGAN;
    }
    if (catId == ClothSubCategoryEnum.PER) {
      return SizeCategory.PER;
    }

    if (catId == ClothSubCategoryEnum.OUTER_BEST) {
      return SizeCategory.OUTER_BEST;
    }
    if (catId == ClothSubCategoryEnum.TSHIRT) {
      return SizeCategory.TSHIRT;
    }
    if (catId == ClothSubCategoryEnum.SHIRT) {
      return SizeCategory.SHIRT;
    }
    if (catId == ClothSubCategoryEnum.KNITWEAR) {
      return SizeCategory.KNITWEAR;
    }
    if (catId == ClothSubCategoryEnum.MTOM) {
      return SizeCategory.MTOM;
    }
    if (catId == ClothSubCategoryEnum.HOODIE) {
      return SizeCategory.HOODIE;
    }
    if (catId == ClothSubCategoryEnum.BUSTIER) {
      return SizeCategory.BUSTIER;
    }
    if (catId == ClothSubCategoryEnum.TOP_BEST) {
      return SizeCategory.TOP_BEST;
    }
    if (catId == ClothSubCategoryEnum.SLACKS) {
      return SizeCategory.SLACKS;
    }
    if (catId == ClothSubCategoryEnum.COTTONPANTS) {
      return SizeCategory.COTTONPANTS;
    }

    if (catId == ClothSubCategoryEnum.DENIM) {
      return SizeCategory.DENIM;
    }
    if (catId == ClothSubCategoryEnum.TRAINING) {
      return SizeCategory.TRAINING;
    }
    if (catId == ClothSubCategoryEnum.SHORTS) {
      return SizeCategory.SHORTS;
    }
    if (catId == ClothSubCategoryEnum.MINISKIRT) {
      return SizeCategory.MINISKIRT;
    }
    if (catId == ClothSubCategoryEnum.MIDISKIRT) {
      return SizeCategory.MIDISKIRT;
    }
    if (catId == ClothSubCategoryEnum.LONGSKIRT) {
      return SizeCategory.LONGSKIRT;
    }
    if (catId == ClothSubCategoryEnum.MINIONE) {
      return SizeCategory.MINIONE;
    }
    if (catId == ClothSubCategoryEnum.MIDIONE) {
      return SizeCategory.MIDIONE;
    }
    if (catId == ClothSubCategoryEnum.LONGONE) {
      return SizeCategory.LONGONE;
    }
    if (catId == ClothSubCategoryEnum.JUMB) {
      return SizeCategory.JUMB;
    }

    if (catId == ClothSubCategoryEnum.SKIRTSSET) {
      return SizeCategory.SKIRTSSET;
    }
    if (catId == ClothSubCategoryEnum.PANTSSET) {
      return SizeCategory.PANTSSET;
    }

    return SizeCategory(
      children: [],
      seunghanTestValue: -1,
    );
  }
}
