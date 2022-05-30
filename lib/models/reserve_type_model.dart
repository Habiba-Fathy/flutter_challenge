class ReserveTypeModel {
  int? id;
  String? name;
  int? count;
  int? price;

  ReserveTypeModel({
    this.id,
    this.name,
    this.count,
    this.price,
  });

  ReserveTypeModel.fromMap(Map<String, dynamic> json) {}
}
