# let EsseArtigo = try await gabrielTerminarDeEscrever()
#Blog

Com a WWDC21 muitas novidades chegaram para o mundo do iOS e uma das mais antecipadas foi o Swift 5.5. Dentre muitas novidades essa versão da linguagem disponibiliza novas formas de lidar com código assíncrono e provavelmente a mais esperada delas é o _async/await._

## Mas o que é o async / await?  🤔
O _async/await_ é uma forma de anotar suas funções para que elas sejam executadas de forma assíncronas, isso permite que você escreva código de forma mais simples e que parece código síncrono, além disso com algumas funcionalidades da implementação do _async/await_ no Swift é possível até mesmo fazer paralelismo de forma simples, isso pode ser evidenciado com um exemplo de chamada de API com o _URLSessions_ com e sem _async/await_, como nos exemplos abaixo:

```swift
func callAPI() {
let session = URLSession.shared
let url = URL(string: "...")!

let task = session.dataTask(with: url) { data, response, error in

    if error != nil || data == nil {
        print("Client error!")
        return
    }

    guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
        print("Server error!")
        return
    }

    guard let mime = response.mimeType, mime == "application/json" else {
        print("Wrong MIME type!")
        return
    }

    do {
        let json = try JSONSerialization.jsonObject(with: data!, options: [])
        print(json)
    } catch {
        print("JSON error: \(error.localizedDescription)")
    }        
}

task.resume()
}
``` 

Todo esse código era necessário para fazer uma chamada de API, além de grande ele tem muitas possibilidades de erro, já que caso fosse um exemplo real, haveria um _completionHandler_ para lidar com o recebimento dos dados, e seria necessário chamar esse _completionHandler_ dentro de todos os _guards_e _catchs_ com o _async/await_ agora é possível fazer uma chamada assim com a seguinte linha de código:
```swift
func callAPI() async throws {
    let session = URLSession.shared
    guard let url = URL(string: "...") else {
        throw APIError.badURL    
    }

    let (data, response) = try await session.data(from: url)
    let json = try JSONSerialization.jsonObject(with: data!,     options: []) 
    print(json)

}
```
E é simples assim, com o _async/await_ todo aquele código repetido e _completionHandler_ são eliminados, e com a ajuda do _throws_ o compilador te obriga a verificar o erros dentro do contexto cabível na sua aplicação.

## Como o async/await funciona?
Em funções síncronas o controle da Thread é dada para a função pelo sistema e só é devolvida para quando ela termina, retorna ou joga um erro, já no caso de funções assíncronas marcadas com o _async_, sempre que um _await_ é chamado dentro dela a função retorna o controle da Thread para o sistema a liberando para execução de outras coisas, quando a chamada marcada com _await_ o sistema é avisado e o controle da Thread é dada para a função _async_ no momento mais oportuno. Isso é feito até a função retorne, acabe ou jogue algum erro.

## Onde posso usar o async/await
O _async/await_ pode ser usado para marcar funções, inicializadores e propriedades computáveis, além disso para chamar uma função assíncronas é necessário estar em um contexto assíncrono.

## Se preciso de um contexto assíncrono como conecto o mundo síncrono com o assíncrono
A forma mais fácil de usar código assíncrono dentro de um contexto síncrono é colocado dentro de um bloco _async_ e isso é feito da seguinte forma:
```swift

async {
    try? await callAPI()
}
```
Além disso existem diversas funções dentro das API da Apple que aceitam código assíncrono como é o caso do _task_ do SwiftUI

## Conclusão
As adições do Swift 5.5 ajudam e muito o desenvolvedor a lidar com o código assíncrono, dando a ela diversas armas para trabalhar. O objetivo disso é tornar o código assíncrono igualmente simples de escrever como qualquer código síncrono.
