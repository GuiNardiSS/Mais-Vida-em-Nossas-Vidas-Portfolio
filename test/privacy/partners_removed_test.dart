import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Patrocinadores sem dados reais', () {
    test('a página não usa links externos nem cita empresas reais', () {
      final arquivo = File('lib/pages/espiritualidade_dia.dart');
      expect(arquivo.existsSync(), isTrue);

      final fonte = arquivo.readAsStringSync().toLowerCase();
      String text(List<int> codes) => String.fromCharCodes(codes);
      final proibidos = [
        'url_launcher',
        'launchurl',
        'canlaunchurl',
        'image.asset',
        '_parceiroimagepath',
        'whatsapp',
        'instagram',
        'bele beauty',
        'reffinatto',
        'marangoni',
        text([104, 101, 108, 244]),
        text([104, 101, 108, 111]),
      ];

      for (final proibido in proibidos) {
        expect(
          fonte.contains(proibido.toLowerCase()),
          isFalse,
          reason: 'A página ainda contém "$proibido".',
        );
      }
    });

    test('a pasta de logos reais foi removida', () {
      expect(Directory('assets/parceiros').existsSync(), isFalse);
    });
  });
}
