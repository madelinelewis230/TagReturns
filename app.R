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
    img(src='WalleyeTags.png', align = "center", height="100%", width="100%"),
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

                
    ),
    
    htmlOutput("selected_var8", style='font-size:16px'),
    br(),
    
) 
)



server <- shinyServer(function(input, output) {
    
    filtered_data <- reactive({
        lang1 %>% filter(as.factor(Lang) == input$Lang) 
        
    })

    
    #output$selected_var <- renderText({paste(filtered_data()$Trans)})  
    output$selected_var <- renderText({if_else(input$Lang == 'English', paste('Walleye in Big Creek and Brushy Creek have been tagged to evaluate survival, growth, and escapement. '), paste('Los leucomas en Big Creek y Brushy Creek han sido etiquetados para evaluar la supervivencia, el crecimiento y el escape.'))})
    output$selected_var2 <- renderText({if_else(input$Lang == 'English', paste(' <h1> Tag Location: </h1> Fish will be tagged with one or multiple external tags (a), one small internal tag (b), and one large internal tag (c). '), paste('<h1>Ubicación de la etiqueta: </h1> Los peces se marcarán con una o varias marcas externas (a), una pequeña marca interna (b) y una grande interna (c).'))})
    output$selected_var4 <- renderText({if_else(input$Lang == 'English', paste('If you encounter a fish with an external tag, you are eligible for a <b> $200 reward </b>. <br> <h1> To receive reward: </h1> 
1. If the fish was released, send a picture of the fish with the external tag visible, all numbers on external tag(s), and the survey information below to fishtags@iastate.edu. Please <b> do not </b> remove the external tag.  </br> </br> 
                                                                              2. If the fish was harvested, place internal tags (b and c) and information listed below into an envelope, and call or e-mail for further instructions. </br> '), 'Si encuentra un pez con una etiqueta externa, es elegible para una<b> recompensa de $200 </b>.<h1> Para recibir recompensa:</h1> 
 1. Si el pez fue liberado, envíe una foto del pez con la etiqueta externa visible, junto con la información de la encuesta a continuación a fishtags@iastate.edu. <b> No </b> elimine la etiqueta externa. </br> </br>
                                                                              2. Si el pescado fue cosechado, coloque las etiquetas internas (byc) y la información que se indica a continuación en un sobre, y llame o envíe un correo electrónico para obtener más instrucciones. </br> ')})
    output$selected_var3 <- renderText({if_else(input$Lang == 'English', paste(' <b> Attention Anglers'), paste(' <b> 
Atención pescadores:'))})
    output$selected_var5 <- renderText({if_else(input$Lang == 'English', paste(' <b> Please note that fish do not need to be harvested to receive reward.</b>'), paste(' <b> Tenga en cuenta que no es necesario recolectar pescado para recibir la recompensa. </b>'))})
    output$selected_var7 <- renderText({if_else(input$Lang == 'English', paste(' <b> Information needed: </b> Date of catch, approximate location, species targeted, length, weight, total fish caught, hours fished, number of anglers in group</b>'), paste(
'<b> Información necesaria: </b> fecha de captura, ubicación aproximada, especie objetivo, talla, peso, total de peces capturados, horas de pesca, número de pescadores en el grupo </b> '))})
    output$selected_var6 <- renderText({if_else(input$Lang == 'English', paste(' Email tag reports, pictures or questions to: <b> fishtags@iastate.edu </b>, or call <b> (515) 294 - 7991 </b>'), paste('Envíe por correo electrónico informes de etiquetas, imágenes o preguntas a: fishtags@iastate.edu o llamar <b> (515) 294 - 7991 </b>'))})
    output$selected_var8 <- renderText({if_else(input$Lang == 'English', paste('<h1> Frequently Asked Questions </h1> <b> How do I know if I am eligible for a reward? </b> <br>

Anglers who capture fish with an external tag (jaw tag and/or loop tag) and harvest the fish will receive the reward after returning the large internal tag (c).  If a fish was released, you will be eligible for a reward if you provide a picture of the fish with the external tag clearly visible, and provide the necessary information regarding your catch.  <br>
<br>
<b> What if a fish only has one external tag?  </b> <br>

You are still eligible for the reward if only one external tag is present, as long as the large internal tag is returned, or a verifiable picture is provided. <br>

<br>
<b> What if I catch a fish with no external tags, but I find a small internal tag when cleaning the fish? Or, I find a small internal tag in a different species? </b> <br>

Please report any tags that you find, as all tag reporting data is beneficial to our research. However, only fish with large internal tags (c) are eligible for a reward. <br>

 <br> <b> Please feel free to reach out with any additional questions. </b>

<h1> About the project </h1>

This study is a continuation of past research that aims to better understand what factors are regulating populations of walleye in Iowa reservoirs. We are also evaluating the effectiveness of barriers at preventing escapement of walleye over spillways, with the goal of improving reservoir fisheries. Tag reports provide us with important information regarding harvest and fishing pressure, and tag returns allow us to redeploy tags and continue to collect data for the entire length of the study. We appreciate your cooperation and participation in improving Iowas walleye fisheries. <br>
 
    <br>
        
    This study is being conducted by: <br>
    Iowa Department of Natural Resources<br>  
    Iowa State University<br>
    U.S. Army Corps of Engineers<br>
    <br>'), paste('<h1> Preguntas frecuentes </h1> <b> ¿Cómo sé si soy elegible para una recompensa? </b> <br>
    Los pescadores que capturan peces con una etiqueta externa (etiqueta de mandíbula y / o etiqueta de bucle) y cosechan el pez recibirán la recompensa después de devolver la etiqueta interna grande (c). Si un pez fue liberado, usted será elegible para una recompensa si proporciona una imagen del pez con la etiqueta externa claramente visible y proporciona la información necesaria con respecto a su captura. <br>
    <br>
    <b> ¿Qué pasa si un pez solo tiene una etiqueta externa? </b> <br>
    Aún eres elegible para la recompensa si solo hay una etiqueta externa, siempre que se devuelva la etiqueta interna grande o se proporcione una imagen verificable. <br>
    <br>
    <b> ¿Qué pasa si pesco un pez sin etiquetas externas, pero encuentro una pequeña etiqueta interna al limpiar el pescado? ¿O encuentro una pequeña etiqueta interna en una especie diferente? </b> <br>
    Informe las etiquetas que encuentre, ya que todos los datos de informes de etiquetas son beneficiosos para nuestra investigación. Sin embargo, solo los peces con etiquetas internas grandes (c) son elegibles para una recompensa. <br>
    <br> <b> No dude en comunicarse con cualquier pregunta adicional. </b>
    <h1> Acerca del proyecto </h1>
    Este estudio es una continuación de investigaciones anteriores cuyo objetivo es comprender mejor qué factores regulan las poblaciones de lucioperca en los embalses de Iowa. También estamos evaluando la efectividad de las barreras para prevenir el escape de leucomas sobre aliviaderos, con el objetivo de mejorar las pesquerías de embalse. Los informes de etiquetas nos brindan información importante sobre la captura y la presión de pesca, y las devoluciones de etiquetas nos permiten volver a implementar las etiquetas y continuar recopilando datos durante todo el estudio. Agradecemos su cooperación y participación en la mejora de las pesquerías de lucioperca de Iowa. <br>
    
    <br>
'))})

})






shinyApp(ui, server)
