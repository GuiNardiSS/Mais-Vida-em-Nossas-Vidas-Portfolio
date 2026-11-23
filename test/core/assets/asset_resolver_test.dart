import 'package:flutter_test/flutter_test.dart';
import 'package:meu_app_flutter/core/assets/asset_resolver.dart';

void main() {
  AssetResolver resolverWith(Set<String> assets) {
    return AssetResolver(assetLister: () async => assets);
  }

  group('AssetResolver.resolveCardBack', () {
    test('encontra o nome no formato usado pelos assets atuais', () async {
      final resolver = resolverWith({
        'assets/cartas_do_dia/Back (1).webp',
        'assets/cartas_do_dia/Back (2).webp',
      });

      expect(
        await resolver.resolveCardBack('assets/cartas_do_dia', 0),
        'assets/cartas_do_dia/Back (1).webp',
      );
      expect(
        await resolver.resolveCardBack('assets/cartas_do_dia', 1),
        'assets/cartas_do_dia/Back (2).webp',
      );
    });

    test('aceita variantes sem espaço ou com extensão maiúscula', () async {
      final resolver = resolverWith({
        'assets/cartas/Back(3).webp',
      });

      expect(
        await resolver.resolveCardBack('assets/cartas', 2),
        'assets/cartas/Back(3).webp',
      );
    });

    test('não confunde a carta 1 com a carta 10', () async {
      final resolver = resolverWith({
        'assets/cartas/Back (10).png',
      });

      expect(await resolver.resolveCardBack('assets/cartas', 0), isNull);
      expect(
        await resolver.resolveCardBack('assets/cartas', 9),
        'assets/cartas/Back (10).png',
      );
    });

    test('retorna null quando a imagem não existe', () async {
      final resolver = resolverWith({'assets/cartas/Back (1).png'});

      expect(await resolver.resolveCardBack('assets/cartas', 49), isNull);
    });
  });
}
