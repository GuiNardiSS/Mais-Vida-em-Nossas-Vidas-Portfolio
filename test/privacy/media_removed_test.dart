import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// Garante que toda a mídia de voz/vídeo (e as funcionalidades que dependem
/// dela) foi removida do aplicativo.
void main() {
  group('pastas de mídia removidas', () {
    const removedDirectories = <String>[
      'assets/audios_cartas_dia',
      'assets/audios_cartas_org',
      'assets/intro',
      'assets/assinaturas',
      'assets/conteudo',
    ];

    for (final path in removedDirectories) {
      test('$path não existe', () {
        expect(
          Directory(path).existsSync(),
          isFalse,
          reason: 'A pasta $path ainda existe no projeto.',
        );
      });
    }
  });

  group('referências de mídia removidas do código', () {
    const scannedFiles = <String>[
      'lib/pages/cartas_intro.dart',
      'lib/pages/assinaturas.dart',
      'lib/pages/card_reader_page.dart',
      'lib/core/assets/asset_resolver.dart',
    ];

    const forbiddenTokens = <String>[
      'audioplayers',
      'audio_service',
      'AudioPlayerBar',
      'AudioService',
      'video_player',
      'VideoPlayerController',
      'assets/audios',
      'assets/intro',
      'assets/assinaturas',
      'assets/conteudo',
    ];

    for (final file in scannedFiles) {
      test('$file não referencia mídia de áudio/vídeo', () {
        final source = File(file);
        expect(
          source.existsSync(),
          isTrue,
          reason: 'Arquivo esperado não encontrado: $file',
        );

        final content = source.readAsStringSync();
        for (final token in forbiddenTokens) {
          expect(
            content.contains(token),
            isFalse,
            reason: '$file ainda contém "$token".',
          );
        }
      });
    }
  });
}
