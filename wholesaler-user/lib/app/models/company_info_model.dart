class CompanyInfoModel {
  CompanyInfoModel({
    this.name,
    this.owner,
    this.addr,
    this.companyNum,
    this.companyLawNum,
    this.callNum});

  CompanyInfoModel.fromJson(dynamic json) {
    name = json['name'];
    owner = json['ceo'];
    addr = json['address'];
    companyNum = json['registration_number'];
    companyLawNum = json['main_order_business'];
    callNum = json['number'];
  }

  String? name;
  String? owner;
  String? addr;
  String?companyNum;
  String?companyLawNum;
  String? callNum;
}