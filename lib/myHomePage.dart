import 'package:dam_u2_tarea2/login.dart';
import 'package:dam_u2_tarea2/mostrar.dart';
import 'package:dam_u2_tarea2/update.dart';
import 'package:flutter/material.dart';

import 'capturar.dart';

void main() {
  runApp(const MyHomePage());
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _indice = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Tarea 2 - Canciones',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: dinamico(),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(child: const Text('Canciones')),
            itemDrawer(1, Icons.app_registration, 'CAPTURAR'),
            itemDrawer(2, Icons.remove_red_eye, 'MOSTRAR'),
            itemDrawer(3, Icons.delete, 'ELIMINAR'),
            itemDrawer(4, Icons.update, 'ACTUALIZAR'),
            ListTile(
              title: const Row(
                children: [
                  Expanded(child: Icon(Icons.close)),
                  Expanded(flex: 2, child: Text('CERRAR SESION'),)
                ],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Login()),
                );
              },
            )
          ],
        ),
      ),
    );
  }

  Widget itemDrawer(int indice, IconData icono, String etiqueta) {
    return ListTile(
      onTap: () {
        setState(() {
          _indice = indice;
        });
        Navigator.pop(context);
      },
      title: Row(
        children: [
          Expanded(child: Icon(icono)),
          Expanded(
            flex: 2,
            child: Text(etiqueta),
          ),
        ],
      ),
    );
  }

  Widget dinamico() {
    switch(_indice){
      case 1:{
        return CancionForm();
      }
      case 2: {
        return ListaCancionesScreen();
      }
      case 3:{

      }
      case 4: {
        return UpdateListaCanciones();
      }
    }
    return ListView();
  }

}
