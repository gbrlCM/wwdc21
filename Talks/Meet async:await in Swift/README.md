# Meet async/await in Swift

É um modo de escrever código assincrono de forma menos verbosa e segura. quando uma função assincrona é chamada ela desbloqueia a thread e a execução é retornada quando a função termina. a forma anterior de fazer esse código seria com _ _completion handlers_ e o código pode ser visto abaixo:

IMAGEM

Esse tipo de código pode ter bugs dificeis de ver inicialmente, além de ser muito pouco legivel, com o uso de async/await o código é simplificado e tornado mais legivel como pode ser visto da forma a seguir

IMAGEM

O uso de async/await pode ser usado não só em funções mas tambem em propriedades computaveis, inicializadores, ifs, e em for loops no caso de sequencias assincronas.

## Como funciona o Async/Await

No caso de funções normais, quando uma função é chamada é dado para ela o controle da Thread, e a funções só devolve esse controle ao final de sua execução, já em funções assincronas toda vez que é usado um _await_ o controle da Thread é devolvido para o sistema que vai alocar esse tempo para outras coisas, quando a chamada marcada com _await_ termina de ser executada o controle da Thread é devolvido para a função assincrona para que ela termine seu trabalho.

## Como conectar o mundo sincrono com o Assincrono
Para usar funções async dentro de um contexto sincrono basta usar a função _async_ como no exemplo abaixo:
```swift
async {
    try await yourAsyncCode()
}
```

## Criar pontes de Completion handlers com o Async/Await
Através das _continuations_ é possivel usar função com completion handlers como corpo de uma função assincrona. Essas _continuations_ só podem chamar o resume apenas uma vez.


