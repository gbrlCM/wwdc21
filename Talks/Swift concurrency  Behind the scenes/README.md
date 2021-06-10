# Swift concurrency: Behind the scenes

## Threading model

Quando se usa o GCD é possível que se crie uma quantidade excessiva de threads, isso é conhecido como Thread explosion isso acontece porque o GCD cria uma nova thread toda vez que a thread que está sendo usava é bloqueada, e em alguns casos isso pode gerar um paralelismo excessivo, isso pode gerar deadlocks, uso excessivo de memória e de scheaduling de threads.

No caso do novo modelo de Paralelismo do Swift, ao invés de criar novas threads são criados objetos chamados *continuations* que são chamados na threads de cada núcleo de processo com o uso de uma função que é muito menos custoso do que a troca de contextos de threads. Para que esse comportamento seja atingindo é necessário que seja implementado tanto na linguagem quanto no sistema um contrato de funcionamento e isso é feito a partir das seguintes features de linguaguem:

1. await e o fato que isso é uma operação que não bloqueia a thread
2. e o rastreamento das dependências de *tasks*

### Como funções *async* funcionam

No caso de funções síncronas convencionais elas são empilhadas na thread e sempre que terminam elas saem da pilha liberando a thread para outras funções já no caso de funções *async* elas são executadas normalmente até que seja chamado um await, quando isso ocorre a função é guardada em uma estrutura de dados pelo sistema e é desalocada da thread para a chamada com o await ser executada, que por sua vez pode ser guardada na estrutura de dados e chamada de novo quando todas as suas dependências marcadas com *await* forem executadas, quando uma thread estiver disponível ela busca a *continuation* dessa estrutura e retoma a execução da função e isso é feito até que todas as funções *async* sejam executadas.

### Thread pool cooperativa

O novo executor de Swift agora limita o número de threads para o número de núcleos de CPU, e o paralelismo é controlado pelo sistema através das continuations descritas acima, que são operações que não bloqueiam a thread assim impedindo uma quantidade de threads excessivas e de troca de contextos.

## Synchronization

Actors são usados para proteger estado mutável quando usado de forma paralela, isso é feito a seguir dos seguintes princípios:

1. Exclusão mútua: Um actor só pode executar uma chamada de método por vez, isso significa que uma chamada de função de um actor deve ser feita assíncrona para que possa haver um scheaduling de chamadas, assim eliminando as condições de corrida.
2. Reentrada e prioritização: O sistema escolhe quem irá ocupar as threads a partir de prioridade ao invés do modelo do GCD que é *first in first out* isso permite que priorizar chamadas mais importantes como por exemplo chamadas que são ocasionadas pelo usuário serem priorizadas a chamadas de background, fazendo com que o app tenha uma aparência de que está funcionando mais rápido, porém ele está apenas executando o que é mais importante primeiro.
3. Main actor: é um tipo especial de actor que executa na thread principal o que é perfeito para atualização de UI por exemplo, porém é necessário ter em mente a troca de contextos entre actors passe para a thread principal apenas quando tiver todo o trabalho assíncrono concluído, isso permite um funcionamento mais rápido devido a menor troca de contexto.

