# Rick and Morty Wiki

Aplicativo Flutter que consome a [Rick and Morty API](https://rickandmortyapi.com) para exibir personagens da série. Permite buscar personagens pelo nome, visualizar detalhes como status e espécie, com suporte a paginação, arquitetura limpa (MVVM), gerenciamento de estado com MobX e código componentizado.

## Funcionalidades

- Listagem de personagens com scroll infinito (paginação)
- Busca por nome de personagem
- Exibição de detalhes do personagem (nome, status, espécie, imagem)
- Refresh da lista (pull to refresh)
- Layout responsivo e moderno
- Código organizado por módulos (viewmodel, model, repository, pages, components)

## Sobre a Arquitetura

Este projeto segue uma adaptação simplificada das diretrizes do [Flutter Architecture Guide](https://docs.flutter.dev/app-architecture/guide), adequada ao escopo atual da aplicação. A estrutura está dividida em três camadas principais:

- **Presentation (UI Layer):** Responsável pelas telas e interface com o usuário.
- **Data Layer:** Responsável pela comunicação com a API e transformação dos dados.
- **Core:** Contém recursos globais como tema, estilos e cliente HTTP.

Na **Presentation Layer**, os componentes foram agrupados diretamente dentro da pasta `presentation`, sem subpastas por página, considerando que o projeto possui apenas duas telas no momento. Essa abordagem mantém o projeto enxuto e mais fácil de navegar durante esta fase inicial.

Na **Data Layer**, optei por consolidar `services` e `repositories` em uma única camada de repositórios. Isso evita código boilerplate desnecessário, já que, neste caso, o repository apenas repassaria chamadas ao service, sem qualquer regra de negócio adicional.

A camada de **Domain** foi omitida propositalmente, pois seu único conteúdo seria uma interface para o repositório, o que traria complexidade desnecessária neste contexto. A interface, quando necessária, pode ser mantida próxima à sua implementação, mantendo o código mais acessível.

A escolha do **MobX** como gerenciador de estado foi feita visando **clareza, legibilidade e adaptação ao escopo atual**. A estrutura com observables e actions torna explícito o que pode ser observado e o que modifica o estado da aplicação, facilitando o entendimento do projeto.

## Como rodar o projeto

Instale as dependências

```sh
 flutter pub get
```

Rode o build do mobx

```sh
flutter pub run build_runner build --delete-conflicting-outputs
```

Execute o app

```sh
flutter run
```

## Testes

O foco dos testes foi validar o funcionamento do repositório responsável por consumir os dados da API, garantindo que os dados retornados estejam no formato esperado.

Para rodar os testes, execute o seguinte comando no terminal:

```sh
flutter test
```

## Melhorias futuras

- Exibir **origem do personagem** e **lista de episódios** na tela de detalhes
- Tornar a lista de personagens **mais intuitiva ao rolar**, aproveitando melhor o espaço da tela
- Adicionar **suporte à localização/tradução** (alguns textos estão em inglês e outros em português)
- Criar **mais testes**, incluindo:
  - Testes de Widget (comportamento da UI)

## Autor

Maicon Jhone  
[LinkedIn](https://www.linkedin.com/in/maicon-jhone/)
