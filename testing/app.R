
ui <- fluidPage(
    sidebarLayout(
        sidebarPanel(
            fileInput("file1", "Choose CSV File",multiple = TRUE),
            checkboxInput("header", "Header", TRUE)
        ),
        mainPanel(
            renderTable("contents")
        )
    )
)

server <- function(input, output) {
    print('hererere')
    values <- reactiveValues()
    output$contents <- renderTable({
        if(is.null(input$file1))
            return(NULL)
        for(i in 1:length(input$file1[,1])){
            message(input$files[[i, 'datapath']])
    }})
    values$f <- input$file1
    
    print(values)
}

shinyApp(ui, server)
