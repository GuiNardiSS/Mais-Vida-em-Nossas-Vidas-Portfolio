import 'package:material_ui/material_ui.dart';

/// Marca fictícia exibida na página de patrocinadores.
///
/// Os dados são apenas ilustrativos, criados para demonstração de portfólio.
class Partner {
  const Partner({
    required this.id,
    required this.name,
    required this.description,
    required this.initials,
    required this.accentColor,
  });

  final String id;
  final String name;
  final String description;
  final String initials;
  final Color accentColor;
}

/// Marcas fictícias de demonstração.
abstract final class PartnersRepository {
  static const List<Partner> all = [
    Partner(
      id: 'casa-aurora',
      name: 'Casa Aurora',
      description:
          'Estúdio fictício de design de interiores que valoriza ambientes '
          'acolhedores, luz natural e a calma dos pequenos rituais.',
      initials: 'CA',
      accentColor: Color(0xFFC97B4A),
    ),
    Partner(
      id: 'verde-vivo',
      name: 'Verde Vivo',
      description:
          'Marca fictícia de jardinagem urbana dedicada a cultivar bem-estar, '
          'contato com a natureza e cuidado com o cotidiano.',
      initials: 'VV',
      accentColor: Color(0xFF4C8A5E),
    ),
    Partner(
      id: 'atelie-sereno',
      name: 'Ateliê Sereno',
      description:
          'Ateliê fictício de cerâmica que celebra o feito à mão, a pausa e a '
          'beleza das coisas simples.',
      initials: 'AS',
      accentColor: Color(0xFF6E7FA8),
    ),
  ];
}
