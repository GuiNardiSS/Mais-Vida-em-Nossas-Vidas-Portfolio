import 'package:flutter_test/flutter_test.dart';

import 'package:meu_app_flutter/features/partners/partners_repository.dart';

void main() {
  group('PartnersRepository', () {
    test('expõe exatamente três marcas fictícias', () {
      expect(PartnersRepository.all, hasLength(3));
    });

    test('ids e nomes são únicos', () {
      final ids = PartnersRepository.all.map((partner) => partner.id).toSet();
      final names = PartnersRepository.all.map((partner) => partner.name).toSet();

      expect(ids, hasLength(PartnersRepository.all.length));
      expect(names, hasLength(PartnersRepository.all.length));
    });

    test('cada parceiro tem descrição, iniciais e cor de destaque', () {
      for (final partner in PartnersRepository.all) {
        expect(partner.id.trim(), isNotEmpty);
        expect(partner.name.trim(), isNotEmpty);
        expect(partner.description.trim(), isNotEmpty);
        expect(partner.initials.trim(), isNotEmpty);
      }
    });

    test('não expõe links, contatos ou nomes de empresas reais', () {
      const proibidos = [
        'http',
        'www',
        '@',
        'Bele Beauty',
        'Reffinatto',
        'Marangoni',
      ];

      for (final partner in PartnersRepository.all) {
        final textos = [
          partner.id,
          partner.name,
          partner.description,
          partner.initials,
        ].join(' ').toLowerCase();

        for (final proibido in proibidos) {
          expect(
            textos.contains(proibido.toLowerCase()),
            isFalse,
            reason: 'O parceiro "${partner.name}" contém "$proibido".',
          );
        }

        expect(textos.contains('helô'), isFalse);
        expect(textos.contains('helo'), isFalse);
      }
    });
  });
}
