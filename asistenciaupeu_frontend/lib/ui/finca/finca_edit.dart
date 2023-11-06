// ignore_for_file: use_build_context_synchronously, unnecessary_brace_in_string_interps, unnecessary_new, prefer_final_fields, no_logic_in_create_state, library_private_types_in_public_api, use_key_in_widget_constructors, must_be_immutable

import 'package:asistenciaupeu_frontend/bloc/finca/finca_bloc.dart';
import 'package:asistenciaupeu_frontend/comp/DropDownFormField.dart';
import 'package:asistenciaupeu_frontend/modelo/FincaModelo.dart';

import 'package:checkbox_grouped/checkbox_grouped.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FincaFormEdit extends StatefulWidget {
  FincaModelo modelA;

  FincaFormEdit({required this.modelA}) : super();

  @override
  _FincaFormEditState createState() => _FincaFormEditState(modelA: modelA);
}

class _FincaFormEditState extends State<FincaFormEdit> {
  FincaModelo modelA;
  _FincaFormEditState({required this.modelA}) : super();

  //late int _periodoId = 0;

  // TextEditingController _fecha = new TextEditingController();
  DateTime? selectedDate;

  late String _nombreFinca = "";
  late String _telefono = "";
  late String _areafin = "";
  late String _medida = "";

  @override
  void initState() {
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();
  GroupController controller = GroupController();
  GroupController multipfincackController = GroupController(
    isMultipleSelection: true,
  );

  void capturaNomnreFinca(valor) {
    this._nombreFinca = valor;
  }

  void capturaTelefono(valor) {
    this._telefono = valor;
  }

  void capturaArea(valor) {
    this._areafin = valor;
  }

  void capturaMedida(valor) {
    this._medida = valor;
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
              margin: const EdgeInsets.all(24),
              //color: AppTheme.nearlyWhite,
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    _buildDatoCadena(
                        capturaNomnreFinca, modelA.nombreFinca, "Nombre"),
                    _buildDatoCadena(
                        capturaTelefono, modelA.telefono, "Telefono:"),
                    _buildDatoCadena(capturaArea, modelA.are, "Area:"),
                    _buildDatoCadena(
                      capturaMedida,
                      modelA.latitud,
                      "Latitud:",
                    ),
                    _buildDatoCadena(
                      capturaMedida,
                      modelA.longitud,
                      "Longitud:",
                    ),
                    _buildDatoCadena(
                      capturaMedida,
                      modelA.medida,
                      "Medida:",
                    ),
                    _buildDatoCadena(
                      capturaMedida,
                      modelA.rol,
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
                              child: const Text('Cancelar')),
                          ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Processing Data'),
                                  ),
                                );

                                _formKey.currentState!.save();
                                FincaModelo mp = FincaModelo.unlaunched();

                                mp.nombreFinca = _nombreFinca;
                                mp.telefono = _telefono;
                                mp.are = _areafin;
                                mp.medida = _medida;
                                mp.id = modelA.id;

                                BlocProvider.of<FincaBloc>(context)
                                    .add(UpdateFincaEvent(mp));
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

  Widget buildDatoEntero(Function obtValor, String dato, String label) {
    return TextFormField(
      decoration: InputDecoration(labelText: label),
      initialValue: dato,
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

  Widget _buildDatoCadena(Function obtValor, String dato, String label) {
    return TextFormField(
      decoration: InputDecoration(labelText: label),
      initialValue: dato,
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
      Function obtValor, dato, String label, List<dynamic> listaDato) {
    return DropDownFormField(
      titleText: label,
      hintText: 'Seleccione',
      value: dato,
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
      //controller: _nombreFinca,
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
