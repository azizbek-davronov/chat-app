import 'package:json_annotation/json_annotation.dart';
part 'image_model.g.dart';

@JsonSerializable()
class ImageModel {
  int id;
  String imageUrl;

  ImageModel({
    required this.id,
    required this.imageUrl,
  });

  factory ImageModel.fromJson(Map<String, dynamic> json) =>
      _$ImageModelFromJson(json);

  /// Connect the generated [_$ImageModelToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$ImageModelToJson(this);
}
