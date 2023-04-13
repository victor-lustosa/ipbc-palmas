import '../../../domain/entities/service_entity.dart';
import '../../models/hive-dtos/hive_service_dto.dart';
import 'hive_liturgy_adapter.dart';
import 'hive_lyric_adapter.dart';

class HiveServiceAdapter {
  static Map<String, dynamic> toMap(dynamic data) {
    return {
      'id': data.id,
      'liturgyList': HiveLiturgyAdapter.toMapList(data.liturgyList),
      'lyricsList': HiveLyricAdapter.toMapList(data.lyricsList),
      'createAt': data.createAt,
      'heading': data.heading,
      'title': data.title,
      'type': data.type,
      'theme': data.theme,
      'image': data.image,
      'hour': data.hour,
      'preacher': data.preacher,
      'guideIsVisible': data.guideIsVisible,
    };
  }

  static HiveServiceDTO toDTO(ServiceEntity entity) {
    return  HiveServiceDTO(
        id: entity.id,
        liturgyList: HiveLiturgyAdapter.toDTOList(entity.liturgyList),
        lyricsList: HiveLyricAdapter.toDTOList(entity.lyricsList),
        createAt: entity.createAt,
        heading: entity.heading,
        title: entity.title,
        theme: entity.theme,
        preacher: entity.preacher,
        guideIsVisible: entity.guideIsVisible,
        type: entity.type,
        image: entity.image,
        hour: entity.hour,
    );
  }
}