class ServiceCenterModel {
  ServiceCenterModel({
    this.number,
    this.telephoneConsultationTime,
    this.chatConsultationTime,
    this.kakaoLink,});

  ServiceCenterModel.fromJson(dynamic json) {
    number = json['number'];
    telephoneConsultationTime = json['telephone_consultation_time'];
    chatConsultationTime = json['chat_consultation_time'];
    kakaoLink = json['kakao_link'];
  }

  String? number;
  String? telephoneConsultationTime;
  String? chatConsultationTime;
  String? kakaoLink;
}