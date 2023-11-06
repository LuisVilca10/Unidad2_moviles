// ignore_for_file: prefer_typing_uninitialized_variables, library_private_types_in_public_api

import 'package:animated_floating_buttons/animated_floating_buttons.dart';
import 'package:asistenciaupeu_frontend/bloc/finca/finca_bloc.dart';
import 'package:asistenciaupeu_frontend/modelo/FincaModelo.dart';
import 'package:asistenciaupeu_frontend/repository/FincaRepository.dart';
import 'package:asistenciaupeu_frontend/ui/finca/MyAppState.dart';
//import 'package:asistenciaupeu_frontend/apis/asistencia_api.dart';
import 'package:asistenciaupeu_frontend/comp/TabItem.dart';
import 'package:asistenciaupeu_frontend/ui/finca/finca_edit.dart';

import 'package:asistenciaupeu_frontend/ui/finca/finca_form.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:asistenciaupeu_frontend/theme/AppTheme.dart';
import '../help_screen.dart';

class MainFincaB extends StatelessWidget {
  const MainFincaB({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => FincaBloc(FincaRepository())),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        themeMode: AppTheme.useLightMode ? ThemeMode.light : ThemeMode.dark,
        theme: AppTheme.themeDataLight,
        darkTheme: AppTheme.themeDataDark,
        home: const FincaUI(),
      ),
    );
  }
}

class FincaUI extends StatefulWidget {
  const FincaUI({super.key});

  @override
  _FincaUIState createState() => _FincaUIState();
}

class _FincaUIState extends State<FincaUI> {
  //ApiCovid apiService;
  final DateFormat formatter = DateFormat('yyyy-MM-dd');
  var api;
  @override
  void initState() {
    super.initState();
    //apiService = ApiCovid();
    //api=Provider.of<PredictionApi>(context, listen: false).getPrediction();
    BlocProvider.of<FincaBloc>(context).add(ListarFincaEvent());
    print("entro aqui");
  }

  final GlobalKey<AnimatedFloatingActionButtonState> key =
      GlobalKey<AnimatedFloatingActionButtonState>();

  String text = 'FinkaRed';
  String subject = '';
  List<String> imageNames = [];
  List<String> imagePaths = [];

  Future onGoBack(dynamic value) async {
    setState(() {
      print(value);
    });
  }

  void accion() {
    setState(() {});
  }

