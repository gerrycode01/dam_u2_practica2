import 'package:dam_u2_tarea2/bd.dart';
import 'package:dam_u2_tarea2/cancion.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Eliminar',
      home: Scaffold(
        body: EliminarCanciones(),
      ),
    );
  }
}

class EliminarCanciones extends StatefulWidget {
  const EliminarCanciones({super.key});

  @override
  State<EliminarCanciones> createState() => _EliminarCancionesState();
}

class _EliminarCancionesState extends State<EliminarCanciones> {
  List<Cancion> canciones = [];
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
            trailing: const Icon(Icons.delete),
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Eliminar Canción'),
                    content: Text('¿Estás seguro de que quieres eliminar "${cancion.titulo}"?'),
                    actions: <Widget>[
                      TextButton(
                        child: const Text('Cancelar'),
                        onPressed: () {
                          Navigator.of(context).pop(); // Cierra el diálogo sin hacer nada más
                        },
                      ),
                      TextButton(
                        child: const Text('Eliminar'),
                        onPressed: () {
                          // Elimina la canción de la lista y actualiza el estado para reflejar el cambio
                          setState(() {
                            canciones.removeAt(index);
                            BD.guardarArchivo(canciones); // Asegúrate de implementar este método en tu clase BD para actualizar la lista en SharedPreferences o donde la estés almacenando
                            _cargarCanciones();
                          });
                          Navigator.of(context).pop(); // Cierra el diálogo
                        },
                      ),
                    ],
                  );
                },
              );
            },
          );
        });
  }
}
