library(dplyr)

teclado_abajo <- c("z", "x", "c", "v", "b", "n", "m")
teclado_medio <- c("a", "á", "à", "s", "d", "f", "g", "h", "j", "k", "l") # Sin la ñ
teclado_arriba <- c("q", "w", "e", "é", "è", "r", "t", "y", "ý", "u", "ú", "ù", "ü", "i", "í", "ì", "o", "ó", "ò", "ö", "p")

# Premier League
equipos <- c("Liverpool", "Manchester City", "Manchester United",
                     "Leicester City", "Chelsea", "Wolverhampton Wanderers", "Sheffield United",
                     "Tottenham Hotspur", "Arsenal", "Burnley", "Crystal Palace",
                     "Everton", "Newcastle United", "Southampton", "Brighton & Hove Albion", 
                     "West Ham United", "Watford", "Bournemouth", "Aston Villa", "Norwich City")

# Lectura de datos
# Fuente: https://www.kaggle.com/stefanoleone992/fifa-20-complete-player-dataset#players_20.csv
data <- read.csv(file = "https://raw.githubusercontent.com/danielredondo/30diasdegraficos/master/datasets/players_20.csv",
                 encoding = "UTF-8") 

data <- data %>% select(short_name, long_name, club) %>% 
  filter(club %in% equipos) %>% 
  mutate(longitud = nchar(long_name)) %>% 
  mutate(teclado_abajo = FALSE,
         teclado_medio = FALSE,
         teclado_arriba = FALSE) %>% 
  arrange(-longitud)

# Para ver si están bien escritos todos los clubs
table(data$club) 
length(table(data$club))

# Nombre más largo
head(data)

# Nombre más corto
tail(data)

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

# Nombre más largo sin teclas de la fila de abajo del teclado
data %>% filter(teclado_abajo  == FALSE) %>% head()

# Nombre más largo sin teclas de la fila central del teclado
data %>% filter(teclado_medio  == FALSE) %>% head(10)

# Nombre más largo sin teclas de la fila de arriba del teclado
data %>% filter(teclado_arriba == FALSE) %>% head()





# Y sin filtrar por club:
data <- read.csv(file = "https://raw.githubusercontent.com/danielredondo/30diasdegraficos/master/datasets/players_20.csv",
                 encoding = "UTF-8") 

data <- data %>% select(short_name, long_name, club) %>% 
  mutate(longitud = nchar(long_name)) %>% 
  mutate(teclado_abajo = FALSE,
         teclado_medio = FALSE,
         teclado_arriba = FALSE) %>% 
  arrange(-longitud, -nchar(short_name))

# Nombre más largo
head(data)

# Nombre más corto
tail(data)

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
  if(i %% 1000 == 0) cat(paste0(i, "/", nrow(data), "\n"))
}

# Nombre más largo sin teclas de la fila de abajo del teclado
data %>% filter(teclado_abajo  == FALSE) %>% head()

# Nombre más largo sin teclas de la fila central del teclado
data %>% filter(teclado_medio  == FALSE) %>% head()

# Nombre más largo sin teclas de la fila de arriba del teclado
data %>% filter(teclado_arriba == FALSE) %>% head()
