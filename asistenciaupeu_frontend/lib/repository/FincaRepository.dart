import 'package:asistenciaupeu_frontend/apis/finca_api.dart';
import 'package:asistenciaupeu_frontend/modelo/FincaModelo.dart';
import 'package:asistenciaupeu_frontend/modelo/GenericModelo.dart';
import 'package:asistenciaupeu_frontend/util/TokenUtil.dart';
import 'package:dio/dio.dart';

class FincaRepository {
  FincaApi? fincaApi;

  FincaRepository() {
    Dio _dio = Dio();
    _dio.options.headers["Content-Type"] = "application/json";
    fincaApi = FincaApi(_dio);
  }

  Future<List<FincaModelo>> getFinca() async {
    var dato = await fincaApi!.getFinca(TokenUtil.TOKEN).then((value) => value);
    return await dato;
  }

  Future<GenericModelo> deleteFinca(int id) async {
    return await fincaApi!.deleteFinca(TokenUtil.TOKEN, id);
  }

  Future<FincaModelo> updateFinca(int id, FincaModelo finca) async {
    return await fincaApi!.updateFinca(TokenUtil.TOKEN, id, finca);
  }

  Future<FincaModelo> createFinca(FincaModelo finca) async {
    return await fincaApi!.crearFinca(TokenUtil.TOKEN, finca);
  }
}
