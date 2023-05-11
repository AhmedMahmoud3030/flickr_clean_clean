import 'package:dartz/dartz.dart';
import 'package:flickr_clean/core/error/failures.dart';
import 'package:flickr_clean/features/wallpaper/domain/entities/image.dart';

import '../../../../core/error/exception.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/repositories/images_repository.dart';
import '../datasources/image_remote_data_source.dart';

class ImagesRepositoryImpl extends ImagesRepository {
  final ImageRemoteDataSource remoteDataSource;
  //final ImageLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  ImagesRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  // @override
  // Future<Either<Failure, List<ImageData>>> getRecentImages() async {
  //   if (await networkInfo.isConnected) {
  //     try {
  //       final remoteData = await remoteDataSource.getRecentImages();
  //       //localDataSource.cacheImages(remoteData);
  //       return Right(remoteData);
  //     } on ServerException {
  //       return Left(ServerFailure());
  //     }
  //   } else {
  //     try {
  //       final localData = await localDataSource.getCachedImages();

  //       return Right(localData);
  //     } on EmptyCacheException {
  //       return Left(EmptyCacheFailure());
  //     }
  //   }
  // }

  @override
  Future<Either<Failure, List<ImageData>>> getRecentImages() async {
    try {
      final remoteData = await remoteDataSource.getRecentImages(1);
      //localDataSource.cacheImages(remoteData);
      return Right(remoteData);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<ImageData>>> getRecentNextPageImages(
      int pageIndex) async {
    try {
      final remoteData = await remoteDataSource.getRecentImages(pageIndex);
      //localDataSource.cacheImages(remoteData);
      return Right(remoteData);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<ImageData>>> getSearchData(String query) async {
    try {
      final remoteData = await remoteDataSource.searchRecentImages(query);
      //localDataSource.cacheImages(remoteData);
      return Right(remoteData);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
