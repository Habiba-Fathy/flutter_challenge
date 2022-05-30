import 'package:flutter_challenge/models/reserve_type_model.dart';

class DataModel {
  int? id;
  String? title;
  List<String>? images;
  String? interest;
  num? price;
  String? date;
  String? address;
  String? trainerName;
  String? trainerImg;
  String? trainerInfo;
  String? occasionDetail;
  String? latitude;
  String? longitude;
  bool? isLiked;
  bool? isSold;
  bool? isPrivateEvent;
  bool? hiddenCashPayment;
  int? specialForm;
  String? questionnaire;
  String? quesExplanation;
  List<ReserveTypeModel>? reserveTypes;

  DataModel({
    this.id,
    this.title,
    this.images,
    this.interest,
    this.price,
    this.date,
    this.address,
    this.trainerName,
    this.trainerImg,
    this.trainerInfo,
    this.occasionDetail,
    this.latitude,
    this.longitude,
    this.isLiked,
    this.isSold,
    this.isPrivateEvent,
    this.hiddenCashPayment,
    this.specialForm,
    this.questionnaire,
    this.quesExplanation,
    this.reserveTypes,
  });

  DataModel.fromMap(Map<String, dynamic> json) {}
}
