import 'disciplina.dart';
import 'gradeCurricular.dart';
import 'nota.dart';

// void main() {
//   // print('Logica Matematica' == 'Logica matematica');
//   final gr = GradeCurricular([
//     Disciplina('Logica Matematica', 4),
//     Disciplina('Engenharia de Software', 6),
//   ]);

//   List<String> frases = [
//     'Teoria da computacao media B',
//     'Engenharia de Software Prova1 C',
//     'Logica matematica Prova1 D'
//   ];

//   for (var disciplina in gr.disciplinas) {
//     for (var frase in frases) {
//       frase.startsWith(disciplina.nome);
//     }
//   }
// }
 main() {
   try {
    Nota nota = Nota(media: -2);
    print(nota.estaAprovado);
   }catch(e) {
     print(e);
   }
 }