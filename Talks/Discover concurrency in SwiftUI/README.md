# Discover concurrency in SwiftUI


O ciclo de vida do SwiftUI roda no _MainActor_, quando um _ObservableObject_ muda alguma de suas variáveis _@Published_ um evento chamado _objectWillChange_ é acionado de forma que é feita uma diferença entre o objeto anterior e o objeto novo e caso haja alguma diferença o SwiftUI renderiza a tela novamente capturando as diferenças.

Como as mudanças tem que ser feitas no MainActor antes do novo modelo de paralelismo era necessário mover as ações entre thread, agora com o o uso de await isso não é mais necessário já que é muito mais simples se certificar que as mudanças irão ocorrer na thread principal.

Com o uso do _@MainActor_ só é possível acessar as propriedades de objeto a partir do _MainActor_

Agora é possível chamar fotos a partir de uma URL de forma mais simples com o uso da nova View AsyncImage.

A partir do modificador _refreshable_ é possível chamar uma função assíncrona para atualizar os itens de uma lista por exemplo.
