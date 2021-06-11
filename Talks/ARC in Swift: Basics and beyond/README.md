# ARC in Swift: Basics and beyond

Sempre que possível use value types, pois eles garantem que não existirá bug de compartilhamento, para a contagem de referencia de Reference types existe o ARC (Automatic Reference Counting).

## Ciclo de vida de um objeto
A vida de um objeto se inicia na chamada do _init()_ e acaba no seu ultimo uso, ao final do seu ultimo uso o ARC remove o objeto da memória. O tempo de vida do objeto é determinado pela quantidade de referencias ao objeto que existem no momento, ao chegar a 0 o objeto é removido.

O ciclo de vida é baseado no uso no Swift, ou seja quando uma referência não for mais usado ela é desalocada imediatamente um exemplo disso pode ser visto no código abaixo: 

```swift
class Traveler {
    var name: String
    var destination: String?
}

func test() {
      //Ao declara traveler1 a contagem de referências no objeto é aumentada para 1
    let traveler1 = Traveler(name: "Lily")
      //Ao declara traveler2 a contagem de referências no objeto é aumentada para 2
    let traveler2 = traveler1
    // A partir daqui travaler1 não é mais usado fazendo com que o sistema remova a sua referência, assim diminuindo a contagem de referência para 1.
    traveler2.destination = "Big Sur"
    //A partir daqui travaler2 não é mais usado fazendo com que o sistema remova a sua referência, assim diminuindo a contagem de referência para 0. O objeto criado é desalocado.
    print("Done traveling")
}
```

## Observable object lifetime
São conhecidas como referências _weak_ e _unowned_ e las não participam da contagem de referências feitas pelo ARC. Elas são usadas para evitar ciclo de referência.

```swift
class Traveler {
    var name: String
    var account: Account?
    func printSummary() {
        if let account = account {
            print("\(name) has \(account.points) points")
        }
    }
}

class Account {
    var traveler: Traveler
    var points: Int
}

//Esse código ira causar um ciclo de referência, isso ocorre pois ambos objetos se apontam de forma que não é possível os desalocar.
func test() {
      // Objeto Travaler - qtd de referências: 1
    let traveler = Traveler(name: "Lily")
      // Objeto Travaler - qtd de referências: 2
    // Objeto Account - qtd de referências: 1
    let account = Account(traveler: traveler, points: 1000)
    // Objeto Travaler - qtd de referências: 2
    // Objeto Account - qtd de referências: 2
    traveler.account = account
    // Objeto Travaler - qtd de referências: 2
    // Objeto Account - qtd de referências: 1
    traveler.printSummary()
    // Objeto Travaler - qtd de referências: 1
    // Objeto Account - qtd de referências: 1
    // Não é possível desalocar pois ambos objetos guardam referencias um do outro.
}
```

O uso de referências _weaks_ e _unowned_ são usados para quebrar esse tipo de ciclo porém o seu uso pode ser perigoso já que referências fracas não impedem do ARC desalocar um objeto, isso faz com que uma mudança no compilador do Swift quebre o seu código já que não existe nenhum impeditivo para que o ARC desaloque o objeto da memória. Por isso é preferível que se evite criar referências cíclicas, e que isso seja feito apenas caso seja estritamente necessário.

## Side effects de deinicialização
O uso do _denit_ deve ser feito apenas em casos estritamente necessário pois o comportamento dele pode mudar de acordo com atualizações no compilador do Swift, já que o _denit_ é chamado logo após o ARC contabilizar a quantidade de referências como 0, e isso faz com que as chamadas feitas nesse momento sejam feitas em momentos diferentes, causando bugs silenciosos ou até mesmo crashs.

