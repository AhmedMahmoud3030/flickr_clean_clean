// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flickr_clean/core/error/failures.dart';
import 'package:flickr_clean/core/usecase/base_usecase.dart';
import 'package:flickr_clean/features/wallpaper/domain/entities/image.dart';

import '../repositories/images_repository.dart';

class SearchImagesUseCase
    extends BaseUseCase<List<ImageData>, SearchImageParameters> {
  final ImagesRepository repository;

  SearchImagesUseCase({required this.repository});

  @override
  Future<Either<Failure, List<ImageData>>> call(
      SearchImageParameters parameters) async {
    return await repository.getSearchData(parameters.query);
  }
}

class SearchImageParameters extends Equatable {
  final String query;

  const SearchImageParameters({required this.query});

  @override
  List<Object?> get props => [query];
}
