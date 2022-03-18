library(shiny)

ui <- fluidPage(
  titlePanel("Who Are You?"),
  mainPanel(
    textOutput("user_login"),
    textOutput("login_source")
  )
)

server <- function(input, output, session) {

  user_login <- reactive({
    if (!is.null(session$user)) {
      session$user
    } else {
      Sys.getenv('USER')
    }
  })
  output$user_login <- renderText(paste0("The user's computer name is: ", user_login(), "."))

  login_source <- reactive({
    if (!is.null(session$user)) {
      "From 'session$user'"
    } else {
      "From 'Sys.getenv('USER')'"
    }
  })
  output$login_source <- renderText(paste0("The login source is: ", login_source(), "."))
}

shinyApp(ui = ui, server = server)
