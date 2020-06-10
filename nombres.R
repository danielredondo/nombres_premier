library(dplyr)

teclado_abajo <- c("z", "x", "c", "v", "b", "n", "m")
teclado_medio <- c("a", "s", "d", "f", "g", "h", "j", "k", "l") # Sin la ñ
teclado_arriba <- c("q", "w", "e", "r", "t", "y", "u", "i", "o", "p")

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
  mutate(teclado_abajo = FALSE,
         teclado_medio = FALSE,
         teclado_arriba = FALSE) %>% 
  arrange(-longitud)

# Nombre más largo
head(data)

for(i in 1:nrow(data)){
  for(j in 1:length(teclado_abajo)){
    if(grepl(teclado_abajo[j], data$long_name[i], ignore.case = TRUE) == TRUE) data$teclado_abajo[i] <- TRUE 
  }
  for(j in 1:length(teclado_medio)){
    if(grepl(teclado_medio[j], data$long_name[i], ignore.case = TRUE) == TRUE) data$teclado_medio[i] <- TRUE 
  }
  for(j in 1:length(teclado_arriba)){
    if(grepl(teclado_arriba[j], data$long_name[i], ignore.case = TRUE) == TRUE) data$teclado_arriba[i] <- TRUE 
  }
}

data %>% filter(teclado_abajo  == FALSE) %>% head()
data %>% filter(teclado_medio  == FALSE) %>% head()
data %>% filter(teclado_arriba == FALSE) %>% head()

