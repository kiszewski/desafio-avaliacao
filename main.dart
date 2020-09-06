import 'dart:io';
import 'processarFrases.dart';

lerArquivos(File entrada) {
  entrada
      .readAsLines()
      .then((value) => ProcessarFrases(value))
      .then((resultado) {
    if (resultado.respostas.length > 0) {
      resultado.respostas.forEach((resposta) => print(resposta));
    } else {
      print('Sem dados suficientes para processar!\n');
    }
  });
}

main() {
  final entrada1 = File('entradas/arquivo1.txt'); //Exemplo1 padrão
  final entrada2 = File('entradas/arquivo2.txt'); //Exemplo2 padrão
  final entrada3 = File('entradas/arquivo3.txt'); //Test arquivo vazio
  final entrada4 = File('entradas/arquivo4.txt'); //Test arquivo com dados insuficientes
  final entrada5 = File('entradas/arquivo5.txt'); //Test com notas F
  final entrada6 = File('entradas/arquivo6.txt'); //Test com notas invalidas ou medias impossiveis

  // lerArquivos(entrada1);
  lerArquivos(entrada2);
  // lerArquivos(entrada3);
  // lerArquivos(entrada4);
  // lerArquivos(entrada5);
  // lerArquivos(entrada6);
}