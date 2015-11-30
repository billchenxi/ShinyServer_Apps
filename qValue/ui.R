# ui.R
library(shiny)

shinyUI(fluidPage(
  titlePanel(
    "Statistical Tools: Q-values"),
  sidebarLayout(
    sidebarPanel(
      fileInput('file', 'Choose CSV File',
                accept=c('text/csv', 
                         'text/comma-separated-values,text/plain', 
                         '.csv')),
      #tags$hr(),
      checkboxInput('header', 'Header', TRUE),
      radioButtons('sep', 'Separator',
                   c(Comma=',',
                     Semicolon=';',
                     Tab='\t'),
                   ','),
      radioButtons('quote', 'Quote',
                   c(None='',
                     'Double Quote'='"',
                     'Single Quote'="'"),
                   '"'),
      # submitButton("Submit"),
      br(),
      downloadButton('downloadData', 'Download'),
      br(),
      br(),
      br(),
      br(),
      br(),
      br(),
      br(),
      img(src = "Icon@2x.png", height=72, width=72)
    ),
    #########
 
    mainPanel(
      h3("Help text"),
      helpText(p("Please choose a file with extention \".csv\" with ONLY one header line"),
               img(src = "Eg.png", hight = 5376, width = 720),
               p("If you are using MS Excel, please save the file as \".csv\" format.")),
      h3("Input Preview"),
      h5("Note: values in preview will only contain two digits after decimal point."),
      tableOutput('table1'),
      h3("Output Preview"),
      h5("Note: values in preview will only contain two digits after decimal point. But downloaded file will contain more digits."),
      tableOutput('table2')
    ),
  )
      

))