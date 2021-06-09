# Protect mutable state with Swift actors

Condição de corrida ocorre quando duas threads tentam fazer acessar o mesmo estado mutavel de algum objeto, essa é uma das maiores dificuldades de programação paralela.

Value types ajuda porém não elimina condições de corrida e em casos é necessario ter um estado mutavél e é por isso que o Actor chegou no Swift.

## Actors
Eles disponibilizam um modo de sincronização para estado mutável compartilhado, todo acesso ao estado passa pelo actor que garante que que não havéra acesso concorrente.

### Actor podem:
1. conformar com protócolos e ser extendidos
2. são um tipo de refenrencia
3. sincronização e isolamento de dado são os diferencias de um actor.

todas as chamadas para um actor são assíncronas ou seja, quando é feita uma chamada é verificado se actor está disponivel, caso esteja a chamada é executada, caso não ela só será executada quando o actor estiver disponivel.

Actors funcionam de forma sincrona dentro dele e não necessário chamar as funções e propriedades de forma assincrona.

é póssivel marcar funções com o _nonisolated_ o que retira o isolamento dos actors e permite chamadas sincronas, mas essas funções só podém ter acesso a estados imutáveis.

## Sendable
Sendable são tipos que seguros de compartilhar de forma paralela, alguns tipos já tem o protócolo sendable implementado são eles:

1. Value type
2. Actor type
3. Classes com APENAS propriedades imutavéis
4. Classes com sincronização interna
5. Funções com o _@Sendable_ 

Para implementar o tipo Sendable é necessário que todos os atributos tambem sejam sendables.

### @Sendable closures
1. Não é possivel fazer capturas mutaveis.
2. Qualquer captura precisa conformar com Sendable.
3. Não pode ser sincrono e actor-isolated ao mesmo tempo.
