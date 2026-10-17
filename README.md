# im-mottu-mobile — sanitized portfolio copy

Personal implementation of a completed historical Flutter/Marvel hiring challenge, with BLoC, tests and platform integration.

## Setup and scope

Supply your own Marvel credentials with `--dart-define=MARVEL_PUBLIC_KEY=... --dart-define=MARVEL_PRIVATE_KEY=...`. Firebase configuration has explicit placeholders and must be regenerated for your own project. Client-side defines do not make a private key secret in a distributed binary; this is an educational client, not a production credential-storage pattern. Original challenge instructions and credits remain below.

Use a Flutter/Dart version compatible with the checked-in `pubspec.yaml`; several projects require Dart 2. No SDK upgrade or passing application build is claimed by this publication.

## History and provenance

This new repository contains a sanitized copy of the original Git history. Original commit authors, committers and dates were preserved; affected hashes changed. The original repository stays private and unchanged. Provider credentials were removed from every retained branch before upload. This does not revoke the old credentials. No license or authorship was reassigned.

Automated publication checks cover history metadata, sensitive-value removal and secret scanning. They do not establish provider availability, backend permissions, or a working build on current Flutter. Application tests not explicitly listed as run remain unverified.

## Original project notes


# 🛵 I'm Mottu Mobile 🛵

### Teste prático para desenvolvedores Mobile Mottu

### Checklist
- [x]  NÍVEL 1
- [x]  NÍVEL 2
- [x]  NÍVEL 3
- [x]  Configurar Firebase crashlytics.
- [x]  Criar channel em kotlin, capturar a mudança de conexão, e mostrar uma mensagem de offline no flutter. 

> *Este teste está separado em 3 níveis de dificuldade. Você pode desenvolver seu teste APP atendendo apenas a um nível, ou a todos.*
>
> **Para todos os níveis você deve executar algumas etapas iniciais:**
>- Fazer um **fork** deste repositório para o seu Github, de forma **privada**, e adicionar os usuarios `@brunosmm`, `@BetoMottu`, `@moreirawebmaster`,`@jeanchrocha,` `@astraube`.
>- Criar um projeto Flutter com a seguinte configuração de package: `com.mottu.marvel`.
>- Criar uma conta de desenvolvedor em `developer.marvel.com`.
>- Gerar uma **API KEY** no site de desenvolvedor da **Marvel**, e consumir suas respectivas **API's**.
>- Criar um readme marcando os itens feitos.
>- Buildar para plataforma iOS.
>
> **Sugestões:**
>- Não faça apenas um commit com toda sua implementação.
>- Realize os commits em branchs separadas e utilize PRs.
>- Seja criativo(a) na sua implementação.
>- Não faça **Ctrl+C / Ctrl+V** de outro repositório !!!



# NÍVEL 1 - nome da branch (level_1):
- Executar etapas iniciais;
- Mostrar a listagem dos personagens (imagem e nome);
- Ação de clique nos cards da listagem e exibir os detalhes (imagem, nome e descrição);


# NÍVEL 2 - nome da branch (level_2):
- Executar etapas iniciais;
- Guardar em cache as consultas realizadas na API Marvel;
- Mostrar a listagem dos personagens (imagem e nome);
- Criar um filtro para a listagem;
- Ação de clique nos cards da listagem e exibir os detalhes (imagem, nome, descrição e personagens relacionados);


# NÍVEL 3 - nome da branch (level_3):
- Executar etapas iniciais;
- Criar uma Splashscreen customizada;
- Guardar em cache as consultas realizadas na API Marvel;
- Limpar cache de consultas no fechamento do APP;
- Mostrar a listagem dos personagens (imagem e nome);
- Criar um filtro para a listagem;
- Ciar uma paginação da listagem;
- Ação de clique nos cards da listagem e exibir os detalhes (imagem, nome, descrição e personagens relacionados);
- Ação de clique nos personagens relacionados e exibir os detalhes (imagem, nome, descrição e personagens relacionados);

> Ao final de cada etapa, criar PR para a branch **main** e realizar o merge.

# Pontos extras (opcional):
- Utilizar Getx.
- Configurar Firebase crashlytics.
- Criar channel em kotlin, capturar a mudança de conexão, e mostrar uma mensagem de offline no flutter.
