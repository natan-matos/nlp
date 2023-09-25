# Yelp Review Sentiment Analysis: Nourishing Restaurant Insights

## Project Overview
This project revolves around conducting sentiment analysis on restaurant reviews obtained from Yelp, employing advanced natural language processing (NLP) and machine learning techniques. By categorizing reviews as positive, negative, or neutral, we aim to unlock valuable insights that can be used to enhance dining experiences and empower potential diners with data-driven choices.

## Web Scraping for Data
Data Collection
We've sourced our restaurant reviews directly from Yelp's extensive online platform. To accomplish this, we employed a web scraping approach using Python libraries such as requests and BeautifulSoup. This allowed us to extract restaurant reviews efficiently.

### The Web Scraping Process
**Requesting Data:** We initiated HTTP requests to Yelp's restaurant review pages using the requests library in Python.

**Parsing HTML:** Upon receiving responses, we parsed the HTML content using BeautifulSoup, enabling us to navigate and extract data from the page's structure.

**Locating Relevant Elements:** With CSS selectors and class names, we pinpointed specific HTML elements that contained the restaurant reviews we were interested in.

**Extracting Data:** We extracted review texts, usernames, ratings, and additional information, such as the date of the review, to build our dataset.

## Using the Scraped Data
Once the data was collected through web scraping, we were able to proceed with the sentiment analysis process. Sentiment analysis offers insights into customer feedback, helping restaurant owners make informed decisions to enhance their establishments. Moreover, potential diners can access aggregated sentiment scores to make dining choices that align with their preferences.


## Machine Learning Modeling

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



# 10. Conclusão

Este projeto apresentou um tipo diferente de problema de Classificação, conhecido como Learning to Rank. O objetivo principal é ordenar os clientes pela propensão de compra, em uma lista da maior probabilidade para a menor. Esse tipo de algoritmo geralmente é usado em mecanismos de recomendação e motores de busca, como Google e Bing.

O modelo resultou em uma enorme economia para a empresa nos gastos com comunicação com os cliente. Também seria possível criar um projeto para prever a receita resultante das vendas do novo seguro para a base ordenada, mas não é o foco aqui.

Sendo, na média, 2.5 vezes melhor que o modelo tradicional aleatório, o algoritmo é uma excelente ferramenta para otimizar os processos dentro da empresa.

# 11. Próximos passos

- Derivar novas features no processo de feature engineering.
- Experimentar o método de busca bayesiana na etapa de fine tunnig.
