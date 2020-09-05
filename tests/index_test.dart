import 'package:test/test.dart';
import '../index.dart';

main() {
  group('Inserção de dados', () {
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

      expect(resposta.grade.disciplinasComNotas.length, 1);
      expect(resposta.grade.aprovadoEmTodas, false);

      expect(resposta2.grade.disciplinasComNotas.length, 1);
      expect(resposta2.grade.aprovadoEmTodas, true);
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

      expect(resposta.grade.aprovadoEmTodas, false);
      expect(resposta.grade.qtdCreditosConcluidos, 16);
    });

    test('Inserindo media invalida', () {
      final List<String> frases = [
        'Logica Matematica media Z',
        'Banco de Dados media B',
        'Teoria da computacao prova1 F',
        'Teoria da computacao prova2 D',
      ];

      ProcessarArquivo resposta = ProcessarArquivo(frases);

      expect(resposta.respostas[0], 'Nota americana inválida, letras permitidas: A, B, C, D e F.');
    });

    test('Inserindo prova1 invalida', () {
      final List<String> frases = [
        'Logica Matematica prova1 h',
        'Banco de Dados media B',
        'Teoria da computacao prova1 F',
        'Teoria da computacao prova2 D',
      ];

      ProcessarArquivo resposta = ProcessarArquivo(frases);

      expect(resposta.respostas[0], 'Nota americana inválida, letras permitidas: A, B, C, D e F.');
    });
  });

  group('Respostas', () {
    final List<String> texto = [
      'Logica Matematica media C',
      'Engenharia de Software prova1 A',
      'Engenharia de Software prova2 B',
      'Banco de Dados media B',
      'Teoria da computacao prova1 F',
      'Teoria da computacao prova2 D',
      'qual a media em pontuacao brasileira em Teoria da computacao?',
      'qual a media em pontuacao brasileira em Arquitetura de Software?',
      'qual a media em pontuacao brasileira em Engenharia de Software?',
      'voce foi aprovado em todas as disciplinas?',
      'voce foi aprovado em Teoria da computacao?',
      'voce foi aprovado em Banco de Dados?',
      'quantos creditos você cursou neste semestre?',
      'quantos creditos você concluiu?',
    ];

    ProcessarArquivo resposta = ProcessarArquivo(texto);

    test('Respondendo media', () {
      expect(
          resposta.respostas[0], 'A media em Teoria da computacao foi de 3.9');
      expect(resposta.respostas[1], 'Sem nota para avaliar.');
      expect(resposta.respostas[2],
          'A media em Engenharia de Software foi de 9.4');
    });

    test('Respondendo se está aprovado em todas', () {
      expect(resposta.respostas[3], 'Não, reprovei em Teoria da computacao');
    });
  
    test('Respondendo se está aprovado em disciplina especifica', () {
      expect(resposta.respostas[4], 'Não, fui reprovado em Teoria da computacao com media 3.9');
      expect(resposta.respostas[5], 'Sim, fui aprovado em Banco de Dados com media 8.9');
    });
  
    test('Respondendo quantidade de creditos', () {
      expect(resposta.respostas[6], 'No semestre cursei 23 creditos');
      expect(resposta.respostas[7], 'Conclui 16 creditos');
    });
  });
}
