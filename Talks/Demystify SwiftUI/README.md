# Demstify SwiftUI

SwiftUI é um framework declarativo, e isso tem seu lado positivo e negativo, existem momentos que esse comportamento declarativo pode gerar resultados inesperados logo entender como ele funciona vai ajudar a resolve-los.

## O que o SwiftUI olha ao ler o seu código:

### 1. Identidade

É como o SwiftUI reconhece elementos como o mesmo ou diferentes ao redor do seu aplicativo.

Cada View instanciada tem uma forma de ser identificada, Ou seja Views que tem comportamento dinâmico são ainda a mesma View porém redesenhada, a identidade da view que identifica se um elemento é o mesmo ou se é um elemento distinto.

**Tipos de Identidade:** 

1. Identidade explicita - é o tipo de identidade que usa identificadores customizados
2. Identidade estrutural - é a identidade que é inferida a partir do tipo e posição na hierarquia de Views.

**Identidade explicita:**

É uma forma de dar identidade a uma View através de um "nome" ou "identificador" um exemplo de identidade explicita é como o UIKit gerencia UIViews, já que todas elas são classes cada uma é tipo de referência, ou seja cada uma é passada através de um ponteiro que por si é um tipo de identidade explicita. 

No SwiftUI é possível dar identificadores para Views a partir do modificador *.id(_)* esse modificador recebe qualquer elemento que conforma ao protocolo *Hashable* e com isso é possível encontrar views a partir de identificadores explícitos.

**Identidade estrutural**: 

**Toda view em SwiftUI tem uma identidade** mesmo que não seja explicita e isso é feito através da identidade estrutural que cria uma identidade a partir do tipo e posicionamento da View na hierarquia. Isso é feito através do *@ViewBuilder* que é um tipo de *ResultBuilder* e isso é feito através do tipos da View dentro do Hierarquia feita quando uma View construída e o seu tipo genérico é substituído pelo tipo real que é composto por todas as Views que a compõem na mesma estrutura.

**AnyView e ViewBuilder**: 

É comum criar funções ou propriedades computáveis dentro de uma View para remover toda a lógica de criação de uma View da propriedade *body* e para que isso funcione é comum encapsular todas as Views dentro dessas funções dentro de AnyView já que tipos opacos como o *some View* precisam que se retorna um tipo único de View, porém isso gera problemas de identidade para o SwiftUI já que a identidade estrutural das Views é composta pelos tipos e sua hierarquia, sendo assim é **altamente desaconselhado usar AnyView**.

### 2. Lifetime

É como o SwiftUI gerencia a existência de *Views* e de dados através do tempo

**Lifetime de uma view**

1. Quando uma View é criada, ao aparecer é lhe dado uma identidade seja explicita ou estrutural.
2. Quando um valor é mudado a View é resenhada para representar a mudança.
3. Quando a View desaparece sua identidade desaparece.

**@State e @StateObject**

Quando o SwiftUI vê @State ou @StateObject dentro de uma View ele sabe que tem que persistir aquele valor enquanto a View estiver a mostra, quando um State é modificado a View é redesenhada para representar a mudança. A persistência do seu estado é igual a persistência da sua View.

### 3. Dependencias

É como o SwiftUI percebe que sua interface precisa ser atualizada e o porque

Através do mapeamento de dependências é possível fazer com que apenas as Views que dependam de algum estado sejam atualizadas e não toda a arvore de View, e isso é feito através da identidade das Views que permitem o SwiftUI saber quem precisa ser atualizado e quem não precisa, já que cada estado está diretamente conectado a identidade da View.

