enum SalesTab {
  Impressions,
  Clicks,
  Likes,
  Orders,
}

enum AdType {
  R,
  S,
  _1ST,
  _2ST,
  _3ST,
}

enum AdPaymentStatus {
  notPaid,
  paid,
}

enum AdTabs {
  Tab1AdStatus,
  //Tab2AdApplication,
  Tab3AdApplicationHistory,
}

enum BulletinType {
  bulletin,
  ad,
}

/// 회원가입 대표, 직원 건물
enum BuildingType {
  building,
  floor,
  unit,
}

enum ThicknessType {
  thick,
  middle,
  thin,
}

enum SeeThroughType {
  high,
  middle,
  none,
}

enum FlexibilityType {
  high,
  middle,
  none,
  banding,
}

class ProductMgmtButtons {
  static const String restock = '재입고';
  static const String soldout = '품절';
  static const String top10 = 'TOP10';
  static const String dingdong = '띵동';
  static const String delete = '삭제';
}

class ClothMainCategoryEnum {
  static const int ACCESSORIES = 9;
  static const int BAG = 8;
  static const int SHOES = 7;
  static const int OUTER = 2;
  static const int TOP = 1;
  static const int PANTS = 4;
  static const int SKIRTS = 5;
  static const int ONE_PIECE = 3;
  static const int SET = 6;
  // static const int STYLEING = 10;
}

class ClothSubCategoryEnum {
  static const int TSHIRT = 11;
  static const int SHIRT = 12;
  static const int KNITWEAR = 13;
  static const int MTOM = 14;
  static const int HOODIE = 15;
  static const int BUSTIER = 16;
  static const int TOP_BEST = 17;

  static const int COAT = 18;
  static const int JACKET = 19;
  static const int JUMPER = 20;
  static const int CARDIGAN = 21;
  static const int PER = 22;
  static const int OUTER_BEST = 23;

  static const int MINIONE = 24;
  static const int MIDIONE = 25;
  static const int LONGONE = 26;
  static const int JUMB = 27;

  static const int SLACKS = 28;
  static const int COTTONPANTS = 29;
  static const int DENIM = 30;
  static const int TRAINING = 31;
  static const int SHORTS = 32;

  static const int MINISKIRT = 33;
  static const int MIDISKIRT = 34;
  static const int LONGSKIRT = 35;

  static const int SKIRTSSET = 36;
  static const int PANTSSET = 37;

  static const int SANDALS = 38;
  static const int FLAT = 39;
  static const int LOAFER = 40;
  static const int BOOTS = 41;
  static const int HELL = 42;
  static const int SNEAKERS = 43;

  static const int BAGPACK = 44;
  static const int SHOULDERBAG = 45;
  static const int CROSSBAG = 46;
  static const int TOTEBAG = 47;
  static const int ECHOBAG = 48;

  static const int SOX = 49;
  static const int STOCKING = 50;
  static const int NECKLACE = 51;
  static const int EARRING = 52;
  static const int HAT = 53;
  static const int HAIRBAND = 54;
  static const int HAIRPIN = 55;
  static const int HAIRSCRUNCH = 56;
  static const int BELT = 57;
  static const int CLOCK = 58;
  static const int MUFFLER = 59;
  static const int GLOVES = 60;
  static const int INNER_TOP = 61;
  static const int INNER_PANTS = 62;


}

class ProductFilterDates {
  static const String sameDay = '당일';
  static const String oneMonth = '1개월';
  static const String threeMonth = '3개월';
}

class SortProductDropDownItem {
  static const String latest = '최신순';
  static const String bySales = '판매순';
  static const String bySoldout = '품절순';
}
