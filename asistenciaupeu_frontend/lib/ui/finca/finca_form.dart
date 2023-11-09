import 'package:asistenciaupeu_frontend/bloc/finca/finca_bloc.dart';
import 'package:asistenciaupeu_frontend/comp/DropDownFormField.dart';
import 'package:asistenciaupeu_frontend/modelo/FincaModelo.dart';

import 'package:checkbox_grouped/checkbox_grouped.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FincaForm extends StatefulWidget {
  @override
  _FincaFormState createState() => _FincaFormState();
}

class _FincaFormState extends State<FincaForm> {
  TextEditingController _fecha = new TextEditingController();
  DateTime? selectedDate;

  late String _nombreFinca = "";
  late String _telefono = "";
  late String _are = "";
  late String _medida = "";
  late String _latitud = "";
  late String _longitud = "";
  late String _rol = "";
  //var _data = [];

  @override
  void initState() {
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();
  List<String> pa = ['Peru', 'Ecuador', 'Chile'];
  GroupController controller = GroupController();
  GroupController multipfincackController = GroupController(
    isMultipleSelection: true,
  );

  void capturaNomnreFinca(valor) {
    this._nombreFinca = valor;
  }

  void capturaLatitud(valor) {
    this._latitud = valor;
  }

  void capturalongitud(valor) {
    this._longitud = valor;
  }

  void capturaTelefono(valor) {
    this._telefono = valor;
  }

  void capturaArea(valor) {
    this._are = valor;
  }

  void capturaMedida(valor) {
    this._medida = valor;
  }

  void capturaRol(valor) {
    this._rol = valor;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Form. Reg. Finca B"),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
          child: Container(
              margin: EdgeInsets.all(24),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    _buildDatoCadena(capturaNomnreFinca, "Nombre"),
                    _buildDatoCadena(capturaTelefono, "Telefono:"),
                    _buildDatoCadena(capturaArea, "Area:"),
                    _buildDatoCadena(
                      capturaMedida,
                      "Latitud:",
                    ),
                    _buildDatoCadena(
                      capturaMedida,
                      "Longitud:",
                    ),
                    _buildDatoCadena(
                      capturaMedida,
                      "Medida:",
                    ),
                    _buildDatoCadena(
                      capturaMedida,
                      "rol finca:",
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context, true);
                              },
                              child: Text('Cancelar')),
                          ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Processing Data'),
                                  ),
                                );
                                _formKey.currentState!.save();
                                FincaModelo mp = new FincaModelo.unlaunched();
                                //print(DateFormat('yyyy-MM-dd').format(currentTime));
                                mp.nombreFinca = _nombreFinca;
                                mp.telefono = _telefono;
                                mp.are = _are;
                                mp.medida = _medida;
                                mp.latitud = _latitud;
                                mp.longitud = _longitud;
                                mp.rol = _rol;

                                BlocProvider.of<FincaBloc>(context)
                                    .add(CreateFincaEvent(mp));

                                Navigator.pop(context, () {
                                  //setState(() {});
                                });
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                        'No estan bien los datos de los campos!'),
                                  ),
                                );
                              }
                            },
                            child: const Text('Guardar'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ))),
    );
  }

  Widget _buildDatoEntero(Function obtValor, String label) {
    return TextFormField(
      decoration: InputDecoration(labelText: label),
      keyboardType: TextInputType.number,
      validator: (String? value) {
        if (value!.isEmpty) {
          return 'Id es campo Requerido';
        }
        return null;
      },
      onSaved: (String? value) {
        obtValor(int.parse(value!));
      },
    );
  }

  Widget _buildDatoCadena(Function obtValor, String label) {
    return TextFormField(
      decoration: InputDecoration(labelText: label),
      keyboardType: TextInputType.text,
      validator: (String? value) {
        if (value!.isEmpty) {
          return 'Nombre Requerido!';
        }
        return null;
      },
      onSaved: (String? value) {
        obtValor(value!);
      },
    );
  }

  Widget _buildDatoLista(
      Function obtValor, _dato, String label, List<dynamic> listaDato) {
    return DropDownFormField(
      titleText: label,
      hintText: 'Seleccione',
      value: _dato,
      onSaved: (value) {
        setState(() {
          obtValor(value);
        });
      },
      onChanged: (value) {
        setState(() {
          obtValor(value);
        });
      },
      dataSource: listaDato,
      textField: 'display',
      valueField: 'value',
    );
  }

  Future<void> _selectDate(BuildContext context, Function obtValor) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2010),
      lastDate: DateTime(2030),
    );
    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
        obtValor(selectedDate.toString());
      });
    }
  }

  Widget _buildDatoFecha(Function obtValor, String label) {
    return TextFormField(
      decoration: InputDecoration(labelText: label),
      controller: _fecha,
      keyboardType: TextInputType.datetime,
      validator: (String? value) {
        if (value!.isEmpty) {
          return 'Nombre Requerido!';
        }
        return null;
      },
      onTap: () {
        _selectDate(context, obtValor);
      },
      onSaved: (String? value) {
        obtValor(value!);
      },
    );
  }
}
