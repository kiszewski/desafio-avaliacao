import 'models/disciplina.dart';
import 'models/gradeCurricular.dart';
import 'models/nota.dart';

void main() {
  //Palavras Chaves ou PC:
  const String PC_MEDIA = 'media';
  const String PC_PROVA1 = 'prova1';
  const String PC_PROVA2 = 'prova2';

  final GradeCurricular gr = GradeCurricular([
    Disciplina('Logica Matematica', 4),
    Disciplina('Engenharia de Software', 6),
  ]);

  final List<String> frases = [
    'Logica Matematica media B',
    'Engenharia de Software media A',
  ];

  for (var frase in frases) {
    for (var disciplina in gr.disciplinas) {
      if (frase.startsWith(disciplina.nome)) {
        if (frase.contains(PC_MEDIA)) {
          String notaLetra = frase[frase.length - 1];

          disciplina.definirNota(Nota.notaEUA(media: notaLetra));
        }
        if (frase.contains(PC_PROVA1)) {
          String notaLetra = frase[frase.length - 1];

          disciplina.definirNota(Nota.notaEUA(nota1: notaLetra));
        }
        if (frase.contains(PC_PROVA2)) {
          String notaLetra = frase[frase.length - 1];

          disciplina.definirNota(Nota.notaEUA(nota2: notaLetra));
        }
      }
    }
  }

print(gr.aprovadoEmTodas);









}

// final List<String> perguntas = [
//   'Qual a media em Teoria da computacao?',
// ];
