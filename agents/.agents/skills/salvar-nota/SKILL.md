---
name: salvar-nota
description: Documenta "coisas" discutidas na sessão como notas no vault Obsidian
  (References/ para o mundo, Personal/ para o pessoal). Use sempre que o usuário
  pedir para "documentar", "salvar como nota", "registrar no vault", "salvar no
  obsidian", "criar uma nota sobre X", "anotar isso", ou quiser capturar um
  conceito/ferramenta/pessoa/lugar/mídia que apareceu na conversa — mesmo que ele
  não diga a palavra "nota".
---

# salvar-nota

Cria uma nota por "coisa" discutida na sessão, seguindo as convenções do vault
(modelo Kepano: organizado por pasta, não por assunto).

O vault é uma pasta de arquivos Markdown. "Salvar" significa escrever o `.md` na
pasta certa; não é preciso abrir o aplicativo Obsidian.

## Passo a passo

1. **Leia `AGENTS.md`** na raiz do vault. Ele é a fonte da verdade das regras
   (privacidade, vocabulário, delete test, "sem emoji"). Se não achar, use
   `references/convencoes.md` (nesta skill) como fallback.
2. **Identifique o que documentar.** O usuário aponta uma ou mais coisas (ex.:
   "documente o `kubectl` e o `ArgoCD`"). Se não estiver claro, liste os candidatos
   que apareceram na conversa e pergunte quais salvar.
3. **Aplique o delete test** para cada item: se eu apagar a nota, o objeto continua
   existindo no mundo (ferramenta, conceito, livro, filme, cidade, pessoa pública)?
   - **Sim** → `References/` (mundo).
   - **Não** (diário, saúde, finanças, opinião, sentimento, algo seu) → `Personal/`.
4. **Conteúdo pessoal exige confirmação.** Nunca escreva em `Personal/` sem o OK
   explícito do usuário. Pergunte antes ("isso é pessoal — salvo em `Personal/`?") e
   só prossiga se ele confirmar. Nunca leia nem liste `Personal/` ou `Journal/`.
5. **Classifique** o item (ver `references/convencoes.md` para as listas completas):
   - `categories`: uma das categorias finais (o "balde").
   - `type`: o que a nota é (ex.: `tool`, `concept`, `band`, `album`, `moc`).
   - `providers` / `subjects`: só para `Cloud`.
   - `source`: de onde veio (livro, autor, link).
   - `topics`: rótulos livres (`k8s`, `stormlight`, `linux`…).
   - `rating` (1–7), `status`, `year` quando fizer sentido.
6. **Evite duplicata.** Antes de criar, procure uma nota existente pelo nome de
   forma flexível — não só pelo basename exato. As notas do vault usam prefixos em
   português (`Banda Opeth`, `Livro X`, `Álbum Y`) e apelidos. Confira aliases e
   variações (ex.: procurar `Opeth` deve achar `Banda Opeth`). Se achar, ofereça
   complementar a existente em vez de criar outra.
7. **Escreva a nota** na pasta certa:
   - Frontmatter conforme o padrão (as chaves relevantes; não invente).
   - Corpo com 2–4 linhas resumindo o que foi discutido + wikilinks para o que
     tiver relação (ex.: `[[Kubernetes]]`, `[[Brandon Sanderson]]`).
   - **Sem emoji** e sem caracteres especiais (regra do vault).
8. **Reporte** o que criou: caminho + categoria/type de cada nota.

## Regras rígidas

- A fronteira privado/público é a **pasta**, não um flag no frontmatter. Não use
  `private:`.
- `categories` só recebe categorias finais. Título de livro, nome de personagem ou
  tópico **nunca** vão em `categories` — vão em `source`, `topics` ou no corpo.
- Se a coisa for um **índice/coleção de um tema** (ex.: "Mar e Praia"), use
  `type: moc` e monte o corpo como lista curada de links.
- Se a coisa for **indecisa** (o usuário não sabe onde pôr), salve em `Personal/`
  com `categories: [[Inbox]]` e avise que ficará para triagem — mas só com
  confirmação, por ser `Personal/`.

## Exemplos

**Exemplo 1**
Input: "documente o `kubectl` e o `ArgoCD` que a gente falou"
Output: duas notas em `References/` — `kubectl.md` e `ArgoCD.md` — com
`categories: [[Kubernetes]]` (ou `[[Tools]]`), `type: tool`, sem emoji, corpo
resumindo o uso discutido.

**Exemplo 2**
Input: "salva uma nota sobre a minha consulta médica de hoje"
Output: a skill pergunta ("isso é pessoal — salvo em `Personal/`?") e, com o OK,
cria a nota em `Personal/` (nunca lê nem lista a pasta antes).

**Exemplo 3**
Input: "registra a banda Opeth e o álbum Blackwater Park"
Output: `Opeth.md` (`categories: [[Music]]`, `type: band`) e
`Blackwater Park.md` (`categories: [[Music]]`, `type: album`, `artist: [[Opeth]]`).