  void accion2() {
    setState(() {
      print("Holaas");
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: AppTheme.useLightMode ? ThemeMode.light : ThemeMode.dark,
      theme: AppTheme.themeDataLight,
      darkTheme: AppTheme.themeDataDark,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Lista de Fincaes',
          ),
          automaticallyImplyLeading: false,
          centerTitle: true,
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  print("Si funciona");
                },
                child: const Icon(
                  Icons.search,
                  size: 26.0,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  //final producto=new ModeloProductos();
                  //formDialog(context, producto);
                  print("Si funciona 2");
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FincaForm()),
                  ).then(onGoBack);
                },
                child: const Icon(Icons.add_box_sharp),
              ),
            )
          ],
        ),
        backgroundColor: AppTheme.nearlyWhite,
        body: BlocBuilder<FincaBloc, FincaState>(
          builder: (context, state) {
            if (state is FincaLoadedState) {
              return _buildListView(context, state.fincaList);
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
        bottomNavigationBar: _buildBottomTab(),
        floatingActionButton: AnimatedFloatingActionButton(
          key: key,
          fabButtons: <Widget>[
            add(),
            image(),
            inbox(),
          ],
          colorStartAnimation: AppTheme.themeData.colorScheme.inversePrimary,
          colorEndAnimation: Colors.red,
          animatedIconData: AnimatedIcons.menu_close,
        ),
      ),
    );
  }

  Widget _buildListView(BuildContext context, List<FincaModelo> finca) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
      child: ListView.builder(
        itemBuilder: (context, index) {
          FincaModelo fincax = finca[index];
          return Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Card(
              child: Container(
                height: 100,
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ListTile(
                        subtitle: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: AppTheme.themeData.colorScheme
                                        .primaryContainer),
                                child: Text(
                                  
                                  fincax.nombreFinca,
                                  style: const TextStyle(
                                      color: Colors.black, fontSize: 16),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: AppTheme.themeData.colorScheme
                                        .primaryContainer),
                                child: Text(
                                  
                                  fincax.telefono,
                                  style: const TextStyle(
                                      color: Colors.black, fontSize: 16),
                                ),
                              ),
                            ]),
                        leading: const CircleAvatar(
                          backgroundImage:
                              AssetImage("assets/imagen/man-icon.png"),
                        ),
                        trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            //crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Expanded(
                                      child: IconButton(
                                          icon: const Icon(Icons.edit),
                                          iconSize: 24,
                                          padding: EdgeInsets.zero,
                                          constraints: const BoxConstraints(),
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      FincaFormEdit(
                                                          modelA: fincax)),
                                            ).then(onGoBack);
                                          })),
                                  Expanded(
                                      child: IconButton(
                                          icon: const Icon(Icons.delete),
                                          iconSize: 24,
                                          padding: EdgeInsets.zero,
                                          constraints: const BoxConstraints(),
                                          //color: AppTheme.themeData.colorScheme.inversePrimary,
                                          onPressed: () {
                                            showDialog(
                                                context: context,
                                                barrierDismissible: true,
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                    title: const Text(
                                                        "Mensaje de confirmacion"),
                                                    content: const Text(
                                                        "Desea Eliminar?"),
                                                    actions: [
                                                      FloatingActionButton(
                                                        child: const Text(
                                                            'CANCEL'),
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop('Failure');
                                                        },
                                                      ),
                                                      FloatingActionButton(
                                                          child: const Text(
                                                              'ACCEPT'),
                                                          onPressed: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pop('Success');
                                                          })
                                                    ],
                                                  );
                                                }).then((value) {
                                              if (value.toString() ==
                                                  "Success") {
                                                print(fincax.id);
                                            
                                                BlocProvider.of<FincaBloc>(
                                                        context)
                                                    .add(DeleteFincaEvent(
                                                        fincax));
                                              }
                                            });
                                          }))
                                ],
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Expanded(
                                    child: IconButton(
                                      icon: const Icon(Icons.qr_code),
                                      padding: EdgeInsets.zero,
                                      constraints: const BoxConstraints(),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => MyAppQR(
                                                    modelA: fincax,
                                                  )),
                                        ).then(onGoBack);
                                      },
                                    ),
                                  ),
                                  Expanded(child: Builder(
                                    builder: (BuildContext context) {
                                      return IconButton(
                                        icon: const Icon(
                                            Icons.send_and_archive_sharp),
                                        padding: EdgeInsets.zero,
                                        constraints: const BoxConstraints(),
                                        onPressed: () async {
                                        },
                                      );
                                    },
                                  ))
                                ],
                              )
                            ])),
                  ],
                ),
              ),
            ),
          );
        },
        itemCount: finca.length,
      ),
    );
  }

  int selectedPosition = 0;
  final tabs = ['Home', 'Profile', 'Help', 'Settings'];

  _buildBottomTab() {
    return BottomAppBar(
      //color: AppTheme.themeData.colorScheme.primaryContainer,

      shape: const CircularNotchedRectangle(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          TabItem(
            icon: Icons.menu,
            text: tabs[0],
            isSelected: selectedPosition == 0,
            onTap: () {
              setState(() {
                selectedPosition = 0;
              });
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return HelpScreen();
              }));
            },
          ),
          TabItem(
            icon: Icons.person,
            text: tabs[1],
            isSelected: selectedPosition == 1,
            onTap: () {
              setState(() {
                selectedPosition = 1;
              });
            },
          ),
          TabItem(
            text: tabs[2],
            icon: Icons.help,
            isSelected: selectedPosition == 2,
            onTap: () {
              setState(() {
                selectedPosition = 2;
              });
            },
          ),
          TabItem(
            text: tabs[3],
            icon: Icons.settings,
            isSelected: selectedPosition == 3,
            onTap: () {
              setState(() {
                selectedPosition = 3;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget add() {
    return FloatingActionButton(
      onPressed: () {
        key.currentState?.closeFABs();
      },
      heroTag: const Text("Image"),
      tooltip: 'Add',
      child: const Icon(Icons.add),
    );
  }

  Widget image() {
    return const FloatingActionButton(
      onPressed: null,
      heroTag: Text("Image"),
      tooltip: 'Image',
      child: Icon(Icons.image),
    );
  }

  Widget inbox() {
    return const FloatingActionButton(
      onPressed: null,
      heroTag: Text("Inbox"),
      tooltip: 'Inbox',
      child: Icon(Icons.inbox),
    );
  }

}
