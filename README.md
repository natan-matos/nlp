# Yelp Review Sentiment Analysis: Nourishing Restaurant Insights


## 1. Context

Uma Seguradora de veículos criou um novo produto, um Seguro de Saúde e deseja oferecer para sua base já existente de clientes. Uma pequena amostra da base foi usada para fazer a primeira oferta e coletar dados de interesse dos clientes nesta campanha de Cross-sell.

Como a base de clientes é muito grande e a empresa possui multiplos canais de comunicação, encontrar a forma mais efetiva de contactar os clientes pode se traduzir em uma enorme enconomia nas campanhas de comunicação.

Construir um modelo para prever se um cliente estaria interessado em Seguro de Saúde é extremamente útil para a empresa, pois ela pode planejar sua estratégia de comunicação para alcançar esses clientes e otimizar seu modelo de negócios e receita.

> Após conversar com o time de marketing, foi decidido que uma lista de clientes, ordenada pela sua propensão de compra, seria a melhor solução. Pois assim pode ser dada prioridade aos clientes com maior chance de compra.

| Problema | Causa Raiz | Questão principal |
| --- | --- | --- |
| Quais clientes estão mais propensos a comprar? | Aumentar a receita da empresa | Como ordenar os clientes por propensão de compra |

## 2. Suposições de Negócio

- Considerei os valores apresentados como sendo em dolar americano.
- Por não ter dados suficientes, considerei que não há clientes na base com mais de 1 ano na empresa
- O tipo de canal de vendas é desconhecido, tendo disponível um número em sua representação.
- Outras informações importantes para a avaliação de um seguro não estão disponíveis no dataset original, assim que algumas análises podem ser limitadas. 


## 3. Desenvolvimento da Solução

### 3.1. Produto Final
- Um reporte em csv com os clientes ordenados pela propensão de compra.

### 3.2. Ferramentas
- Python, Jupyter Notebook, VS Code
- Scikit-lear
- Git, Github

### 3.3. Processo
O processo de solução do projeto é baseado na metodologia CRISP-DM, que é a sigla apra Cross Industry Process - Data Mining. É uma metodologia ágil que fornece uma estrutura robusta para planejamento de projetos de Machine Learning. Funciona como um processo cíclico, focado em entrega incremental a cada novo ciclo.


<img src="src/visualization/crisp-dm.png" style="zoom:100%;" />

* **Passo 01:** Descrição dos Dados: limpeza e descrição estatistica dos dados, afim de encontrar erros e comportamentos incomuns.
* **Passo 02:** Feature engineering: derivação de novas features, para modelar melhor o fenômeno.
* **Passo 03:** Filtragem de variáveis: remover linhas e colunas não necessárias para o modelo.
* **Passo 04:** Análise Exploratória de Dados: validação de hipóteses, busca por insights e entender melhor o impacto das variáveis no fenômeno.
* **Passo 05:** Preparação dos Dados: adequação dos dados para que o modelo de Machine Learning possa aprender corretamente.
* **Passo 06:** Seleção de Variáveis: selecionar as features mais significantes para treinar o modelo.
* **Passo 07:** Modelagem do Modelo: testar diferentes algoritmos de Machine Learning e comparar os resultados, afim de escolher um que perfome melhor para o conjunto de dados.
* **Passo 08:** Fine Tunnig: escolher os melhores valores para os hiperparâmetros do modelo selecionado anteriormente.
* **Passo 09:** Avaliação e Interpretação do Erro: converter o a performance do modelo de Machine Learnig em resultados de negócio.
* **Passo 10:** Deploy do model em produçãp: publicar o modelo em um ambiente de nuvem para que os envolvidos no projeto consigam acessar os resultados e melhorar suas decições de negócio.
    
# 4. Coleta de Dados

