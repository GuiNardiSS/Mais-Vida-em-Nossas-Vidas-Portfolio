import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// Garante que nenhuma referência pessoal (página de contato, imagem de
/// perfil, redes sociais e e-mails) permaneça no código do app.
///
/// Este teste protege o projeto de portfólio: a história do produto fica, mas
/// dados pessoais e a página de contato não.
void main() {
  String text(List<int> codes) => String.fromCharCodes(codes);

  final forbiddenStrings = <String>[
    'ContatoPage',
    'contato.dart',
    'assets/perfil',
    text([104, 101, 108, 111, 95, 99, 111, 101, 108, 104, 111]),
    text([104, 101, 108, 111, 99, 111, 101, 108, 104, 111]),
    text([72, 101, 108, 244, 32, 67, 111, 101, 108, 104, 111]),
    text([101, 117, 64, 104, 101, 108, 111, 99, 111, 101, 108, 104, 111, 116, 101, 114, 97, 112, 101, 117, 116, 97]),
    text([64, 104, 101, 108, 111, 99, 111, 101, 108, 104, 111, 99, 111, 110, 115, 117, 108, 116, 111, 114, 105, 97]),
    text([64, 104, 101, 108, 111, 99, 111, 101, 108, 104, 111, 49, 48]),
    text([108, 105, 110, 107, 101, 100, 105, 110, 46, 99, 111, 109, 47, 105, 110, 47, 104, 101, 108, 244, 99, 111, 101, 108, 104, 111]),
  ];

  List<File> dartFilesUnder(String directory) {
    final dir = Directory(directory);
    if (!dir.existsSync()) return const [];
    return dir
        .listSync(recursive: true)
        .whereType<File>()
        .where((file) => file.path.toLowerCase().endsWith('.dart'))
        .toList()
      ..sort((a, b) => a.path.compareTo(b.path));
  }

  group('Privacidade: referências pessoais removidas', () {
    test('nenhum arquivo .dart em lib/ contém referências proibidas', () {
      final libDir = Directory('lib');
      expect(
        libDir.existsSync(),
        isTrue,
        reason: 'Diretório lib/ não encontrado em ${Directory.current.path}',
      );

      final dartFiles = dartFilesUnder('lib');
      expect(
        dartFiles,
        isNotEmpty,
        reason: 'Nenhum arquivo .dart encontrado dentro de lib/',
      );

      final violations = <String>[];
      for (final file in dartFiles) {
        final contents = file.readAsStringSync().toLowerCase();
        for (final forbidden in forbiddenStrings) {
          if (contents.contains(forbidden.toLowerCase())) {
            violations.add('${file.path}: "$forbidden"');
          }
        }
      }

      expect(
        violations,
        isEmpty,
        reason: 'Referências proibidas encontradas:\n'
            '${violations.join('\n')}',
      );
    });

    test('a pasta assets/perfil não existe mais', () {
      expect(
        Directory('assets/perfil').existsSync(),
        isFalse,
        reason: 'A pasta assets/perfil/ ainda existe e ainda expõe a foto '
            'de perfil pessoal.',
      );
    });
  });
}
