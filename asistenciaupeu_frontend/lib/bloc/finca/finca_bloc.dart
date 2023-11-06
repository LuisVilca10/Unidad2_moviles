import 'package:asistenciaupeu_frontend/modelo/FincaModelo.dart';
import 'package:asistenciaupeu_frontend/repository/FincaRepository.dart';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'finca_event.dart';
part 'finca_state.dart';

class FincaBloc extends Bloc<FincaEvent, FincaState> {
  late final FincaRepository _fincaRepository;
  FincaBloc(this._fincaRepository) : super(FincaInitialState()) {
    on<FincaEvent>((event, emit) async {
      print("Bloc x");
      if (event is ListarFincaEvent) {
        emit(FincaLoadingState());
        try {
          print("pasox!!");
          List<FincaModelo> fincaList = await _fincaRepository.getFinca();
          print(fincaList);
          emit(FincaLoadedState(fincaList));
        } catch (e) {
          emit(FincaError(e as Error));
        }
      } else if (event is DeleteFincaEvent) {
        try {
          await _fincaRepository.deleteFinca(event.finca.id);
          emit(FincaLoadingState());
          List<FincaModelo> fincaList = await _fincaRepository.getFinca();
          emit(FincaLoadedState(fincaList));
        } catch (e) {
          emit(FincaError(e as Error));
        }
      } else if (event is CreateFincaEvent) {
        try {
          await _fincaRepository.createFinca(event.finca);
          emit(FincaLoadingState());
          List<FincaModelo> fincaList = await _fincaRepository.getFinca();
          emit(FincaLoadedState(fincaList));
        } catch (e) {
          emit(FincaError(e as Error));
        }
      } else if (event is UpdateFincaEvent) {
        try {
          await _fincaRepository.updateFinca(event.finca.id, event.finca);
          emit(FincaLoadingState());
          List<FincaModelo> lecheList = await _fincaRepository.getFinca();
          emit(FincaLoadedState(lecheList));
        } catch (e) {
          emit(FincaError(e as Error));
        }
      }
    });
  }
}
