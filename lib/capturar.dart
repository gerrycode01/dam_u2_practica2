import 'package:flutter/material.dart';
import 'package:dam_u2_tarea2/bd.dart';
import 'package:dam_u2_tarea2/cancion.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Formulario de Canción'),
        ),
        body: CancionForm(),
      ),
    );
  }
}

class CancionForm extends StatefulWidget {
  @override
  _CancionFormState createState() => _CancionFormState();
}

class _CancionFormState extends State<CancionForm> {
  final _formKey = GlobalKey<FormState>();
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

  @override
  void dispose() {
    _tituloController.dispose();
    _artistaController.dispose();
    _duracionController.dispose();
    _generoController.dispose();
    super.dispose();
  }

  void _cargarCanciones() async {
    final listaCanciones = await BD.cargarDatos();
    setState(() {
      canciones = listaCanciones;
    });
  }

  void _limpiarFormulario() {
    _tituloController.clear();
    _artistaController.clear();
    _duracionController.clear();
    _generoController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextFormField(
              controller: _tituloController,
              decoration: const InputDecoration(labelText: 'Título'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingresa el título de la canción';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _artistaController,
              decoration: const InputDecoration(labelText: 'Artista'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingresa el nombre del artista';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _duracionController,
              decoration: const InputDecoration(
                  labelText: 'Duración (segundos)'),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingresa la duración de la canción';
                }
                if (int.tryParse(value) == null) {
                  return 'Por favor ingresa un número válido';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _generoController,
              decoration: const InputDecoration(labelText: 'Género'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingresa el género de la canción';
                }
                return null;
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Cancion nuevaCancion = Cancion(titulo: _tituloController.text,
                        artista: _artistaController.text,
                        duracion: int.parse(_duracionController.text),
                        genero: _generoController.text);
                    BD.nuevaCancion(canciones, nuevaCancion);

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Procesando Datos')),
                    );
                    _limpiarFormulario(); // Limpia el formulario después de la validación
                  }
                },
                child: const Text('Enviar'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
