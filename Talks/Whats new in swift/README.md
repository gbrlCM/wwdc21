# Whats New in Swift

## SPM - Swift Package Manager

### Package Collections
Forma de encontrar pacotes e agrupa-los diratamente dentro do Xcode. Além de term uma UI mais facil de entender para importar pacotes.

para saber mais acesse esse [link](https://swift.org/bloh/package-collections)

### Novos pacotes feitos pela apple

1. Swift Collections - Pacote que adiciona novos tipos de coleções para o Swift, alguns deles são _Deque_, _OrderedSet_ e _OrderedDictionary_.
2. Swift Algorithms - Pacote com algoritmos para sequencias e coleções, contem atualmente 40 algoritmos.
3. Swift System - Pacote que disponiliza uma interfarce para chamadas de baixo nivel para o sistema.
4. Swift Numerics - Pacote que disponiliza novos tipos númericos, como log, números complexos e Float16.
5. ArgumentParser - 

## Swift on Server
1. Melhora de deploy e inicio de aplicações no servidor no linux.
2. Melhora na perfomance na AWS.
3. Melhora no uso de JSON.
4. AWS Lambda agora disponiliza API com async await.

## Swift DocC
Compilador de documentações, que usa markdown e outras tecnologias para fazer documentações de forma mais simples.
**Será Open Source a partir do final do ano**

## Build Improvements
Melhoras no build e diminuição de recompilação de arquivos, o que diminui em um terço o tempo de build.

## Melhorias no Arc
Arc agora tem uma forma mais agressiva de contar referencias o que pode melhorar a performance e tamanho dos build.

## Result Builders
Criado originalmente para o SwiftUI com o nome de _Function Builder_ os Result Builders agora são features da linguagem e são uma forma de descrever hierarquia complexa de objetos, com condicionais, loops e etc.

## Codable Enum
Melhorias feitas para o caso de _load_ e _store_ algo comum no uso de Codable, que agora é implementado diretamente pelo protocolo.

## Static Member Lookup
Melhoria na inferencia do Swift que agora permite chamar elementos de objetos que tem o tipo inferido, como por exemplo no uso de uma cor exemplo: 
``` swift
let color = .systemRed.components
```

## Property Wrappers
Agora é permitido usar property wrappers dentro de funções, parametros e retornos. Isso permite códigos com swiftUI muito mais simples e legivel.

## Concurrency

### Async / Await
Agora é possivel usar Async / Await em swift. O que facilita e muito como criar código assincrono e paralelo, um bom exemplo de uso é uma chamada de API usando o _URLSession_ como no exemplo abaixo:
``` swift
let (data, response) = try await URLSession.shared.data(from: url)
```
Essa é uma sintaxe muito mais simples do que a usada anteriormente e até mesmo a sintaxe do Combine lançada em 2019

### Strutured Concurrency
Agora é possivel estruturar seu código de forma paralela com uma sintaxe muito simples, usando o _async let_ quer permite estruturar código de forma paralela e segura.

### Actors
Actors são _Reference types_ que são _Thread safe_ o que permite ser usado paralelamente de forma segura.
