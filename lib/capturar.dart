import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Formulario de Canción'),
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

  String _titulo = '';
  String _artista = '';
  int _duracion = 0;
  String _genero = '';

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextFormField(
              decoration: const InputDecoration(labelText: 'Título'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingresa el título de la canción';
                }
                return null;
              },
              onSaved: (value) {
                _titulo = value!;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Artista'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingresa el nombre del artista';
                }
                return null;
              },
              onSaved: (value) {
                _artista = value!;
              },
            ),
            TextFormField(
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
              onSaved: (value) {
                _duracion = int.parse(value!);
              },
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Género'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingresa el género de la canción';
                }
                return null;
              },
              onSaved: (value) {
                _genero = value!;
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Procesando Datos')),
                    );
                  }
                },
                child: Text('Enviar'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
