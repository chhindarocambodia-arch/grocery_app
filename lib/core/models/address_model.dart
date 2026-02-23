// In core/models/address_model.dart
class AddressModel {
  String id;
  String title;
  String fullAddress;
  String? houseNumber;
  String? street;
  String? khan;
  String? sangkat;
  String? note;
  bool isDefault;
  DateTime? createdAt;

  AddressModel({
    required this.id,
    required this.title,
    required this.fullAddress,
    this.houseNumber,
    this.street,
    this.khan,
    this.sangkat,
    this.note,
    this.isDefault = false,
    this.createdAt,
  });
}