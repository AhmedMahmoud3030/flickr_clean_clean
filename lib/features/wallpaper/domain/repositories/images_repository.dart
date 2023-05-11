import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/image.dart';

abstract class ImagesRepository {
  Future<Either<Failure, List<ImageData>>> getRecentImages();
  Future<Either<Failure, List<ImageData>>> getSearchData(String query);

  Future<Either<Failure, List<ImageData>>> getRecentNextPageImages(
      int pageIndex);
}
