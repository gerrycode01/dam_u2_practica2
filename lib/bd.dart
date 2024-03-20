import 'package:dam_u2_tarea2/cancion.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BD {
  static List<Cancion> canciones = [];
  static SharedPreferences? _almacen;

  static Cancion toCancion(String lista) {
    List res = lista.split('&&');
    Cancion cancion = Cancion(
        titulo: res[0], artista: res[1], duracion: res[2], genero: res[3]);
    return cancion;
  }

  static Future<SharedPreferences> openDB() async {
    if (_almacen != null) return _almacen!;
    _almacen = await SharedPreferences.getInstance();
    return _almacen!;
  }

  static Future guardarArchivo() async {
    final almacen = await openDB();
    List<String> buffer = [];
    canciones.forEach((element) {
      buffer.add(element.toString());
    });
    almacen.setStringList('buffer', buffer);
  }

  static Future cargarDatos() async {
    final almacen = await openDB();
    List<String> buffer = [];
    buffer = almacen.getStringList('buffer') ?? [];
    canciones.clear();
    buffer.forEach((element) {
      canciones.add(toCancion(element));
    });
  }

  static Future<bool> borrarAlmacen() async{
    final almacen = await openDB();
    almacen.remove('buffer');
    return true;
  }

  static void nueva(Cancion cancion){
    canciones.add(cancion);
  }

  static void actualizar(Cancion cancion, int pos){
    canciones[pos] = cancion;
  }
}