import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  final libDir = Directory('lib');
  final dartFiles = libDir
      .listSync(recursive: true)
      .whereType<File>()
      .where((file) => file.path.endsWith('.dart'))
      .toList(growable: false);

  test('o player de vídeo foi removido do projeto', () {
    expect(
      File('lib/widgets/video_popup_player.dart').existsSync(),
      isFalse,
      reason: 'lib/widgets/video_popup_player.dart ainda existe',
    );
  });

  test('não restam referências a vídeos, livro ou dados pessoais em lib/', () {
    String text(List<int> codes) => String.fromCharCodes(codes);
    final proibidos = [
      'ContentRepository',
      'ContentKind',
      'video_popup_player',
      'assets/conteudo',
      text([65, 32, 77, 101, 110, 105, 110, 97, 32, 113, 117, 101, 32, 70, 97, 108, 97, 118, 97]),
      text([80, 111, 114, 32, 72, 101, 108, 244]),
      'capa_livro',
    ];

    final ocorrencias = <String>[];
    for (final arquivo in dartFiles) {
      final conteudo = arquivo.readAsStringSync();
      for (final termo in proibidos) {
        if (conteudo.contains(termo)) {
          ocorrencias.add('${arquivo.path}: encontrado "$termo"');
        }
      }
    }

    expect(ocorrencias, isEmpty, reason: ocorrencias.join('\n'));
  });

  test('Conteúdo e Dashboard não usam video_player', () {
    const arquivos = [
      'lib/pages/conteudo.dart',
      'lib/pages/dashboard.dart',
    ];

    for (final caminho in arquivos) {
      final arquivo = File(caminho);
      expect(arquivo.existsSync(), isTrue, reason: '$caminho não existe');
      expect(
        arquivo.readAsStringSync().contains('video_player'),
        isFalse,
        reason: '$caminho ainda referencia video_player',
      );
    }
  });
}
