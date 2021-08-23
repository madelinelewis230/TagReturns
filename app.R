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

    
    #output$selected_var <- renderText({paste(filtered_data()$Trans)})  
    output$selected_var <- renderText({if_else(input$Lang == 'English', paste('Walleye in Big Creek and Brushy Creek have been tagged to evaluate survival, growth, and escapement. '), paste('Los leucomas en Big Creek y Brushy Creek han sido etiquetados para evaluar la supervivencia, el crecimiento y el escape.'))})
    output$selected_var2 <- renderText({if_else(input$Lang == 'English', paste(' <i> Tag Location: </i> Fish will be tagged with one or multiple external tags (a), one small internal tag (b), and one large internal tag (c). '), paste('<i>Ubicación de la etiqueta: </i> Los peces se marcarán con una o varias marcas externas (a), una pequeña marca interna (b) y una grande interna (c).'))})
    output$selected_var4 <- renderText({if_else(input$Lang == 'English', paste('If you encounter a fish with an external tag, you are eligible for a <b> $200 reward </b>. To receive reward:
<br> <br> 1. If the fish was released, send a picture of the fish with the external tag visible, along with the survey information below to fishtags@iastate.edu. Please <b> do not </b> remove the external tag.  </br> </br> 
                                                                              2. If the fish was harvested, place internal tags (b and c) and information listed below into an envelope, and call or e-mail for further instructions. </br> '), 'Si encuentra un pez con una etiqueta externa, es elegible para una<b> recompensa de $200 </b>. Para recibir recompensa:
 1. Si el pez fue liberado, envíe una foto del pez con la etiqueta externa visible, junto con la información de la encuesta a continuación a fishtags@iastate.edu. <b> No </b> elimine la etiqueta externa. </br> </br>
                                                                              2. Si el pescado fue cosechado, coloque las etiquetas internas (byc) y la información que se indica a continuación en un sobre, y llame o envíe un correo electrónico para obtener más instrucciones. </br> ')})
    output$selected_var3 <- renderText({if_else(input$Lang == 'English', paste(' <b> Attention Anglers'), paste(' <b> AtenciÃ³n pescadores:'))})
    output$selected_var5 <- renderText({if_else(input$Lang == 'English', paste(' <b> Please note that fish do not need to be harvested to receive reward.</b>'), paste(' <b> Tenga en cuenta que no es necesario recolectar pescado para recibir la recompensa. </b>'))})
    output$selected_var7 <- renderText({if_else(input$Lang == 'English', paste(' <b> Information needed: </b> Date of catch, approximate location, species targeted, length, weight, total fish caught, hours fished, number of anglers in group</b>'), paste(
'<b> Información necesaria: </b> fecha de captura, ubicación aproximada, especie objetivo, talla, peso, total de peces capturados, horas de pesca, número de pescadores en el grupo </b> '))})
    output$selected_var6 <- renderText({if_else(input$Lang == 'English', paste(' Email tag reports, pictures or questions to: <b> fishtags@iastate.edu </b>, or call <b> (515) 294 - 7991 </b>'), paste('Envíe por correo electrónico informes de etiquetas, imágenes o preguntas a: fishtags@iastate.edu o llamar <b> (515) 294 - 7991 </b>'))})
   
    
    
})






shinyApp(ui, server)


