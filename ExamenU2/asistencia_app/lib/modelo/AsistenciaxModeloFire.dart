
import 'package:asistencia_app/modelo/ActividadModeloFire.dart';
import 'package:flutter/material.dart';

@immutable
class AsistenciaxModeloFire {

  late String id="";
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
  late final ActividadModeloFire actividadId;

  AsistenciaxModeloFire({
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
  AsistenciaxModeloFire.unlaunched();

  AsistenciaxModeloFire.fromJson(Map<String, dynamic> json){
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
    actividadId = json['actividadId']!=null? ActividadModeloFire.fromJsonModelo(json['actividadId']):ActividadModeloFire.unlaunched();
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
    //_data['actividadId'] = actividadId;
    if (this.actividadId != null) {
      _data['actividadId'] = this.actividadId.id;
    }
    return _data;
  }


  Map<String, dynamic> toMap(){
    var data=Map<String, dynamic>();
    data['id'] = this.id;
    data['fecha'] = this.fecha;
    data['horaReg'] = this.horaReg;
    data['latituda'] = this.latituda;
    data['longituda'] = this.longituda;
    data['tipo'] = this.tipo;
    data['calificacion'] = this.calificacion;
    data['cui'] = this.cui;
    data['tipoCui'] = this.tipoCui;
    //data['actividad'] = this.actividad;
    if (this.actividadId != null) {
      data['actividadId'] = this.actividadId.id;
    }
    return data;
  }

}