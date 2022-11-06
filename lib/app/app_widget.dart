import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ipbc_palmas/app/lyric/domain/entities/lyric_entity.dart';
import 'core/infra/repositories/repository.dart';
import 'lyric/views/lyrics_list_view.dart';
import 'shared/configs/app_colors.dart';
import 'shared/configs/app_routes.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key, required this.repository}) : super(key: key);
  final Repository<LyricEntity> repository;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
        value: repository,
        child: MaterialApp(
            title: 'IPBC Palmas',
            theme: ThemeData(
              primaryColor: AppColors.white,
            ),
            home: const LyricsListView(),
            initialRoute: "/",
            onGenerateRoute: AppRoutes.onGenerateRoute,
            debugShowCheckedModeBanner: false));
  }
}
