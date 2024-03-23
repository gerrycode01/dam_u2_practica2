import 'package:dam_u2_tarea2/bd.dart';
import 'package:dam_u2_tarea2/cancion.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Actualizar',
      home: Scaffold(
        body: UpdateListaCanciones(),
      ),
    );
  }
}

class UpdateListaCanciones extends StatefulWidget {
  const UpdateListaCanciones({super.key});

  @override
  State<UpdateListaCanciones> createState() => _UpdateListaCancionesState();
}

class _UpdateListaCancionesState extends State<UpdateListaCanciones> {
  List<Cancion> canciones = [];

  final _tituloController = TextEditingController();
  final _artistaController = TextEditingController();
  final _duracionController = TextEditingController();
  final _generoController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _cargarCanciones();
  }

  void _cargarCanciones() async {
    List<Cancion> listaCanciones = await BD.cargarDatos();

    setState(() {
      canciones = listaCanciones;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: canciones.length,
        itemBuilder: (context, index) {
          Cancion cancion = canciones[index];
          return ListTile(
            leading: const CircleAvatar(child: Icon(Icons.album_sharp),),
            title: Text(cancion.titulo),
            subtitle: Text(
                '${cancion.artista} - Duración: ${cancion
                    .duracion}s - Género: ${cancion.genero}'),
            trailing: Icon(Icons.update),
            onTap: (){
              _tituloController.text = cancion.titulo;
              _artistaController.text = cancion.artista;
              _duracionController.text = cancion.duracion.toString();
              _generoController.text = cancion.genero;

              showModalBottomSheet(context: context, builder: (BuildContext context){
                return Container(
                  height: 200,
                  child: ListView(
                    padding: const EdgeInsets.all(8),
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          if (_tituloController.text.isEmpty ||
                              _artistaController.text.isEmpty ||
                              _duracionController.text.isEmpty ||
                              _generoController.text.isEmpty) {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text('Error'),
                                  content: const Text('Todos los campos son obligatorios.'),
                                  actions: <Widget>[
                                    TextButton(
                                      child: const Text('OK'),
                                      onPressed: () {
                                        Navigator.of(context).pop(); // Cerrar el AlertDialog
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          } else {
                            BD.actualizarCancion(canciones, cancion, index);
                          }
                        },
                        child: const Text('ACTUALIZAR'),
                      ),
                    ],
                  )
                );
              });
            },
          );
        });
  }
}
