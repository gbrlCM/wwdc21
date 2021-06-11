# Meet DocC documentation in Xcode
DocC é um compilador de documentação integrado ao Xcode, ele permite escrever e visualizar documentação de pacotes e frameworks diretamente dentro do Xcode ou até mesmo exporta-las para a Web.
É possível escrever 3 tipos de paginas usando o DocC, sendo elas:
1. Reference
2. Articles
3. Tutorials
Apenas com o comando “Build Documentation” no Xcode o DocC já é capaz de criar uma versão da documentação do seu pacote.
Para fazer com que o docC gere documentação é necessário escrever tipos especiais de comentários em cima de cada bloco de código, iniciado por “///“ ao invés de “//“ o DocC irá ver esses comentários e os usará pra criar uma documentação.

**DocC tem suporte completo a Markdown**

No exemplo abaixo é possível ver a melhor forma de documentar um método onde dentro da lista de “Parameters” são colocados todos os Parâmetros e em “Returns” uma explicação do objeto retornado.
```swift
/// A model representing a sloth.
public struct Sloth {
    /// Sleep in the specified habitat for a number of hours.
    ///
    /// - Parameters:
    ///     - habitat: The location for the sloth to sleep.
    ///     - numberOfHours: The number of hours for the sloth to sleep.
    /// - Returns: The sloth’s energy level after sleeping.
    mutating public func sleep(in habitat: Habitat, for numberOfHours: Int = 12) -> Int {
        energyLevel += habitat.comfortLevel * numberOfHours
        return energyLevel
    }
}
```

Também é possível usar um atalho no Xcode chamado de “Add Documentation” para que o Xcode gere toda parte repetitiva da Documentação e você o desenvolvedor apenas coloque as descrições, além de ser possível colocar exemplos de código dentro da documentação como no exemplo abaixo: 
```swift
/// A model representing a sloth.
public struct Sloth {
    /// Eat the provided specialty sloth food.
    ///
    /// Sloths love to eat while they move very slowly through their rainforest habitats. They
    /// are especially happy to consume leaves and twigs, which they digest over long periods
    /// of time, mostly while they sleep.
    ///
    /// ```swift
    /// let flower = Sloth.Food(name: "Flower Bud", energy: 10)
    /// superSloth.eat(flower)
    /// ```
    ///
    /// - Parameters:
    ///   - food: The food for the sloth to eat.
    ///   - quantity: The quantity of the food for the sloth to eat.
    /// - Returns: The sloth's energy level after eating.
    mutating public func eat(_ food: Food, quantity: Int = 1) -> Int {
        energyLevel += food.energy * quantity
        return energyLevel
    }
}
```

Agora é possível fazer links para outros elementos do seu pacote isso é feito através da nova sintaxe ``  que pode ser demonstrada no exemplo abaixo em que ele linka a documentação da _struct_ Sloth a _struct_ EnergyLevel:

```swift
/// A model representing a sloth.
public struct Sloth {
    /// The energy level of the sloth.
    public var energyLevel: EnergyLevel

    /// Sleep in the specified habitat for a number of hours.
    ///
    /// Each time the sloth sleeps, their ``energyLevel`` increases every hour by the
    /// habitat's ``Habitat/comfortLevel``.  
    ///
    /// - Parameters:
    ///     - habitat: The location for the sloth to sleep.
    ///     - numberOfHours: The number of hours for the sloth to sleep.
    /// - Returns: The sloth’s energy level after sleeping.
    mutating public func sleep(in habitat: Habitat, for numberOfHours: Int = 12) -> Int {
        energyLevel += habitat.comfortLevel * numberOfHours
        return energyLevel
    }
}
```

