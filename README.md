# Economia da saúde

Tópicos em economia da saúde: distribuição espacial dos equipamentos de mamografia no estado do Paraná e casos de óbito de mulheres por neoplasia malígna mamal

## Base de dados

- Período: 2010
- Localidade: Municípios do Estado do Paraná

Abaixo uma breve descrição da base de dados utilizada:

### [Tabelas](https://github.com/rdurl0/economia_da_saude/tree/master/Tabelas)
- **Equipamentos de mamografia**
  - _Número de mamógrafos existentes, em uso e disponíveis pelo SUS_ - Período: maio/2010 - Fonte: [TABNET/CNES](http://www2.datasus.gov.br/DATASUS/index.php?area=0204&id=11671&VObj=http://tabnet.datasus.gov.br/cgi/deftohtm.exe?cnes/cnv/equipo)
- **Morte por câncer de mama**
  - _Óbitos p/ Residência, Município e Faixa Etária Grupo CID-10: Neoplasias malignas da mama_ - Cor/raça: Branca, Preta, Amarela, Parda, Indígena, Ignorado - Período: 2010 - Fonte: [MS/SVS/CGIAE - Sistema de Informações sobre Mortalidade - SIM](http://www2.datasus.gov.br/DATASUS/index.php?area=0205&id=6937)
- **Outras variáveis**
  - Estatísticas coletadas no _site_ do [Atlas do Desenvolvimento Humano no Brasil](https://goo.gl/CWjMkb)
  - População rural/urbana
  - População residente por sexo e faixa etária
  - Índice de _Gini_
  - Esperança de vida ao nascer
  - Probabilidade de sobrevivência até 60 anos de idade
  - Taxa de envelhecimento (2010)
  - Taxa de Analfabetismo
  - Renda _per capita_ (dos pobres e mais pobres)
  - IDHM (renda/longevidade/educação)      
      
      
### [_Shapefiles_](https://github.com/rdurl0/economia_da_saude/tree/master/shp)
- **Malha de municípios do Estado do Paraná** - Período: 2015 - Fonte: [IBGE - Malha Municipal 2015](https://goo.gl/Dprczu)

## _Workflow_
O esquema de trabalho é feito com base no ciclo de Wickham (2016):

![](https://github.com/rdurl0/economia_da_saude/blob/master/r4ds.png)

### _Import/tidy_
- [Neste link](https://github.com/rdurl0/economia_da_saude/blob/master/1_Malha_de_municipios_no_estado_do_Paran%C3%A1.md) é carregada a malha de municípios do estado do Paraná. O arquivo _shapefile_ é baixado e deixado em condições para unir com outras bases de dados;
- [Neste link](https://github.com/rdurl0/economia_da_saude/blob/master/2_Bases_de_dados.md) são baixadas as bases de dados, "limpamos" e unimos as bases ao _shapefile_ para deixar tudo em condições de análise;
### _Transform/Model/Visualize_
- Análise exploratória de dados:
    - [Neste link](https://github.com/rdurl0/economia_da_saude/blob/master/3_Analise_exploratoria.md): edição básica de gráficos e tabelas para exibição em relatório laTeX de estatísticas descritivas
    - [Neste link](https://github.com/rdurl0/economia_da_saude/blob/master/4_Autocorrelacao_espacial.md): verificamos autocorrelação espacial das variáveis
    
### _Communicate_
- [Neste link]() o artigo é apresentado. A versão final do artigo é disponibilizada neste [pdf]().

## Referencias Bibliográficas
WICKHAM, Hadley; GROLEMUND, Garrett. R for data science: import, tidy, transform, visualize, and model data. " O'Reilly Media, Inc.", 2016.
