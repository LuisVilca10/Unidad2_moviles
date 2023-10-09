abstract class Operacion {
  double suma(double a, double b);
  double resta(double a, double b);
  double multiplicacion(double a, double b);
}

class calculator implements Operacion {
  @override
  double suma(double a, double b) {
    return a + b;
  }

  double resta(double a, double b) {
    return a - b;
  }

  double multiplicacion(double a, double b) {
    return a * b;
  }
}
