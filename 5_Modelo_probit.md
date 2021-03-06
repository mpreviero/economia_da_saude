Modelo Probit
================

-   [Ajustando o modelo](#ajustando-o-modelo)
-   [Forma final](#forma-final)

Ajustando o modelo
------------------

``` r
rm(list=ls())

library(readr)
library(tidyverse)
library(scales)
library(sf)
library(broom)

taxa_obitos <- read_rds("./Tabelas/base_parana.rds") %>% 
#  st_set_geometry(NULL) %>%
  mutate(tem_mamogr = ifelse(mamografos_existentes>0, 1, 0)) %>%
  select(obitos_total_idade_taxa, tem_mamogr) %>%
  filter(obitos_total_idade_taxa>0)
 # mutate(obitos = log(obitos_total_idade_taxa + 0.01))

taxa_obitos %>%
  ggplot(aes(x=obitos_total_idade_taxa, y=tem_mamogr)) +
  geom_jitter(width = 0, height = .05, alpha = 0.5) +
  geom_smooth(method = "lm", color="blue", size=.5, se=F) +
  geom_smooth(method = "glm", se=FALSE, color="red",
              method.args=structure(list(family = "binomial"),
                                    .Names = "family") )
```

<img src="5_Modelo_probit_files/figure-markdown_github/unnamed-chunk-1-1.png" style="display: block; margin: auto;" />

Forma final
-----------

``` r
# fit model
mod <- glm(tem_mamogr ~ obitos_total_idade_taxa, data = taxa_obitos, family = binomial)
taxa_obitos_plus <- augment(mod, type.predict="response") # augmented model


# define binns
lab <- c("0.057-0.132", "0.133-0.181", "0.182-0.243", "0.244-0.370", "0.370-0.505", "0.506-1.220")

brk <- quantile(taxa_obitos$obitos_total_idade_taxa, probs=seq(0, 1, 1/6))

classe <- cut(taxa_obitos$obitos_total_idade_taxa,
    breaks=brk,
    labels=lab,
    right = T,
    include.lowest=T)

# binned table
taxa_obitos_binned <- taxa_obitos %>%
  mutate(classe = classe) %>%
  group_by(classe) %>%
  summarise(mean_obitos = mean(obitos_total_idade_taxa),
            mamogr_rate = mean(tem_mamogr))

# data space
data_space <- ggplot(taxa_obitos_binned, aes(x=mean_obitos, y=mamogr_rate)) + 
  geom_point() + 
  geom_line()
  
# logistic model on probality scale
data_space +
  geom_line(data = taxa_obitos_plus, aes(x=obitos_total_idade_taxa,y=.fitted), color = "red") +

  labs(title="Modelo logístico em escala de probabilidade",
       x="Taxa média de óbito por câncer de mama nos municípios\n(agrupados por sextil)",
       y="Probabilidade esperada de\nter ou não equipamento de mamografia no município",
       caption="Foram excluídos municípios com taxa de óbito igual a zero, provavelmente são subnotificados") +
  
  theme(axis.title.x = element_text(size=12, face = "bold"),
        axis.title.y = element_text(size=12, face = "bold"),
        plot.caption = element_text(size=8),
        plot.title= element_text(size=16, hjust=.5, color="black"),
        axis.text = element_text(size=12))
```

<img src="5_Modelo_probit_files/figure-markdown_github/unnamed-chunk-2-1.png" style="display: block; margin: auto;" />
