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

  DataModel.fromMap(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    images = json['images'];
    if (json["images"] != null) {
      images = [];
      json["images"].forEach(
        (element) => images!.add(
          element,
        ),
      );
    }
    interest = json['interest'];
    price = json['price'];
    date = json['date'];
    address = json['address'];
    trainerName = json['trainerName'];
    trainerImg = json['trainerImg'];
    trainerInfo = json['trainerInfo'];
    occasionDetail = json['occasionDetail'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    isLiked = json['isLiked'];
    isSold = json['isSold'];
    isPrivateEvent = json['isPrivateEvent'];
    hiddenCashPayment = json['hiddenCashPayment'];
    specialForm = json['specialForm'];
    questionnaire = json['questionnaire'];
    quesExplanation = json['questExplanation'];
    if (json["reservTypes"] != null) {
      reserveTypes = [];
      json["reservTypes"].forEach(
        (element) => reserveTypes!.add(
          ReserveTypeModel.fromMap(element),
        ),
      );
    }
  }
}
