import 'package:core_module/core_module.dart';
import 'package:ipbc_palmas/app/core/external/firestore_datasource.dart';
import 'package:ipbc_palmas/app/core/external/hive_datasource.dart';
import 'package:ipbc_palmas/app/lyric/domain/entities/lyric_entity.dart';
import 'package:ipbc_palmas/app/lyric/domain/entities/service_entity.dart';
import 'package:ipbc_palmas/app/lyric/domain/use-cases/lyrics_use_cases.dart';
import 'package:ipbc_palmas/app/lyric/domain/entities/services_entity.dart';
import 'package:ipbc_palmas/app/lyric/infra/models/hive-dtos/hive_database_configs_dto.dart';
import 'package:ipbc_palmas/app/lyric/infra/models/hive-dtos/hive_lyric_dto.dart';
import 'package:ipbc_palmas/app/lyric/presentation/view-models/lyrics_view_model.dart';
import 'package:ipbc_palmas/app/shared/components/utils/analytics_util.dart';
import 'package:mocktail/mocktail.dart';

class RepositoryMock extends Mock implements Repository<Stream<List<Map>>> {}

class LyricEntityMock extends Mock implements LyricEntity {}
class CollectionEntityMock extends Mock implements ServiceEntity {}
class ServicesEntityMock extends Mock implements ServicesEntity {}
class LyricHiveDatasource extends Mock implements HiveDatasource<HiveLyricDTO> {}
class AnalyticsMock extends Mock implements AnalyticsUtil {}
class IDatasourceMock extends Mock implements IDatasource {}
class FirestoreDatasourceMock extends Mock implements FirestoreDatasource {}
class LyricsViewModelMock extends Mock implements LyricsViewModel {}
class ILyricsUseCasesMock<R> extends Mock implements ILyricsUseCases<R> {}
class IUseCasesMock<R> extends Mock implements IUseCases<R> {}
class HiveDatabaseConfigsDTOMock extends Mock implements HiveDatabaseConfigsDTO{}