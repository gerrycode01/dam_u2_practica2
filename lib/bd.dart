import 'package:dam_u2_tarea2/cancion.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BD {
  static SharedPreferences? _almacen;

  static Cancion toCancion(String lista) {
    List res = lista.split('&&');
    Cancion cancion = Cancion(
        titulo: res[0], artista: res[1], duracion: int.parse(res[2]), genero: res[3]);
    return cancion;
  }

  static Future<SharedPreferences> openDB() async {
    if (_almacen != null) return _almacen!;
    _almacen = await SharedPreferences.getInstance();
    print('BD: CONEXION EXITOSA');
    return _almacen!;
  }

  static Future<void> guardarArchivo(List<Cancion> canciones) async {
    final almacen = await openDB();

    List<String> buffer = [];
    canciones.forEach((element) {
      buffer.add(element.toString());
    });
    almacen.setStringList('buffer', buffer);
    print('BD: CANCIONES GUARDADAS EN ALMACEN');
  }

  static Future<List<Cancion>> cargarDatos() async {
    final almacen = await openDB();

    List<Cancion> canciones = [];
    List<String> buffer = [];
    buffer = almacen.getStringList('buffer') ?? [];
    canciones.clear();
    buffer.forEach((element) {
      Cancion cancion = toCancion(element);
      canciones.add(cancion);
      cancion.mostrarInformacion();
    });
    print('BD: DATOS CARGADOS DEL ALMACEN, RETORNANDO LISTA');
    return canciones;
  }

  static Future<bool> borrarAlmacen() async{
    final almacen = await openDB();
    almacen.remove('buffer');
    print('BD: ALMACEN ELIMINADO PERMANENTEMENTE');
    return true;
  }

  static void nuevaCancion(List<Cancion> canciones, Cancion cancion){
    canciones.add(cancion);
    print('BD: AGREGADA CANCION A LA LISTA');
    guardarArchivo(canciones);
  }

  static void actualizarCancion(List<Cancion> canciones, Cancion cancion, int pos){
    canciones[pos] = cancion;
    print('BD: CANCION ACTUALIZADA');
    guardarArchivo(canciones);
  }
}