import 'dart:io';
import 'processarFrases.dart';

main(List<String> args) {
  final entrada1 = File('entradas/arquivo1.txt');

  entrada1.readAsLines()
    .then((value) => ProcessarFrases(value))
    .then((value) => value.respostas.forEach((element) {print(element);}));
}