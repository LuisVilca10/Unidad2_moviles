import 'package:asistencia_app/modelo/ActividadModelo.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class AsistenciaxModelo {

  late int id=0;
  late final String fecha;
  late final String horaReg;
  late final String latituda;
  late final String longituda;
  late final String tipo;
  late final int calificacion;
  late final String cui;
  late final String tipoCui;
  late final String entsal;
  late final int subactasisId;
  late final String offlinex;
  late final int actividadId;

  AsistenciaxModelo({
    required this.id,
    required this.fecha,
    required this.horaReg,
    required this.latituda,
    required this.longituda,
    required this.tipo,
    required this.calificacion,
    required this.cui,
    required this.tipoCui,
    required this.entsal,
    required this.subactasisId,
    required this.offlinex,
    required this.actividadId,
  });
  AsistenciaxModelo.unlaunched();

  AsistenciaxModelo.fromJson(Map<String, dynamic> json){
    id = json['id'];
    fecha = json['fecha'];
    horaReg = json['horaReg'];
    latituda = json['latituda'];
    longituda = json['longituda'];
    tipo = json['tipo'];
    calificacion = json['calificacion'];
    cui = json['cui'];
    tipoCui = json['tipoCui'];
    entsal = json['entsal'];
    subactasisId = json['subactasisId'];
    offlinex = json['offlinex'];
    actividadId = json['actividadId'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['fecha'] = fecha;
    _data['horaReg'] = horaReg;
    _data['latituda'] = latituda;
    _data['longituda'] = longituda;
    _data['tipo'] = tipo;
    _data['calificacion'] = calificacion;
    _data['cui'] = cui;
    _data['tipoCui'] = tipoCui;
    _data['entsal'] = entsal;
    _data['subactasisId'] = subactasisId;
    _data['offlinex'] = offlinex;
    _data['actividadId'] = actividadId;

    return _data;
  }
}

class AsistenciaxRespModelo {
  AsistenciaxRespModelo({
    required this.id,
    required this.fecha,
    required this.horaReg,
    required this.latituda,
    required this.longituda,
    required this.tipo,
    required this.calificacion,
    required this.cui,
    required this.tipoCui,
    required this.entsal,
    required this.subactasisId,
    required this.offlinex,
    required this.actividadId,
  });
  late final int id;
  late final String fecha;
  late final String horaReg;
  late final String latituda;
  late final String longituda;
  late final String tipo;
  late final int calificacion;
  late final String cui;
  late final String tipoCui;
  late final String entsal;
  late final int subactasisId;
  late final String offlinex;
  late final ActividadModelo actividadId;

  AsistenciaxRespModelo.fromJson(Map<String, dynamic> json){
    id = json['id'];
    fecha = json['fecha'];
    horaReg = json['horaReg'];
    latituda = json['latituda'];
    longituda = json['longituda'];
    tipo = json['tipo'];
    calificacion = json['calificacion'];
    cui = json['cui'];
    tipoCui = json['tipoCui'];
    entsal = json['entsal'];
    subactasisId = json['subactasisId'];
    offlinex = json['offlinex'];
    actividadId = ActividadModelo.fromJson(json['actividadId']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['fecha'] = fecha;
    _data['horaReg'] = horaReg;
    _data['latituda'] = latituda;
    _data['longituda'] = longituda;
    _data['tipo'] = tipo;
    _data['calificacion'] = calificacion;
    _data['cui'] = cui;
    _data['tipoCui'] = tipoCui;
    _data['entsal'] = entsal;
    _data['subactasisId'] = subactasisId;
    _data['offlinex'] = offlinex;
    _data['actividadId'] = actividadId.toJson();
    return _data;
  }
}