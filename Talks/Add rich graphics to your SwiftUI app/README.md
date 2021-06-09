# Add rich graphics to your SwiftUI app

SwiftUI por padrão desenha sua tela dentro da Safe area que para maioria dos casos é o melhor comportamento, além disso A view reage a presença do teclado automaticamente, pois ele tem uma "Keyboard safe area", porém é possivel ignorar a Safe area para casos que fazem sentido, isso possivel adicionando o seguinte modifier:

```swift
...
YourView()
    .ignoreSafeArea()
...
```
E para o caso que se deseja ignorar apenas a Safe Area do teclado basta colocar a seguinte propriedade dentro do modifier:

```swift
...
YourView()
    .ignoreSafeArea(.keyboard)
...
```

Tambem é possivel escolher qual canto da Safe Area deseja não respeitar, e isso é feito da seguinte forma:

```swift
...
YourView()
    .ignoreSafeArea(edges: .bottom)
...
```
É possivel agora escolher materiais para o background de suas views, os materias são os demonstrados pela imagem abaixo:

IMAGEM

Também é possivel colocar um material para o estilo de views como textos com os seguintes modificadores:

IMAGEM

É possivel usar outros elementos agora como elementos de safe Area e isso é feito colocando os elementos que deseja que se comportem como limites dentro da safeArea dentro do módificador _safeAreaInset(edge: )_ assim os demais elementos irão usa-lo como referencia da safe area, nunca ficando acima ou abaixo dele.

Anteriormente para fazer views complexas com muitos elementos e que necessitavam ler a posição da tela era necessário usar um _GeometryReader()_ que é uma view que consegue passar as informações de tamanho, posição e etc. Porém esse método tem alguns problemas para alguns casos mais complexos e para isso foi lançada uma nova view o Canvas.

## Canvas

Quando se declara um canvas dentro do block de construção da view ele recebe um contexto que é o elemento que recebe comandos e o tamanho da view.

```swift
Canvas {context, sie in {
    let image = Image(systemName: "myimage")
    context.draw(image, at: CGPoint(x: 0.5 * size.width, y: 0.5 * size.height)
}
```
Essa é uma imagem que sera desenhada no meio do Canvas, esse método lembra bastante como o SpriteKit lida com desenho.
É possivel criar cópia do context para poder gerar contexts diferentes e modificar ainda mais o desenho.

Para dar acessibilidade a elementos de um canvas é necessario usar os _acessibilityModifiers_ pois ela é vista como um único elemento.

## TimelineView

View que permite controlar o que é mostrado através do tempo, perfeito para animação do tipo screensaver por exemplo. Uma TimelineView é descrita colocando primeiro um scheaduler que vai definir como ela vai atualizar e dentro do bloco é passado um timelineContext que pode ser usado para animar elementos.

```swift
TimelineView(.animation) { timeline in
    ...
}
```
Com a propriedade _timeline_ passada acima é póssivel ter acesso ao tempo e isso pode ser usado para fazer animações.
