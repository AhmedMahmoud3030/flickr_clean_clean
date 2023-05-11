part of 'images_bloc.dart';

abstract class ImagesState extends Equatable {
  const ImagesState();

  @override
  List<Object> get props => [];
}

class ImagesInitial extends ImagesState {}

class LoadingImagesState extends ImagesState {}

class LoadedImagesState extends ImagesState {}

class ErrorImagesState extends ImagesState {
  final String message;

  const ErrorImagesState({required this.message});

  @override
  List<Object> get props => [message];
}
