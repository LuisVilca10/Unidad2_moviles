part of 'actividad_bloc.dart';

@immutable
abstract class ActividadState {}

class ActividadInitialState extends ActividadState {}
class ActividadLoadingState extends ActividadState{}
class ActividadLoadedState extends ActividadState{
  List<ActividadModelo> ActividadList;
  ActividadLoadedState(this.ActividadList);
}
class ActividadError extends ActividadState{
  Error e;
  ActividadError(this.e);
}
