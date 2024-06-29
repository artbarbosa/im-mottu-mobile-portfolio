import 'dart:async';

import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import '../../../modules/character/data/datasources/local/get_character_list_local_datasource.dart';
import '../../../modules/character/data/model/character_model.dart';
import '../../../modules/character/data/model/comics_model.dart';
import '../../../modules/character/data/model/items_model.dart';
import '../../../modules/character/data/model/thumbnail_model.dart';
import '../../../modules/character/data/model/urls_model.dart';

class HiveService {
  static Future<void> initHive() async {
    final appDocumentDirectory = await getApplicationDocumentsDirectory();

    Hive
      ..init(appDocumentDirectory.path)
      ..registerAdapter(CharacterModelAdapter())
      ..registerAdapter(ComicsModelAdapter())
      ..registerAdapter(ItemsModelAdapter())
      ..registerAdapter(ThumbnailModelAdapter())
      ..registerAdapter(UrlsModelAdapter());

    await GetCharactersListLocalDataSource.init();
  }
}
