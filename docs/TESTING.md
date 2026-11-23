# Testes

## Como rodar

```bash
flutter analyze --no-fatal-infos
flutter test
cd backend && npm ci && npm test
```

## Estratégia

Os testes priorizam **comportamento observável**, não detalhes internos.

### App

**36 testes passando** em `test/`:

| Teste | O que garante |
|---|---|
| `AssetResolver.resolveCardBack` | Encontra `Back (1).webp`, variantes de nome e não confunde 1 com 10. |
| `BrCodeGenerator` | Campos obrigatórios, valor formatado, sanitização e CRC16 válido. |
| `FavoritesRepository` | Adiciona, remove e separa favoritos por categoria. |
| `TemasRepository` | 10 temas únicos, completos e sem referências pessoais. |
| `PartnersRepository` | Três marcas fictícias, sem links ou empresas reais. |
| `test/privacy` | Garante que contato, perfil, áudio, vídeo, livro e parceiros reais continuam removidos do código e dos assets. |

### Backend

O backend possui suíte própria em `backend/tests` com Jest + Supertest + Mongo em memória (**65 testes**), cobrindo:

- criação de PIX e consulta de status;
- simulação de pagamento apenas em modo demo;
- ativação idempotente de assinatura;
- rejeição de ativação sem pagamento válido;
- expiração e cancelamento;
- validação de entrada e erros padronizados.

## Lacunas conhecidas

- Testes de widget das telas principais.
- Testes de integração do fluxo onboarding → carta → premium.
- Golden tests para light/dark.

Essas lacunas estão no roadmap e foram priorizadas depois da estabilização visual.
