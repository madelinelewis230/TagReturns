library(shiny)
library(gridExtra)
library(ggplot2)
library(dplyr)
library(lubridate)


##testing
ui <- shinyUI(fluidPage(
    selectInput("Lang",
                "Language:",
                c("English", "Spanish"),
                selected = "English"),
    tags$h1(htmlOutput("selected_var3")),
    (htmlOutput("selected_var", style='font-size:16px')),
    br(),
    img(src='WalleyeTags.png', align = "center", height="70%", width="70%"),
    br(),
    htmlOutput("selected_var2", style='font-size:16px'),
    br(),
    htmlOutput("selected_var4", style='font-size:16px'),
    br(),
    htmlOutput("selected_var7", style='font-size:16px'),
    br(),
    htmlOutput("selected_var5", style='font-size:16px'),
    br(),
    htmlOutput("selected_var6", style='font-size:16px'),
    br(),
    actionButton(inputId = "email1", 
                 icon = icon("envelope"), 
                 a("E-mail", 
                   href="mailto:fishtags@iastate.edu", style='font-size=16')
    )
    
)  
)



server <- shinyServer(function(input, output) {
    
    filtered_data <- reactive({
        lang1 %>% filter(as.factor(Lang) == input$Lang) 
        
    })
    
    selected_tag <- reactive({
        dm %>% filter(as.factor(ExtTagID) == input$ExtTagID)
        
    })
    
    
    #output$selected_var <- renderText({paste(filtered_data()$Trans)})  
    output$selected_var <- renderText({if_else(input$Lang == 'English', paste('Walleye in Big Creek and Brushy Creek have been tagged to evaluate survival, growth, and escapement. '), paste('Walleye y Muskellunge en Big Creek y Brushy Creek han sido etiquetados para evaluar la supervivencia, el crecimiento y el escape.'))})
    output$selected_var2 <- renderText({if_else(input$Lang == 'English', paste(' <i>Tag Location: </i> Fish will be tagged with one or multiple external tags (a), one small internal tag (b), and one large internal tag (c).  '), paste('<i>UbicaciÃ³n de la etiqueta: </i> los peces se etiquetarÃ¡n con una etiqueta externa (a) y una etiqueta interna (b).'))})
    output$selected_var4 <- renderText({if_else(input$Lang == 'English', paste('If you encounter a fish with an external tag, you are eligible for a <b> $200 reward </b>. To receive reward:
<br> <br> 1. If the fish was released, send a picture of the fish with the external tag visible, along with the survey information below to fishtags@iastate.edu. Please <b> do not </b> remove the external tag.  </br> </br> 
                                                                              2. If the fish was harvested, place an envelope with the internal tag and completed survey in a drop box located at the fish cleaning station and park office. </br> '), 'Si encuentra un pez con una etiqueta externa, es elegible para una<b> recompensa de $200 </b>. Para recibir recompensa:
1. Si el pez fue liberado, envÃ­e una foto del pez con la etiqueta externa visible, junto con la informaciÃ³n de la encuesta a continuaciÃ³n a fishtags@iastate.edu. No elimine la etiqueta externa.
2. Si el pescado fue cosechado, coloque un sobre con la etiqueta interna y la encuesta completa en un buzÃ³n ubicado en la estaciÃ³n de limpieza de pescado y la oficina del parque.')})
    output$selected_var3 <- renderText({if_else(input$Lang == 'English', paste(' <b> Attention Anglers'), paste(' <b> AtenciÃ³n pescadores:'))})
    output$selected_var5 <- renderText({if_else(input$Lang == 'English', paste(' <b> Please note that fish do not need to be harvested to receive reward.</b>'), paste(' <b> Tenga en cuenta que no es necesario recolectar pescado para recibir la recompensa. </b>'))})
    output$selected_var7 <- renderText({if_else(input$Lang == 'English', paste(' <b> Information needed: </b> Date of catch, approximate location, species targeted, total fish caught, hours fished, number of anglers in group</b>'), paste(' <b> Tenga en cuenta que no es necesario recolectar pescado para recibir la recompensa. </b>'))})
    output$selected_var6 <- renderText({if_else(input$Lang == 'English', paste(' Email tag reports, pictures or questions to: <b> fishtags@iastate.edu </b>, or call <b> (515) 294 - 7991 </b>'), paste(' EnvÃ­e por correo electrÃ³nico informes o preguntas sobre etiquetas a: fishtags@iastate.edu'))})
    output$selected_var8 <- renderText({if_else(input$Lang == 'English', paste(''), paste(' EnvÃ­e por correo electrÃ³nico informes o preguntas sobre etiquetas a: fishtags@iastate.edu'))})
    output$selected_var6 <- renderText({if_else(input$Lang == 'English', paste(' Email tag reports, pictures or questions to: <b> fishtags@iastate.edu </b>, or call <b> (515) 294 - 7991 </b>'), paste(' EnvÃ­e por correo electrÃ³nico informes o preguntas sobre etiquetas a: fishtags@iastate.edu'))})
    
    
})






shinyApp(ui, server)






