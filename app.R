library(shiny)

ui <- fluidPage(
  titlePanel("Who Are You?"),
  mainPanel(
    textOutput("user_login"),
    textOutput("login_source")
  )
)

server <- function(input, output, session) {

  if (!is.null(session$user)) {
    user_login   <- reactive(session$user)
    login_source <- reactive("from session$user")
  } else {
    user_login   <- reactive(Sys.getenv('USER'))
    login_source <- reactive("from 'Sys.getenv('USER')") 
  }

  output$user_login   <- renderText(paste0("The user's computer name is: ", user_login(), "."))
  output$login_source <- renderText(paste0("The login source is: ", login_source(), "."))
}

shinyApp(ui = ui, server = server)