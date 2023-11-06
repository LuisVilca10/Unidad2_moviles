// ignore_for_file: must_be_immutable

part of 'finca_bloc.dart';

@immutable
abstract class FincaState {}

class FincaInitialState extends FincaState {}

class FincaLoadingState extends FincaState {}

class FincaLoadedState extends FincaState {
  List<FincaModelo> fincaList;
  FincaLoadedState(this.fincaList);
}

class FincaError extends FincaState {
  Error e;
  FincaError(this.e);
}
