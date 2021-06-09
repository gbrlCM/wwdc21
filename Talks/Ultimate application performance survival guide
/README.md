# Ultimate application perfomance survival guide

Performance ajuda a tornar a experencia de usar aplicativos mais satisfatória e pode ser a diferença entre um app de sucesso e uma falha total.

Atualmente existem as seguinte métricas para analizar a perfomance de um app:
1. Uso de batteria
2. Tempo de inicialização
3. Tempo de espera
4. Uso de memoria
5. Escritas em disco
6. Scrolling
7. Crashs
8. MXSignposts

## Uso de bateria
O menor uso de bateria é uma caracteristica importantissima para o uso de um app, as três coisas mais importantes para se ter em mente quando for fazer uma otimização de uso de bateria são:
1. Localização
2. Uso de dados
3. CPU
É possivel dentro do debug do Xcode na aba de debug verificar o como app se comporta em relação a bateria.

## Tempo de espera e Scrolling
São duas métricas importantes para experiencia do usuário e devem ser priorizadas. Dentro do Xcode organizer é possivél ver métricas do seu app dentro das janelas de scrolling e hang rates. Além disso escrever testes com o XCTest funções que testam a velocidade de scrolling. 

## Disk writes
Leitura de discos em excesso pode gerar problemas de perfomances e reduzir a vida útil de um aparelho, para assegurar o uso de disco da melhor forma é possivel usar as APIs de Batch update do CoreData além de escrever alguns testes de perfomance usando o XCTest.

## Tempo de inicialização e Crashs
É necessário fazer o minimo possivel de processamento durante a inicialização do seu app, para que ela não demore muito, toda vez que um app crasha ou é terminado pelo sistema todo esse processo é reinicializado, sendo assim é interessante reiterar que é necessario que a inicialização seja o menos custosa possível. 
é possivel comparar o tempo de inicialização de versões do seu app dentro do Xcode, além de existirem metricas que podem ser verificadaas dentro do XCTest.

## Memória
O uso minimo de memória é bom para seu app pois impede que o sistema termine o processo do seu aplicativo em background, o que significa que sempre que o usuario for acessa-lo ele está no mesmo lugar onde ele parou.
Assim como as métricas anteriores, é possivel aferir os resultados através do Xcode, Instruments, MetricKit e etc.
