void basica() {
  final wolverine = new Heroe(nombre: 'Super Man', poder: 'Inmortal');
//wolverine.nombre = 'LoganX';
//wolverine.poder = 'RegeneraciónX';
  print(wolverine);
}

class Heroe {
  String nombre;
  String poder;
  Heroe({required this.nombre, required this.poder});
  String toString() {
    return 'Heroe: nombre: ${this.nombre}, Poder: ${this.poder}';
  }
}
