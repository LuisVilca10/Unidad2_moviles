import 'package:asistenciaupeu_frontend/modelo/FincaModelo.dart';
import 'package:asistenciaupeu_frontend/modelo/GenericModelo.dart';
import 'package:asistenciaupeu_frontend/util/UrlApi.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:retrofit/http.dart';
part 'finca_api.g.dart';

@RestApi(baseUrl: UrlApi.urlApix)
abstract class FincaApi {
  factory FincaApi(Dio dio, {String baseUrl}) = _FincaApi;

  static FincaApi create() {
    final dio = Dio();
    dio.interceptors.add(PrettyDioLogger());
    return FincaApi(dio);
  }

  @GET("/finca/list")
  Future<List<FincaModelo>> getFinca(@Header("Authorization") String token);

  @POST("/finca/crear")
  Future<FincaModelo> crearFinca(
      @Header("Authorization") String token, @Body() FincaModelo finca);

  @GET("/finca/buscar/{id}")
  Future<FincaModelo> findFinca(
      @Header("Authorization") String token, @Path("id") int id);

  @DELETE("/finca/eliminar/{id}")
  Future<GenericModelo> deleteFinca(
      @Header("Authorization") String token, @Path("id") int id);

  @PUT("/finca/editar/{id}")
  Future<FincaModelo> updateFinca(@Header("Authorization") String token,
      @Path("id") int id, @Body() FincaModelo finca);
}
