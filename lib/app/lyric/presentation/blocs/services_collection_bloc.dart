import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/cupertino.dart';
import '../../../lyric/infra/models/firestore-dtos/services_collection_dto.dart';
import '../../../splash/presentation/blocs/database_bloc.dart';
import '../../../core/domain/use-cases/use_cases.dart';
import '../../domain/entities/service_entity.dart';

class ServicesCollectionBloc extends Bloc<ServicesCollectionEvent, ServicesCollectionState> {
  final IUseCases fireCollectionUseCases;
  final IUseCases hiveCollectionUseCases;

  ServicesCollectionBloc(
      {required this.fireCollectionUseCases, required this.hiveCollectionUseCases})
      : super(InitialState()) {
    on<GetCollectionInFireEvent>(_getCollectionInFire);
    on<AddCollectionInHiveEvent>(_addCollectionInHive);
    on<GetCollectionInHiveEvent>(_getCollectionInHive);
    on<LoadingEvent>(_loadingEvent);
  }

  Future<void> _getCollectionInFire(GetCollectionInFireEvent event, emit) async {
    add(LoadingEvent());
    await emit.onEach<List<ServicesCollectionDTO>>(
      await fireCollectionUseCases.get(event.path),
      onData: (service) {

      /*for(ServicesCollectionDTO entity in service){
            add(AddCollectionInHiveEvent(path: 'services-collections', data: entity));
         }*/
        emit(SuccessfullyFetchedCollectionState(service));
      },
      onError: (error, st) async {
        await FirebaseCrashlytics.instance.recordError(error, st, reason: 'a non-fatal error');
        emit(CollectionExceptionState(error.toString()));
      },
    );
  }

  Future<void> _getCollectionInHive(GetCollectionInHiveEvent event, emit) async {
    add(LoadingEvent());
    await emit.onEach<List<ServicesCollectionDTO>>(
      await hiveCollectionUseCases.get(event.path),
      onData: (service) {
        emit(SuccessfullyFetchedCollectionState(service));
      },
      onError: (error, st) async {
        await FirebaseCrashlytics.instance.recordError(error, st, reason: 'a non-fatal error');
        emit(CollectionExceptionState(error.toString()));
      },
    );
  }
  Future<void> _loadingEvent(event, emit) async {
   emit(LoadingCollectionState());
  }
  Future<void> _addCollectionInHive(AddCollectionInHiveEvent event, emit) async {
    await hiveCollectionUseCases.add(event.path, event.data);
  }
}

@immutable
abstract class ServicesCollectionEvent {}

class InitialEvent extends ServicesCollectionEvent {
  InitialEvent();
}
class LoadingEvent extends ServicesCollectionEvent {
  LoadingEvent();
}
class GetCollectionInFireEvent extends ServicesCollectionEvent {
  final String path;
  GetCollectionInFireEvent({required this.path});
}

class GetCollectionInHiveEvent extends ServicesCollectionEvent {
  final String path;
  GetCollectionInHiveEvent({required this.path});
}

class AddCollectionInHiveEvent extends ServicesCollectionEvent {
  final String path;
  final dynamic data;
  AddCollectionInHiveEvent({required this.path, required this.data});
}

@immutable
abstract class ServicesCollectionState {}
class LoadingCollectionState extends ServicesCollectionState {
  LoadingCollectionState();
}
class InitialState extends ServicesCollectionState {
  InitialState();
}

class CollectionExceptionState extends ServicesCollectionState {
  final String message;
  CollectionExceptionState(this.message);
}

class SuccessfullyFetchedCollectionState extends ServicesCollectionState {
  final List<ServicesCollectionDTO> entities;
  SuccessfullyFetchedCollectionState(this.entities);
}