- **Dataset foi coletado no Kaggle: [clique aqui](https://www.kaggle.com/datasets/anmolkumar/health-insurance-cross-sell-prediction)**
    
	O Dataset contém dados de 342 mil clientes, contendo informação básicas e a resposta à oferta de cross-sell.
    
- **O dataset contêm 12 atributos**
    
## 5. Top 3 Insights

### 5.1. Insights

Algumas hipóteses de negócio foram levantadas, para serem validadas ou não. No total foram levantadas 12 hipóteses, e dentro delas aqui estão os 3 top insights retirados da análise de dados e validação das hipoteses.

| **Insight 01 - Proprietário de veículos mais novos contratam mais seguro** |
| --- |
| <img src="src/visualization/vehicle_age.png" style="zoom:60%;" /> |

| **Insight 02 - Pessoas mais velhas deveriam contratar mais que jovens** |
| --- |
| <img src="src/visualization/age.png" style="zoom:60%;" /> | 

| **Insight 03 - Mulheres pagam mais caro pelos seguros** | 
| --- |
| <img src="src/visualization/gender_response.png" style="zoom:60%;" /> | 
| <img src="src/visualization/gender_premmium.png" style="zoom:60%;" /> | 


# 6. Modelo de Machine Learnig Aplicado

Depois de modelar os dados usando as técnicas de encoding e rescaling e standardizarion, optei por usar o Feature Importance para selecionar as variáveis mais relevantes para o modelo. Aqui está a seleção delas:

['vintage', 'annual_premium', 'age', 'policy_sales_channel', 'vehicle_damage', 'previously_insured']

No total, foram testados e comparados 6 modelos:
* Naive Bayes
* KNN
* Random Forest
* Gradient Boosting
* Logistc Regression
* Neural Network

A métrica escolhida para medir a performance dos modelos foi o 'Recall at K'. Essa é uma variação do Recall tradicional, em que é medida a performance do modelo até a k-ésima linha do dataset. Para fim de exemplificar, k foi definido em 20000. 

<img src="src/visualization/metrics.png" style="zoom:100%;" />

Outra forma de conseguir ver melhor a performance dos modelos é a curva de ganho acumulado. Este gráfico mostra na linha laranja o total acumulado de classificações positivas (interessados no seguro) e a porcentagem da base. Observe que com 40% da base conseguimos atingir quase 100% dos interesados no produto. A linha pontilhada no gráfico mostra o modelo aleatório de escolha.

<img src="src/visualization/cumulative_gain_1.png" style="zoom:100%;" />


Os modelos Gradient Boosting, Rede Neural e KNN tiveram um performance bastante similar, tanto na curva acumulada como no recall at k. Por questões de desempenho computacional o modelo escolhido foi o Gradient Boosting.


# 7. Performance do Modelo & Fine Tunnig

Para encontrar os melhores parametros para treinar o modelo, eu escolhi usar a técnica de Random Search. Essa técnica se baseia em definir um espaço de valores para cada parametro do modelo e testar de maneira aleatória cada combinação possível até encontrar a que aprensente a melhor performance.

Ao fim do processo, estes foram os melhores parametros encontrados pela busca.

> {'n_estimators': 500, 
> 'min_samples_split': 2,
> 'min_samples_leaf': 4,
> 'max_depth': 7,
> 'loss': 'exponential',
> 'learning_rate': 0.1,
> 'criterion': 'friedman_mse'}
 


# 8. Deployment

Neste ponto o modelo já está pronto para ser treinado com os parametros escolhidos e as melhores features selecionadas. Ao fim do processo o modelo já está pronto para realizar predições com novos dados. 

Testando o modelo final com novos dados desconhecidos, ele apresentou boas métricas de avaliação.

<img src="src/visualization/cumulative_gain_final.png" align="center" style="zoom:100%;" />

<img src="src/visualization/final_metrics.png" align="center" style="zoom:100%;" />

No gráfico abaixo mostra a Lift Curve do modelo, que mostra quantas vezes o Modelo treinado é melhor que o método aletório.

<img src="src/visualization/lift_curve_final.png" align="center" style="zoom:100%;" />

# 9. Resultados de Negócio

Uma parte importante de qualquer projeto de Data Science é traduzir a perfomance em resultados reais de negócio. Para este projeto, Recall At K foi a métrica escolhida para avaliar o modelo. O objetivo desta métrica é saber em qual porcentagem da base de clientes conseguimos alcançar a maior parte ou a totalidade dos clientes interessados no novo produto.

Algumas pesquisas mostraram que o custo médio para entrar em contato com cada cliente gira em torno a $3.5, podendo ser muito maior, dependendo do canal escolhido para contato. Usando este número como referência, o gráfico abaixo mostra o custo para atingir 90% dos clientes interessados no Seguro de Saúde. A barra azul mostra o custo usando o modelo tradicional aleatório e a barra vermelha mostra o custo usando a ordenação feita pelo algoritmo de Machine Learnig.

<img src="src/visualization/values.png" align="center" style="zoom:100%;" />

Usando a lista de clientes ordenada pelo algoritmo, a economia para a empresa é de $675,318,70 em despesas de comunicação com os clientes. Isso é uma redução de 63.5% nos custos de marketing.

# 10. Conclusão

Este projeto apresentou um tipo diferente de problema de Classificação, conhecido como Learning to Rank. O objetivo principal é ordenar os clientes pela propensão de compra, em uma lista da maior probabilidade para a menor. Esse tipo de algoritmo geralmente é usado em mecanismos de recomendação e motores de busca, como Google e Bing.

O modelo resultou em uma enorme economia para a empresa nos gastos com comunicação com os cliente. Também seria possível criar um projeto para prever a receita resultante das vendas do novo seguro para a base ordenada, mas não é o foco aqui.

Sendo, na média, 2.5 vezes melhor que o modelo tradicional aleatório, o algoritmo é uma excelente ferramenta para otimizar os processos dentro da empresa.

# 11. Próximos passos

- Derivar novas features no processo de feature engineering.
- Experimentar o método de busca bayesiana na etapa de fine tunnig.
