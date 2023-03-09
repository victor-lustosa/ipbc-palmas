import 'dart:math';

import 'package:ipbc_palmas/app/lyric/infra/adapters/dtos/verse_dto_adapter.dart';
import 'package:uno/uno.dart';
import '../../../lyric/infra/models/dtos/lyric_dto.dart';
import '../../configs/app_configs.dart';

class VersesUtil {
  final uno = Uno();
  final Random random = Random();

  Future<dynamic> getLyric(String title, String group) async {
    String titleParam = title.replaceAll(' ', '%20');
    String groupParam = group.replaceAll(' ', '%20');
    String apikey = 'a34faccfb8ad3edc6ddcc978e34802ef';
    try {
      final response = await uno.get(
          'https://api.vagalume.com.br/search.php?art=$groupParam&mus=$titleParam&apikey=$apikey');
      return response.data;
    } on UnoError catch (error) {
      print(error);
    }
  }

  Future<List<LyricDTO>> generateVersesList(List<LyricDTO> lyricsList) async {
    List<LyricDTO> results = [];
    for (int i = 0; lyricsList.length > i; i++) {
      Map<dynamic, dynamic> result = await getLyric(lyricsList[i].title, lyricsList[i].group);
      results.add(
        LyricDTO(
          verses: VerseDTOAdapter.fromVagalume(result),
          albumCover: AppImages.defaultCoversList[random.nextInt(4)],
          id: '$i',
          title: '',
          createAt: DateTime.now(),
          group: '',
        ),
      );
    }
    return results;
  }
}

