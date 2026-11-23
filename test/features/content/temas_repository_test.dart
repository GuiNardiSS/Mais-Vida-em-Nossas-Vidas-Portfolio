import 'package:flutter_test/flutter_test.dart';

import 'package:meu_app_flutter/features/content/temas_repository.dart';

void main() {
  group('TemasRepository', () {
    const temas = TemasRepository.all;

    test('contém exatamente 10 temas', () {
      expect(temas, hasLength(10));
    });

    test('todos os temas têm id, título, resumo e corpo preenchidos', () {
      for (final tema in temas) {
        expect(tema.id.trim(), isNotEmpty, reason: 'id vazio em ${tema.title}');
        expect(tema.title.trim(), isNotEmpty, reason: 'título vazio');
        expect(
          tema.summary.trim(),
          isNotEmpty,
          reason: 'resumo vazio em ${tema.title}',
        );
        expect(
          tema.body.trim(),
          isNotEmpty,
          reason: 'corpo vazio em ${tema.title}',
        );
      }
    });

    test('ids e títulos são únicos', () {
      expect(temas.map((tema) => tema.id).toSet(), hasLength(temas.length));
      expect(temas.map((tema) => tema.title).toSet(), hasLength(temas.length));
    });

    test('contém os dez temas esperados', () {
      expect(
        temas.map((tema) => tema.title),
        equals(const [
          'Espiritualidade',
          'Autoconhecimento',
          'Gratidão',
          'Fé',
          'Resiliência',
          'Compaixão',
          'Propósito',
          'Liberdade',
          'Perdão',
          'Amor',
        ]),
      );
    });

    test('não menciona referências pessoais', () {
      String text(List<int> codes) => String.fromCharCodes(codes);
      final proibidos = [
        text([72, 101, 108, 244]),
        text([104, 101, 108, 111, 99, 111, 101, 108, 104, 111]),
        text([67, 111, 101, 108, 104, 111]),
      ];
      for (final tema in temas) {
        final texto =
            '${tema.id}\n${tema.title}\n${tema.summary}\n${tema.body}';
        for (final termo in proibidos) {
          expect(
            texto.contains(termo),
            isFalse,
            reason: 'tema "${tema.title}" contém "$termo"',
          );
        }
      }
    });
  });
}
