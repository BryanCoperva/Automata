library(shiny)
library(openxlsx)

# Definir la interfaz gráfica
ui <- fluidPage(
  titlePanel("Guardar Archivo"),
  sidebarLayout(
    sidebarPanel(
      textInput("nombre_archivo", "Nombre del Archivo:"),
      actionButton("guardar", "Guardar")
    ),
    mainPanel(
      verbatimTextOutput("mensajeOutput")
    )
  )
)

# Definir el servidor
server <- function(input, output) {
  
  # Lógica para guardar el archivo
  observeEvent(input$guardar, {
    
    # Obtener el nombre del archivo ingresado por el usuario
    nombre_archivo <- input$nombre_archivo
    
    # Verificar si se ingresó un nombre de archivo válido
    if (nombre_archivo != "") {
      
      # Ruta completa del archivo de salida
      ruta_archivo <- file.path(getwd(), paste0(nombre_archivo, ".xlsx"))
      
      # Tu código de R aquí
      # Carga de bases
      base <- read_excel("base.xlsx")
      layout <- read_excel("layout.xlsx")
      
      # Realizar el procesamiento, manipulación de datos, etc.
      # ...
      
      # Guardar el archivo usando el nombre proporcionado por el usuario
      write.xlsx(combined, ruta_archivo)
      
      # Mensaje de confirmación
      mensaje <- paste("Archivo guardado como:", ruta_archivo)
      output$mensajeOutput <- renderText(mensaje)
      
    } else {
      # Mostrar un mensaje de error si no se ingresó un nombre de archivo válido
      mensaje_error <- "Por favor, ingrese un nombre de archivo válido."
      output$mensajeOutput <- renderText(mensaje_error)
    }
  })
}

# Ejecutar la aplicación
shinyApp(ui, server)
