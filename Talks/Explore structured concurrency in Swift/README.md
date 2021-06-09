# Explorer structured concurrency in Swift

A programação estruturada permite que você dê uma sequencia e lógica linear de como um código funciona.

código assíncrono com _completionHandlers_ não permite usar estruturas comuns da programação como if, for e try catch. isso por que não é um código sequencial e precisa de uma função como parametro para executar algo quando o valor que foi pedido é retornado.

Com uso de async/await é possivel usar a lógica da programação estruturada, tratando o código como algo síncrono e deixar o sistema lidar com o lado assíncrono.

## Task
Task dão um contexto assíncrono para execução de código paralelo. A execução dessas task são realizadas pelo sistema, quando ela achar que é a melhor hora.

### Task - async let
Async let é uma forma de criar uma Task que roda de forma assincrona como no exemplo abaixo:
```swift
async let (data, results) = URLSessions.shared.data(from: url)
```
Nesse exemplo uma task é criada executar o download da informação, enquanto isso ocorre um valor temporario é atribuido as variavies e quando é pedido pelo _await_ de alguma delas a função para de executar e só é retomada a execução com o final da task. Um exemplo de uso de _async let_ é multiplas chamadas de API paralelas como no exemplo a seguir:

```swift
async let (imageData, _) = URLSessions.shared.data(from: imageURL)
async let (textData, _) = URLSessions.shared.data(from: textURL)

let image = try await UIImage(data: imageData)
let text = try await JSONDecoder().decode(String.self, from: textData)

buildBlogPost(cover: image, content: text)
```
Dessa forma é possivel executar as duas chamadas ao mesmo tempo já que ambas são independentes, tendo assim um código mais rápido.

### Cancelamento de Task
Task são aninhadas em outras tasks, quando uma task falha todas as tasks irmãs são marcadas para cancelamento que por sua vez marca toda as tasks filhas, esse cancelamento não significa o final de uma task e sim a marcação para que o seu valor seja descartado. 

### Group Task
Group tasks são formas de fazer paralelismo quando é necessario uma quantidade dinamica de tasks como em chamadas assíncronas para todos os elementos de uma lista, com as group tasks é possível fazer de forma thread safe leituras e escritas de varios elementos paralelamente como no exemplo abaixo:
```swift

func fetchThumbnails(for ids: [String]) async throws -> [String: UIImage] {
    var thumbnails: [String: UIImage] = [:]
    try await withThrowingTaskGroup(of: (String, UIImage).self) {group in
        for id in ids {
            group.async {
                return (id, try await fetchOneThumbnail(withID: id)
            }
        }
        
        for try await (id, thumbnail) in group {
            thumbnails[id] = thumbnail
        }
    }
    return thumbnails
}
```
Ok! Esse código tem muita informação então vamos lá, withThrowingTaskGroup é a forma de criar um grupo, o parametro of indica do que está criando um grupo no caso uma tupla de String e UIImage, dentro da closure é criado um for usando o método async de grupo que dentro dele executa a função assíncrona de conseguir uma thumb. Em seguida no for try await, novo elemento do swift, é atraido a váriavel thumbnail todo os elementos de forma thread safe e que evitam condições de corrida por final retornando as thumbnais.

### async e asyncDetached

