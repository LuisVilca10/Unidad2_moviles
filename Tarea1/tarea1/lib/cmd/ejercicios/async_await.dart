void prubea1() async {
  print('Antes de la petición');
  final data = await httpGet('https://api.nasa.com/aliens');
  print(data);
  final nombre = await getNombre('10');
  print(nombre);
  getNombre('10').then(print);
  print('Fin del programa');
}

Future<String> getNombre(String id) async {
  return '$id - Fernando';
}

Future<String> httpGet(String url) {
  return Future.delayed(Duration(seconds: 10), () => 'HolaMundo - 10 segundos');
}
