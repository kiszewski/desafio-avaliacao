import 'package:test/test.dart';
import '../models/gradeCurricular.dart';
import '../models/nota.dart';
import '../index.dart';

main() {
  test('Inserir dados', () {
      final List<String> frases = [
    'Teoria da computacao prova1 F',
    'Teoria da computacao prova2 D',
  ];

      final List<String> frases2 = [
    'Banco de Dados prova1 A',
    'Banco de Dados prova2 C',
  ];

  ProcessarArquivo resposta = ProcessarArquivo(frases);
  ProcessarArquivo resposta2 = ProcessarArquivo(frases2);
  
  expect(resposta.gr.disciplinasComNotas.length, 1);
  expect(resposta.gr.aprovadoEmTodas, false);

  expect(resposta2.gr.disciplinasComNotas.length, 1);
  expect(resposta2.gr.aprovadoEmTodas, true);
  });

  test('Inserir dados atraves das frases', () {
  final List<String> frases = [
    'Logica Matematica media C',
    'Engenharia de Software prova1 A',
    'Engenharia de Software prova2 B',
    'Banco de Dados media B',
    'Teoria da computacao prova1 F',
    'Teoria da computacao prova2 D',
  ];
    ProcessarArquivo resposta = ProcessarArquivo(frases);

    expect(resposta.gr.aprovadoEmTodas, false);
    expect(resposta.gr.qtdCreditosConcluidos, 16);
  });

  test('Respondendo media', () {
      final List<String> texto = [
    'Logica Matematica media C',
    'Engenharia de Software prova1 A',
    'Engenharia de Software prova2 B',
    'Banco de Dados media B',
    'Teoria da computacao prova1 F',
    'Teoria da computacao prova2 D',
    'qual a media em pontuacao brasileira em Teoria da computacao?',
    'qual a media em pontuacao brasileira em Arquitetura de Software?',
    'qual a media em pontuacao brasileira em Engenharia de Software?'
  ];

    ProcessarArquivo resposta = ProcessarArquivo(texto);
    expect(resposta.respostas[0], 'A media em Teoria da computacao foi de 3.9');
    expect(resposta.respostas[1], 'Sem nota para avaliar.');
    expect(resposta.respostas[2], 'A media em Engenharia de Software foi de 9.4');
  });
}
