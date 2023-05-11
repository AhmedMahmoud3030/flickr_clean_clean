// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flickr_clean/core/error/failures.dart';
import 'package:flickr_clean/core/usecase/base_usecase.dart';
import 'package:flickr_clean/features/wallpaper/domain/entities/image.dart';

import '../repositories/images_repository.dart';

class GetRecentNextPageImagesUseCase
    extends BaseUseCase<List<ImageData>, RecentImagesParameters> {
  final ImagesRepository repository;
  GetRecentNextPageImagesUseCase({
    required this.repository,
  });

  @override
  Future<Either<Failure, List<ImageData>>> call(
      RecentImagesParameters parameters) async {
    return await repository.getRecentNextPageImages(parameters.pageIndex);
  }
}

class RecentImagesParameters extends Equatable {
  final int pageIndex;

  const RecentImagesParameters({required this.pageIndex});

  @override
  List<Object?> get props => [pageIndex];
}
