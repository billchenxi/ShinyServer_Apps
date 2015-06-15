library(shiny)
library(shinythemes)
library(shinydashboard)

fileList = list.files(path = "data/Generated-NA/", pattern="txt")
fileList.noExt=gsub(".txt", "", fileList)
AaCode.wGly = c("Alanine","Arginine","Asparagine","Aspartate","Cystine","Glutamine","Glutamate","Glycine","Histidine","Isoleucine","Leucine","Lysine","Methionine","Fhenylalanine","Proline","Serine","Threonine","Tyrosine","Tryptophan","Valine")
aaCode.wGly = c("A","R","N","D","C","Q","E","G","H","I","L","K","M","F","P","S","T","Y","W","V")
Ss = c("Beta Strand", "Helix", "Coil")
ss = c("B", "H", "C")
re = c("CA", "CB")
stat.fileName = c("RefDB.caStat.csv", "RefDB.cbStat.csv")


# tags$head(includeScript("google-analytics.js"))
####################################
sidebar <- dashboardSidebar(
  sidebarMenu(
    menuItem("RefDB Raw Data", tabName = "rawData"),
    menuItem("RefDB Statistics", tabName = "stat"),
    menuItem("Normality Test", tabName = "norTest"),
    menuItem("More Info", tabName = "info")
  ),
  br(),
  a(img(src = "Octocat.png", height=72, width=72),  href = "https://github.com/billchenxi"),
  a(img(src = "bitbucket-logo.png", height=72, width=72),  href = "https://bitbucket.com/billchenxi"),
  img(src = "Icon@2x.png", height=72, width=72),
  h2( 
     a("Moseley's Lab", href="https://bioinformatics.cesb.uky.edu"))
  
)

####################################
body <- dashboardBody(tags$head(includeScript("google-analytics.js")),
  tabItems(
    tabItem(tabName = "rawData",
            fluidRow(
              box(
                title = "Histogram",
                plotOutput("plot1")
              ),
              box(
                title = "Controls",
                selectInput("Aa", "Amino Acid", aaCode.wGly, selected = "A"),
                selectInput("Ss", "Secondary Structure", ss, selected = "B"),
                selectInput("re", "Resonance", re, selected="CA"),
                sliderInput("breaks", "Number of breaks:", 1,500,50)
              )
            ),
            fluidRow(
              img(src = "AA-CS-Dist.png", height=900, width=800)
            )
    ),
    tabItem(tabName = "stat",
            fluidRow(
              box(
                title="RefDB Ca/Cb Statistics:",
                selectInput("stat.Input", "Type of Statistics", stat.fileName, selected = "RefDB.caStat.csv")
              )
            ),
            
            fluidRow(
              dataTableOutput(outputId = "stat.table")
              
            )
    ),
    
    tabItem(tabName = "norTest",
            img(src = "nortest.png", height=500, width=700)
    ),
    
    tabItem(tabName = "info",
            fluidRow(
              box(
                title="Author:",
                h3(
                  a("Bill (Xi Chen)", href = "mailto:billchenxi@gmail.com")
                ),
                h3(
                  a("github", href = "https://github.com/billchenxi")
                )
              )
            ),
            fluidRow(
              h2("Please visit", 
              a("Moseley's Lab", href="https://bioinformatics.cesb.uky.edu"))
            )
    )    
    
  )
)
####################################
dashboardPage(skin = "red",
  dashboardHeader(title = "RefDB Data Analysis"),
  sidebar,
  body
)

  