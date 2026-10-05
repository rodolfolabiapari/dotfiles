# Convenções do vault (snapshot)

Fallback quando `AGENTS.md` não estiver acessível. O `AGENTS.md` na raiz do vault é
a fonte da verdade — se houver divergência, siga o `AGENTS.md`.

## Estrutura e fronteira

- `Personal/` — notas pessoais (privado; a IA não lê nem edita sem OK explícito).
- `Journal/` — daily notes (privado; idem).
- `References/` — objetos do mundo (livros, ferramentas, conceitos, lugares,
  pessoas públicas, mídia, ficção, receitas).
- `Clippings/` — textos de outros autores.
- `System/` — templates, bases, categorias, anexos.

**Delete test:** se apagar a nota o objeto continua existindo no mundo → `References/`.
Se é sua vida/opinião/sentimento → `Personal/`.

## Categorias finais (`categories`)

`Books`, `Music`, `Movies`, `Shows`, `Podcasts`, `Games`, `People`, `Places`,
`Companies`, `Concepts`, `Tools`, `Products`, `Events`, `Cloud`, `Kubernetes`, `IA`,
`Computing`, `Quotes`, `Recipes`, `Clippings`, `Projects`.

Nunca coloque título de livro, nome de personagem ou tópico em `categories`.

## `type` (o que a nota é)

`album` · `band` · `song` · `movie` · `show` · `podcast` · `episode` · `game` ·
`board-game` · `person` · `place` · `company` · `concept` · `tool` · `app` ·
`product` · `event` · `certification` · `runbook` · `snippet` · `tutorial` · `moc`

## Propriedades

- `providers` (só Cloud): `AWS`, `Google Cloud`, `Azure`.
- `subjects` (só Cloud): `Networking`, `Compute`, `Storage`, `Security`,
  `Databases`, `Analytics`, `AI-ML`.
- `source`: origem (livro, autor, link).
- `topics`: rótulos livres (`k8s`, `stormlight`, `cosmere`, `linux`, `mar`…).
- `rating`: inteiro 1–7.
- `status`: estado (`unread`/`reading`/`read`, `studying`, `todo`…).
- `people` / `places` / `companies` / `books` / `concepts`: listas de wikilinks
  relacionadas.

## Estilo

- Sem emoji nem caracteres especiais.
- Use wikilinks no corpo para ligar a notas existentes.
- MOC / índice temático → `type: moc` (o corpo é uma lista curada de links).
- Inbox (nota que você não sabe onde pôr) → `Personal/` com `categories: [[Inbox]]`.
