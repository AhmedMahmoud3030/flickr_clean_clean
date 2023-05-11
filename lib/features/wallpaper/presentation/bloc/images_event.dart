part of 'images_bloc.dart';

abstract class ImagesEvent extends Equatable {
  const ImagesEvent();
}

class GetRecentImagesEvent extends ImagesEvent {
  @override
  List<Object> get props => [];
}

class GetRecentImagesNextPageEvent extends ImagesEvent {
  final int pageIndex;

  const GetRecentImagesNextPageEvent({required this.pageIndex});
  @override
  List<Object> get props => [pageIndex];
}

class SearchRecentImagesEvent extends ImagesEvent {
  final String query;

  const SearchRecentImagesEvent({required this.query});
  @override
  List<Object> get props => [query];
}
