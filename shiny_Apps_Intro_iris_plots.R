#Shiny app template
#Load shiny
library(shiny)
#Create a webpage for shiny UI
#to add text fluidpage("hello world") web page with hello world text
#h1(),h2() headers;strong() bold;em() italics;
#side bar layout:fluidPage(sidebarLayout(sidebarPanel("this is side bar"),mainPanel("this is main))) 

ui <- fluidPage("Shiny is fun")
#Create server app wither the logic of application lives
server <- function(input,output){}
#Combing UI and Server
shinyApp(ui=ui,server=server)
#-----------------------------------------------------------
#Inputs and Outputs
ui <- fluidPage(textInput(inputId = "name",label = "Enter the name",value = "Nitesh"),
                numericInput(inputId = "sibs",label = "how many siblings?",value = 4,min=0)
                )
shinyApp(ui=ui,server=server)
#inputID has to be unique
#Label is the info above input data
#output is any plots,tables or any thing we want
#to generate output
#1 create a place holder
ui <- fluidPage("Plot goes here",
                plotOutput(outputId = "my_plot")
                )
#Next write r code to genrate output in server
ui <- fluidPage(
  numericInput("num","Enter the number of rows",value=10,min=0),
  tableOutput("table")
)
server <- function(input,output){
  output$table <- renderTable(iris[1:input$num,])
}
shinyApp(ui=ui,server=server)
#Rules to buid a shiny app
#build object inside render functions:renderPlot(),renderText()
#save object to output$<outputID>
#Making a iris spetal length vs spetal width and with color
ui <- fluidPage(sidebarLayout(
  sidebarPanel(numericInput("num","How many data points?",30,0,150)),
  mainPanel(textOutput("txt"),
            plotOutput("plot"),
            tableOutput("tab"))
))
data <- iris
str(data)
data <- data[sample(nrow(data)),]
server <- function(input,output){
  output$txt <- renderText({("Petal.Length Vs Petal.Width")})
  output$plot <- renderPlot({plot(data[1:input$num,c(3,4)],col=data$Species)})
  output$tab <- renderTable({data[1:input$num,]})
}
shinyApp(ui,server)
