import 'package:material_ui/material_ui.dart';

import '../design/tokens.dart';
import '../features/content/temas_repository.dart';

class ConteudoPage extends StatelessWidget {
  const ConteudoPage({super.key, this.embedded = false});

  final bool embedded;

  @override
  Widget build(BuildContext context) {
    final list = ListView.builder(
      padding: EdgeInsets.fromLTRB(
        AppSpacing.page,
        embedded ? 4 : AppSpacing.md,
        AppSpacing.page,
        AppSpacing.xxl,
      ),
      itemCount: TemasRepository.all.length,
      itemBuilder: (context, index) {
        final tema = TemasRepository.all[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: AppSpacing.md),
          child: _TemaCard(
            index: index,
            tema: tema,
            onTap: () => _showTema(context, tema),
          ),
        );
      },
    );

    if (!embedded) {
      return Scaffold(
        appBar: AppBar(title: const Text('Conteúdo')),
        body: list,
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Conteúdo',
                  style: Theme.of(context).textTheme.displayMedium),
              const SizedBox(height: 2),
              Text(
                'Leituras para aprofundar a sua jornada.',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
        Expanded(child: list),
      ],
    );
  }

  void _showTema(BuildContext context, Tema tema) {
    final theme = Theme.of(context);
    showDialog<void>(
      context: context,
      builder: (ctx) => Dialog(
        insetPadding: const EdgeInsets.all(20),
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadii.lg),
        ),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: 560,
            maxHeight: MediaQuery.of(context).size.height * 0.82,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(20, 16, 8, 16),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppColors.petrolDeep, AppColors.petrol],
                  ),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.spa,
                        color: AppColors.goldBright, size: 20),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        tema.title,
                        style: theme.textTheme.headlineMedium!.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.of(ctx).pop(),
                      icon: const Icon(Icons.close, color: Colors.white),
                    ),
                  ],
                ),
              ),
              Flexible(
                child: Container(
                  color: theme.colorScheme.surface,
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(20),
                    child: Text(
                      tema.body,
                      style: theme.textTheme.bodyLarge!.copyWith(height: 1.7),
                    ),
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                color: theme.colorScheme.surface,
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
                child: FilledButton(
                  onPressed: () => Navigator.of(ctx).pop(),
                  child: const Text('Fechar'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TemaCard extends StatelessWidget {
  const _TemaCard({
    required this.index,
    required this.tema,
    required this.onTap,
  });

  final int index;
  final Tema tema;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadii.lg),
        child: Ink(
          height: 158,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppRadii.lg),
            border: Border.all(
              color: AppColors.gold.withValues(alpha: 0.32),
            ),
            image: const DecorationImage(
              image: AssetImage('assets/logo_conheca_mais.webp'),
              fit: BoxFit.cover,
            ),
            boxShadow: AppShadows.soft(theme.brightness),
          ),
          child: Stack(
            fit: StackFit.expand,
            children: [
              DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppRadii.lg),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      AppColors.petrolDeep.withValues(alpha: 0.88),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 10,
                left: 10,
                child: Container(
                  width: 24,
                  height: 24,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    color: AppColors.goldBright,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    '${index + 1}',
                    style: const TextStyle(
                      color: AppColors.petrolDeep,
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 14,
                right: 14,
                bottom: 14,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      tema.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.titleLarge!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      tema.summary,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodySmall!.copyWith(
                        color: Colors.white.withValues(alpha: 0.85),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
