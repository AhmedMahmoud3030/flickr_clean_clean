// ignore_for_file: constant_identifier_names

import 'package:dio/dio.dart';
import 'package:flickr_clean/features/wallpaper/data/models/images_model.dart';
import 'package:flickr_clean/features/wallpaper/domain/entities/image.dart';

import '../../../../core/error/exception.dart';
import '../../../../core/strings/api_strings.dart';

abstract class ImageRemoteDataSource {
  Future<List<ImageData>> getRecentImages(int pageIndex);
  Future<List<ImageData>> searchRecentImages(String query);
}

class ImageRemoteDataSourceImpl extends ImageRemoteDataSource {
  @override
  Future<List<ImageData>> getRecentImages(int pageIndex) async {
    final response = await Dio().get(
        '${ApiConstants.baseUrl}?method=flickr.photos.getRecent&api_key=${ApiConstants.apiKey}&per_page=10&format=json&nojsoncallback=1&page=$pageIndex');
    print(response);
    if (response.statusCode == 200) {
      return List<ImageData>.from(
        (response.data["photos"]["photo"] as List).map(
          (e) => ImageDataModel.fromJson(e),
        ),
      );
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<ImageData>> searchRecentImages(String query) async {
    final response = await Dio().get(ApiConstants.searchImage(query));
    print(response);
    if (response.statusCode == 200) {
      return List<ImageData>.from(
        (response.data["photos"]["photo"] as List).map(
          (e) => ImageDataModel.fromJson(e),
        ),
      );
    } else {
      throw ServerException();
    }
  }
}
