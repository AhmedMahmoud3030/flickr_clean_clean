import 'package:equatable/equatable.dart';

class ImageData extends Equatable {
  final String id;
  final String secret;
  final String server;
  final String title;

  const ImageData(
      {required this.id,
      required this.secret,
      required this.server,
      required this.title});

  @override
  List<Object?> get props => [id, title, secret, server, server];
}
