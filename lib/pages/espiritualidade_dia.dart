import 'package:material_ui/material_ui.dart';

import '../design/components/app_background.dart';
import '../design/components/gold_badge.dart';
import '../design/components/soft_card.dart';
import '../design/tokens.dart';
import '../features/partners/partners_repository.dart';

class EspiritualidadeDiaPage extends StatelessWidget {
  const EspiritualidadeDiaPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Patrocinadores')),
      body: AppBackground(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.page,
            AppSpacing.xs,
            AppSpacing.page,
            AppSpacing.xxl,
          ),
          children: [
            Text(
              'Marcas fictícias que\ncaminham com o propósito',
              style: theme.textTheme.displayMedium,
            ),
            const SizedBox(height: 4),
            Text(
              'Marcas de demonstração criadas para o portfólio, sem vínculo '
              'com empresas reais.',
              style: theme.textTheme.bodyMedium,
            ),
            const SizedBox(height: AppSpacing.lg),
            for (final parceiro in PartnersRepository.all) ...[
              _PartnerCard(
                parceiro: parceiro,
                onOpen: () => _mostrarDetalhes(context, parceiro),
              ),
              const SizedBox(height: 12),
            ],
            const SizedBox(height: AppSpacing.sm),
            SoftCard(
              color: AppColors.petrol,
              borderColor: Colors.transparent,
              child: Row(
                children: [
                  const Icon(Icons.handshake_outlined,
                      color: AppColors.goldBright, size: 26),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Quer caminhar com o projeto? Esta é uma demonstração de portfólio.',
                      style: theme.textTheme.bodyMedium!.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PartnerCard extends StatelessWidget {
  const _PartnerCard({required this.parceiro, required this.onOpen});

  final Partner parceiro;
  final VoidCallback onOpen;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SoftCard(
      padding: EdgeInsets.zero,
      onTap: onOpen,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(AppRadii.lg),
            ),
            child: Container(
              height: 130,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    parceiro.accentColor.withValues(alpha: 0.18),
                    AppColors.creamDeep,
                  ],
                ),
              ),
              alignment: Alignment.center,
              child: _PartnerLogo(partner: parceiro),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        parceiro.name,
                        style: theme.textTheme.headlineMedium,
                      ),
                    ),
                    const GoldBadge(
                      label: 'Demonstração',
                      icon: Icons.auto_awesome,
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  parceiro.description,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodyMedium,
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Icon(
                      Icons.auto_awesome_outlined,
                      size: 16,
                      color: AppColors.gold,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Marca fictícia',
                      style: theme.textTheme.labelSmall,
                    ),
                    const Spacer(),
                    Icon(
                      Icons.chevron_right,
                      color: theme.colorScheme.outline,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PartnerLogo extends StatelessWidget {
  const _PartnerLogo({required this.partner, this.size = 76});

  final Partner partner;
  final double size;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            partner.accentColor,
            Color.lerp(partner.accentColor, AppColors.petrolDeep, 0.35)!,
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: partner.accentColor.withValues(alpha: 0.28),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      alignment: Alignment.center,
      child: Text(
        partner.initials,
        style: theme.textTheme.headlineMedium!.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.w700,
          letterSpacing: 1.4,
        ),
      ),
    );
  }
}

void _mostrarDetalhes(BuildContext context, Partner parceiro) {
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
          maxWidth: 520,
          maxHeight: MediaQuery.of(context).size.height * 0.8,
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
                  const Icon(Icons.handshake_outlined,
                      color: AppColors.goldBright, size: 20),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      parceiro.name,
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(child: _PartnerLogo(partner: parceiro, size: 88)),
                      const SizedBox(height: 20),
                      Text(
                        parceiro.description,
                        style: theme.textTheme.bodyLarge!.copyWith(height: 1.6),
                      ),
                      const SizedBox(height: 18),
                      Row(
                        children: [
                          const Icon(
                            Icons.auto_awesome_outlined,
                            color: AppColors.gold,
                            size: 18,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'Marca fictícia criada para demonstração de portfólio.',
                              style: theme.textTheme.labelSmall,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
