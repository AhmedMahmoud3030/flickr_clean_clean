import 'package:flickr_clean/core/network/network_info.dart';
import 'package:flickr_clean/features/wallpaper/data/datasources/image_remote_data_source.dart';
import 'package:flickr_clean/features/wallpaper/data/repositories/images_repository_impl.dart';
import 'package:flickr_clean/features/wallpaper/domain/repositories/images_repository.dart';
import 'package:flickr_clean/features/wallpaper/domain/usecases/get_all_images.dart';
import 'package:flickr_clean/features/wallpaper/domain/usecases/get_next_page_images.dart';
import 'package:flickr_clean/features/wallpaper/domain/usecases/search_image_usecase.dart';
import 'package:flickr_clean/features/wallpaper/presentation/bloc/images_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

final sl = GetIt.instance;

Future<void> init() async {
//! Feature Posts
//?bloc
  sl.registerFactory(() => ImagesBloc(
      getRecentImagesUseCase: sl(),
      getRecentNextPageImagesUseCase: sl(),
      searchImagesUseCase: sl()));

//?usecases
  sl.registerLazySingleton(() => GetRecentImagesUseCase(repository: sl()));
  sl.registerLazySingleton(
      () => GetRecentNextPageImagesUseCase(repository: sl()));
  sl.registerLazySingleton(() => SearchImagesUseCase(repository: sl()));

//?repository
  sl.registerLazySingleton<ImagesRepository>(
    () => ImagesRepositoryImpl(
      remoteDataSource: sl(),
      networkInfo: sl(),
      // localDataSource: sl(),
    ),
  );
//?datasources

  sl.registerLazySingleton<ImageRemoteDataSource>(
      () => ImageRemoteDataSourceImpl());
  // sl.registerLazySingleton<PostLocalDataSource>(
  //     () => PostLocalDataSourceImpl(sharedPreferences: sl()));

//!core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
//!external
  // final SharedPreferences sharedPreferences =
  //     await SharedPreferences.getInstance();
  // sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
