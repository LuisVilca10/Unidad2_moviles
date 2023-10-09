void map() {
  Map<String, dynamic> persona = {
    'nombre': 'Fernando',
    'edad': 35,
    'soltero': false,
  };
  persona.addAll({'segundoNombre': 'Juan'});
  print(persona);
}
