// ignore_for_file: must_be_immutable

part of 'finca_bloc.dart';

@immutable
abstract class FincaEvent {}

class ListarFincaEvent extends FincaEvent {
  ListarFincaEvent() {
    print("Evento si");
  }
}

class DeleteFincaEvent extends FincaEvent {
  FincaModelo finca;
  DeleteFincaEvent(this.finca);

}

class UpdateFincaEvent extends FincaEvent {
  FincaModelo finca;
  UpdateFincaEvent(this.finca);
}

class CreateFincaEvent extends FincaEvent {
  FincaModelo finca;
  CreateFincaEvent(this.finca);
}
