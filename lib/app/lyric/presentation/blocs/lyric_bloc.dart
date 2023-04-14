import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/cupertino.dart';

import '../../../lyric/infra/models/hive-dtos/hive_database_configs_dto.dart';
import '../../domain/use-cases/lyrics_use_cases.dart';
import '../../domain/entities/lyric_entity.dart';
import '../view-models/lyrics_view_model.dart';

class LyricBloc extends Bloc<LyricEvent, LyricState> {
  final ILyricsUseCases fireLyricsUseCase;
  final ILyricsUseCases hiveLyricsUseCase;
  final LyricsViewModel lyricsViewModel;
  final String path = 'lyrics/20';
  final String initialId = 'fdg33f345';
  late HiveDatabaseConfigsDTO data;
  bool addController = false;

  LyricBloc({ required this.lyricsViewModel, required this.fireLyricsUseCase, required this.hiveLyricsUseCase})
      : super(InitialState()) {
    on<GetLyricsInFireEvent>(_getLyricsInFire);
    on<GetLyricsInHiveEvent>(_getLyricsInHive);
    on<AddLyricsInHiveEvent>(_addLyricsInHive);
    on<UpdateLyricsInHiveEvent>(_updateLyricsInHive);
    on<LyricsFilterEvent>(_lyricsFilter);
    on<LoadingEvent>(_loading);
    on<CheckConnectivityEvent>(_checkConnectivity);
  }
  Future<void> _checkConnectivity(CheckConnectivityEvent event, emit) async {
    data = event.data;
    if(!data.isLyricsUpdated){
      final isConnected = await lyricsViewModel.isConnected();
      if(isConnected){
        add(GetLyricsInFireEvent());
      } else {
        emit(NoConnectionAvailableState());
      }
    } else{
      add(GetLyricsInHiveEvent());
    }
  }

  Future<void> _getLyricsInFire(GetLyricsInFireEvent event, emit) async {
    add(LoadingEvent());
    await emit.onEach<List<LyricEntity>>(
      await fireLyricsUseCase.get(path),
      onData: (lyrics) {
        add(UpdateLyricsInHiveEvent(entities: lyrics));
        emit(SuccessfullyFetchedLyricsState(lyrics));
      },
      onError: (error, st) async {
        await FirebaseCrashlytics.instance.recordError(error, st, reason: 'a non-fatal error');
        FirebaseCrashlytics.instance.setCustomKey('get fire lyric bloc', error.toString());
        emit(ExceptionLyricState(error.toString()));
      },
    );
  }

  Future<void> _getLyricsInHive(GetLyricsInHiveEvent event, emit) async {
    add(LoadingEvent());
    await emit.onEach<List<LyricEntity>>(
      await hiveLyricsUseCase.get(path),
      onData: (lyrics) {
        emit(SuccessfullyFetchedLyricsState(lyrics));
      },
      onError: (error, st) async {
        await FirebaseCrashlytics.instance.recordError(error, st, reason: 'a non-fatal error');
        FirebaseCrashlytics.instance.setCustomKey('get hive lyric bloc', error.toString());
        emit(ExceptionLyricState(error.toString()));
      },
    );
  }
  Future<void> _addLyricsInHive(AddLyricsInHiveEvent event, emit) async {
    hiveLyricsUseCase.add(path, event.entities);
  }
  Future<void> _updateLyricsInHive(UpdateLyricsInHiveEvent event, emit) async {
    hiveLyricsUseCase.update(path, event.entities);
  }
  Future<void> _loading(_, emit) async {
    emit(LoadingLyricsState());
  }
  Future<void> _lyricsFilter(LyricsFilterEvent event, emit) async {
    List<dynamic> lyricsList = await fireLyricsUseCase.lettersFilter(event.lyrics, event.letter);
    emit(SuccessfullyFilteredLyricsState(lyricsList as List<LyricEntity>));
  }
}

@immutable
abstract class LyricEvent {}

class InitialEvent extends LyricEvent {
  InitialEvent();
}
class LoadingEvent extends LyricEvent {
  LoadingEvent();
}
class GetLyricsInFireEvent extends LyricEvent {
  GetLyricsInFireEvent();
}
class CheckConnectivityEvent extends LyricEvent {
  final HiveDatabaseConfigsDTO data;
  CheckConnectivityEvent({required this.data});
}
class GetLyricsInHiveEvent extends LyricEvent {
  GetLyricsInHiveEvent();
}
class UpdateLyricsInHiveEvent extends LyricEvent {
  final dynamic entities;
  UpdateLyricsInHiveEvent({ required this.entities});
}
class AddLyricsInHiveEvent extends LyricEvent {
  final dynamic entities;
  AddLyricsInHiveEvent({ required this.entities});
}

class LyricsFilterEvent extends LyricEvent {
  final String letter;
  final List<LyricEntity> lyrics;
  LyricsFilterEvent({required this.letter, required this.lyrics});
}

@immutable
abstract class LyricState {}

class InitialState extends LyricState {
  InitialState();
}
class LoadingLyricsState extends LyricState {
  LoadingLyricsState();
}
class ExceptionLyricState extends LyricState {
  final String message;
  ExceptionLyricState(this.message);
}
class NoConnectionAvailableState extends LyricState {
  NoConnectionAvailableState();
}
class SuccessfullyFetchedLyricsState extends LyricState {
  final List<LyricEntity> entities;
  SuccessfullyFetchedLyricsState(this.entities);
}

class SuccessfullyFilteredLyricsState extends LyricState {
  final List<LyricEntity> entities;
  SuccessfullyFilteredLyricsState(this.entities);
}
