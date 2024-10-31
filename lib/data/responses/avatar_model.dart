import 'package:realorfake/data/responses/api_responses.dart';

class AvatarModel implements Serializable {
  String? male;
  String? female;

  AvatarModel({
    this.male,
    this.female,
  });

  factory AvatarModel.fromJson(Map<String, dynamic> json) => AvatarModel(
        male: json["male"],
        female: json["female"],
      );
}
