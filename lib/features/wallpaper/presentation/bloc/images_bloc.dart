import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flickr_clean/core/usecase/base_usecase.dart';
import 'package:flickr_clean/features/wallpaper/domain/entities/image.dart';
import 'package:flickr_clean/features/wallpaper/domain/usecases/get_next_page_images.dart';
import 'package:flickr_clean/features/wallpaper/domain/usecases/search_image_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/strings/failure_strings.dart';
import '../../domain/usecases/get_all_images.dart';

part 'images_event.dart';
part 'images_state.dart';

class ImagesBloc extends Bloc<ImagesEvent, ImagesState> {
  final GetRecentImagesUseCase getRecentImagesUseCase;
  final GetRecentNextPageImagesUseCase getRecentNextPageImagesUseCase;
  final SearchImagesUseCase searchImagesUseCase;

  int page = 1;
  List<ImageData> list = [];
  List<ImageData> searchList = [];

  ScrollController scrollController = ScrollController();
  bool isLoadingMore = false;

  ImagesBloc({
    required this.searchImagesUseCase,
    required this.getRecentImagesUseCase,
    required this.getRecentNextPageImagesUseCase,
  }) : super(LoadingImagesState()) {
    scrollController.addListener(() {
      add(GetRecentImagesNextPageEvent(pageIndex: page));
    });
    on<GetRecentImagesEvent>(_getRecentImagesEvent);
    on<GetRecentImagesNextPageEvent>(_getRecentNextPageImagesEvent);
    on<SearchRecentImagesEvent>(_searchRecentImagesEvent);
  }

  FutureOr<void> _getRecentImagesEvent(
      GetRecentImagesEvent event, Emitter<ImagesState> emit) async {
    final result = await getRecentImagesUseCase(const NoParameters());
    print(result);
    result.fold(
      (l) => emit(
        ErrorImagesState(message: _mapFailureToMessage(l)),
      ),
      (r) {
        list = r;
        emit(LoadedImagesState());
      },
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case EmptyCacheFailure:
        return EMPTY_CACHE_FAILURE_MESSAGE;
      case OfflineFailure:
        return OFFLINE_FAILURE_MESSAGE;

      default:
        return 'UnExpected Error please try again later';
    }
  }

  FutureOr<void> _getRecentNextPageImagesEvent(
      GetRecentImagesNextPageEvent event, Emitter<ImagesState> emit) async {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      isLoadingMore = true;
      page++;
      final result = await getRecentNextPageImagesUseCase(
          RecentImagesParameters(pageIndex: event.pageIndex));
      emit(LoadingImagesState());
      print('hiiiiiiiiiiiiiiiiiiiiiiiiiiiiii$result');
      result.fold(
        (l) => emit(
          ErrorImagesState(message: _mapFailureToMessage(l)),
        ),
        (r) {
          list.addAll(r);
          emit(LoadedImagesState());
        },
      );
    }
  }

  FutureOr<void> _searchRecentImagesEvent(
      SearchRecentImagesEvent event, Emitter<ImagesState> emit) async {
    final result =
        await searchImagesUseCase(SearchImageParameters(query: event.query));
    emit(LoadingImagesState());
    print('hiiiiiiiiiiiiiiiiiiiiiiiiiiiiii$result');
    result.fold(
      (l) => emit(
        ErrorImagesState(message: _mapFailureToMessage(l)),
      ),
      (r) {
        searchList = r;
        emit(LoadedImagesState());
      },
    );
  }
}
