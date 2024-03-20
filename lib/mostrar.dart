import 'package:dam_u2_tarea2/bd.dart';
import 'package:dam_u2_tarea2/cancion.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Lista de Canciones'),
        ),
        body: ListaCancionesScreen());
  }
}

class ListaCancionesScreen extends StatefulWidget {
  @override
  _ListaCancionesScreenState createState() => _ListaCancionesScreenState();
}

class _ListaCancionesScreenState extends State<ListaCancionesScreen> {
  List<Cancion> canciones = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _cargarDatos();
  }

  void _cargarDatos() async {
    final List<Cancion> listaCanciones = await BD.cargarDatos();

    setState(() {
      canciones = listaCanciones;
    });
  }

  void actualizarLista() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: canciones.length,
        itemBuilder: (context, index)
    {
      Cancion cancion = canciones[index];
      return ListTile(
        title: Text(cancion.titulo),
        subtitle: Text(
            '${cancion.artista} - Duración: ${cancion
                .duracion}s - Género: ${cancion.genero}'),
        // Aquí puedes añadir acciones al hacer tap, como reproducir la canción, editar o eliminar.
      );
    },);
  }
}
