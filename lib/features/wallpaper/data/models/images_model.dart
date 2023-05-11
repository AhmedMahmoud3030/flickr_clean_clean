import '../../domain/entities/image.dart';

class ImageDataModel extends ImageData {
  const ImageDataModel(
      {required super.id,
      required super.secret,
      required super.server,
      required super.title});

  factory ImageDataModel.fromJson(Map<String, dynamic> json) => ImageDataModel(
        id: json['id'],
        secret: json['secret'],
        server: json['server'],
        title: json['title'],
        // title: '',
      );
}
