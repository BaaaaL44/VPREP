
library(haven)
library(ggplot2)
library(tidyverse)
library(plotly)
library(readxl)
library(DT)

fulldata_temp = read_excel("angol2.xlsx")

ui = fluidPage(sidebarLayout(sidebarPanel(selectInput(inputId = "Class", label = "Válassz Osztályt", choices = unique(fulldata_temp$Osztály), multiple = TRUE, selectize = TRUE), selectInput("Gender", "Válassz nemet", choices = c("All", "F", "L")), selectInput("Teacher", "Válassz Tanárt", choices = c("All", unique(fulldata_temp$Tanár)))), 
                             mainPanel(tabsetPanel(tabPanel("Grafikon", plotlyOutput("bar")), tabPanel("Táblázat", DTOutput("table")), tabPanel("Összesítő", DTOutput("table2"))))))


server = function(input, output){
  fulldata = read_excel('angol2.xlsx')
  fulldata = fulldata %>% mutate(Olvasott_százalék = (Olvasott/33)*100, Hallott_százalék = (Hallott/33)*100, Írás_százalék = (Írás/33)*100, Nyelv_százalék = (Nyelv/18)*100, Százalék_teljes = (Össz/150*100), Írásbeli_százalék = (Írásbeli/117)*100, Szóbeli_százalék = (Szóbeli/33)*100, Státusz = case_when(Írásbeli_százalék < 12 | Szóbeli_százalék < 12 ~ "Érvénytelen", Írásbeli_százalék >= 12 & Írásbeli < 38 ~ "Kettesért szóbelizik", Írásbeli >= 38 ~ "Írásbelin átment"), Jegy = case_when(Százalék_teljes < 25 ~ "Elégtelen", Százalék_teljes >= 25 & Százalék_teljes < 40 ~ "Elégséges", Százalék_teljes >= 40 & Százalék_teljes < 60 ~ "Közepes", Százalék_teljes >= 60 & Százalék_teljes < 80 ~ "Jó", Százalék_teljes >= 80 ~ "Jeles"))
  fulldata$Osztály = as.factor(fulldata$Osztály)
  fulldata$Nem = as.factor(fulldata$Nem)
  fulldata$Tanár = as.factor(fulldata$Tanár)
  fulldata$Státusz = factor(fulldata$Státusz, levels = c("Érvénytelen", "Kettesért szóbelizik", "Írásbelin átment"))
  fulldata$Jegy = factor(fulldata$Jegy, levels = c("Elégtelen", "Elégséges", "Közepes", "Jó", "Jeles"))
  plotdata = reactive({fulldata %>% filter(Osztály %in% input$Class, if(input$Gender != 'All')  (Nem == input$Gender) else TRUE, if(input$Teacher != 'All')  (Tanár == input$Teacher) else TRUE)}) 
  
  output$bar = renderPlotly({
    ggplotly(ggplot(plotdata(), aes(x = Név, y = Százalék_teljes, fill = Név)) + geom_col() + coord_flip() + theme(axis.text.x = element_text(angle = 90)) +theme(axis.text=element_text(size=12),
  
                                                                                                                                                                                                                                                                                                                                                                                                                                                   axis.title=element_text(size=14,face="bold")))
  })
  
  
tabdata = reactive(fulldata %>% filter(Osztály %in% input$Class, if(input$Gender != 'All')  (Nem == input$Gender) else TRUE, if(input$Teacher != 'All')  (Tanár == input$Teacher) else TRUE) %>% select(Név, Osztály, Olvasott_százalék, Írás_százalék, Nyelv_százalék, Szóbeli_százalék, Százalék_teljes) %>% mutate_if(is.numeric, round, 3))
tabdata2 = reactive(fulldata %>% filter(Osztály %in% input$Class, if(input$Gender != 'All')  (Nem == input$Gender) else TRUE, if(input$Teacher != 'All')  (Tanár == input$Teacher) else TRUE) %>% select(Osztály, Név, Olvasott_százalék, Írás_százalék, Nyelv_százalék, Szóbeli_százalék, Százalék_teljes)  %>% group_by(Osztály) %>% summarize(Átlag = mean(Százalék_teljes), Medián = median(Százalék_teljes), Szórás = sd(Százalék_teljes), MAD = mad(Százalék_teljes), Min = min(Százalék_teljes), Max = max(Százalék_teljes)) %>% mutate_if(is.numeric, round, 3))
  output$table = renderDataTable(tabdata(), filter = "top")
  output$table2 = renderDataTable(tabdata2())
}
shinyApp(ui = ui, server = server)