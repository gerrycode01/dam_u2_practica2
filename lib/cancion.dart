class Cancion {
  String titulo;
  String artista;
  int duracion; // Duración en segundos
  String genero;

  Cancion({
    required this.titulo,
    required this.artista,
    required this.duracion,
    required this.genero,
  });

  // Método para mostrar información de la canción
  void mostrarInformacion() {
    print('Título: $titulo');
    print('Artista: $artista');
    print('Duración: ${duracion}s');
    print('Género: $genero');
  }

  @override
  String toString(){
    return "$titulo&&$artista&&$duracion&&$genero";
  }

}
