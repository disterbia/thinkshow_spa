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
  static const int ACCESSORIES = 1;
  static const int BAG = 2;
  static const int SHOES = 3;
  static const int OUTER = 4;
  static const int TOP = 5;
  static const int PANTS = 6;
  static const int SKIRTS = 7;
  static const int ONE_PIECE = 8;
  static const int SET = 9;
  static const int STYLEING = 10;
}

class ClothSubCategoryEnum {
  static const int SOX = 11;
  static const int STOCKING = 12;
  static const int NECKLACE = 13;
  static const int EARRING = 14;
  static const int HAT = 15;
  static const int HAIRBAND = 16;
  static const int HAIRPIN = 17;
  static const int HAIRSCRUNCH = 18;
  static const int BELT = 19;
  static const int CLOCK = 20;

  static const int MUFFLER = 21;
  static const int GLOVES = 22;
  static const int INNER_TOP = 23;
  static const int INNER_PANTS = 24;
  static const int BAGPACK = 25;
  static const int SHOULDERBAG = 26;
  static const int CROSSBAG = 27;
  static const int TOTEBAG = 28;
  static const int ECHOBAG = 29;
  static const int SANDALS = 30;

  static const int FLAT = 31;
  static const int LOAFER = 32;
  static const int BOOTS = 33;
  static const int HELL = 34;
  static const int SNEAKERS = 35;
  static const int COAT = 36;
  static const int JACKET = 37;
  static const int JUMPER = 38;
  static const int CARDIGAN = 39;
  static const int PER = 40;

  static const int OUTER_BEST = 41;
  static const int TSHIRT = 42;
  static const int SHIRT = 43;
  static const int KNITWEAR = 44;
  static const int MTOM = 45;
  static const int HOODIE = 46;
  static const int BUSTIER = 47;
  static const int TOP_BEST = 48;
  static const int SLACKS = 49;
  static const int COTTONPANTS = 50;

  static const int DENIM = 51;
  static const int TRAINING = 52;
  static const int SHORTS = 53;
  static const int MINISKIRT = 54;
  static const int MIDISKIRT = 55;
  static const int LONGSKIRT = 56;
  static const int MINIONE = 57;
  static const int MIDIONE = 58;
  static const int LONGONE = 59;
  static const int JUMB = 60;

  static const int SKIRTSSET = 61;
  static const int PANTSSET = 62;
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
