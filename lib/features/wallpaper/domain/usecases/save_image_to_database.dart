import 'package:dartz/dartz.dart';
import 'package:flickr_clean/core/usecase/base_usecase.dart';
import 'package:flickr_clean/features/wallpaper/domain/repositories/images_repository.dart';

import '../../../../core/error/failures.dart';
import '../entities/image.dart';

class SaveImageToDatabase extends BaseUseCase<List<ImageData>, NoParameters> {
  final ImagesRepository repository;
  //d
  GetRecentImagesUseCase({required this.repository});

  @override
  Future<Either<Failure, List<ImageData>>> call(
      NoParameters noParameters) async {
    return await repository.getRecentImages();
  }
}
