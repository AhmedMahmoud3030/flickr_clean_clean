// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flickr_clean/core/strings/api_strings.dart';
import 'package:flickr_clean/features/wallpaper/domain/entities/image.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

abstract class ImageLocalDataSource {
  Future<List<ImageData>> getCachedImages();
  Future<Unit> cacheImages(ImageData imageModels);
}

class ImageLocalDataSourceImpl extends ImageLocalDataSource {
  final Database database;
  Uint8List imageBytes;

  ImageLocalDataSourceImpl(
    this.database,
    this.imageBytes,
  );

  @override
  Future<Unit> cacheImages(ImageData imageModels) async {
    final appDir = await getApplicationDocumentsDirectory();
    final imagePath =
        '${appDir.path}/${imageModels.id}.${imageModels.secret}.jpg';
    final imageFile = File(imagePath);
    final response = await Dio().get(ApiConstants.imageUrl(
        imageModels.secret, imageModels.server, imageModels.id));
    await imageFile.writeAsBytes(response.data);

    final database = await openDatabase('flicker_app.db', version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(
          'CREATE TABLE IF NOT EXISTS images (id INTEGER PRIMARY KEY, secret TEXT, imageid TEXT, server TEXT,name TEXT, path TEXT)');
    });

    await database.insert(
        'images',
        {
          'secret': imageModels.secret,
          'imageid': imageModels.server,
          'server': imageModels.id,
          'name': imageModels.title,
          'path': imagePath
        },
        conflictAlgorithm: ConflictAlgorithm.replace);
    return Future.value(unit);
  }

  @override
  Future<List<ImageData>> getCachedImages() {
    // TODO: implement getCachedImages
    throw UnimplementedError();
  }

  // @override
  // Future<List<ImageData>> getCachedImages() async{

  //   final List<Map<String, dynamic>> maps =
  //       await database.query('images', where: 'id = ?', whereArgs: [id]);

  //   if (maps.isNotEmpty) {
  //     final imageBlob = maps.first['image'];

  //    imageBytes = base64Decode(imageBlob.toString());

  //   }

  // }
}
