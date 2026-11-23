library(shiny)

startup_error <- NULL
app_ui <- NULL

tryCatch({
  library(bslib)
  
  app_ui <- page_fluid(
    theme = bs_theme(version = 5, bootswatch = "flatly"),
    card(
      card_header("Test Card"),
      card_body("If you see this, bslib works!")
    )
  )
}, error = function(e) {
  startup_error <<- paste0(
    "Error: ", conditionMessage(e), "\n",
    "Call: ", paste(deparse(conditionCall(e)), collapse = " "), "\n",
    "bslib version: ", tryCatch(as.character(packageVersion("bslib")), error = function(e) "NOT INSTALLED"), "\n",
    "shiny version: ", as.character(packageVersion("shiny")), "\n",
    "Files in repo: ", paste(list.files(recursive = TRUE), collapse = ", ")
  )
})

if (!is.null(startup_error)) {
  ui <- fluidPage(
    h3("Caught Startup Error:"),
    verbatimTextOutput("err")
  )
  server <- function(input, output, session) {
    output$err <- renderText(startup_error)
  }
} else {
  ui <- app_ui
  server <- function(input, output, session) {}
}

shinyApp(ui = ui, server = server)
