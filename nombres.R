library(dplyr)

teclado_abajo <- c("z", "x", "c", "v", "b", "n", "m")
equipos_premier <- c("Liverpool", "Manchester City", "Manchester United",
                     "Leicester City", "Chelsea", "Wolverhampton Wanderers", "Sheffield United",
                     "Tottenham Hotspur", "Arsenal", "Burnley", "Crystal Palace",
                     "Everton", "Newcastle United", "Southampton", "Brighton & Hove Albion", 
                     "West Ham United", "Watford", "Bournemouth", "Aston Villa", "Norwich City")

# Lectura de datos
# Fuente: https://www.kaggle.com/stefanoleone992/fifa-20-complete-player-dataset#players_20.csv
data <- read.csv(file = "https://raw.githubusercontent.com/danielredondo/30diasdegraficos/master/datasets/players_20.csv",
                 encoding = "UTF-8") 
table(data$club)
data <- data %>% select(short_name, long_name, club) %>% 
  filter(club %in% equipos_premier) %>% 
  mutate(longitud = nchar(long_name)) %>% 
  mutate(teclado = FALSE) %>% 
  arrange(-longitud)

# Nombre más largo
head(data)

for(i in 1:nrow(data)){
  for(j in 1:length(teclado_abajo)){
    if(grepl(teclado_abajo[j], data$long_name[i], ignore.case = TRUE)) data$teclado <- TRUE 
  }
}

data %>% filter(teclado == FALSE) %>% head()
