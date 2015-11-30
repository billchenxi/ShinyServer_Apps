# server.R
library(shiny)

shinyServer(function(input, output) {
    # input Preview
    output$table1 <- renderTable({
      inFile <- input$file
      if(is.null(inFile))
        return(NULL)
      head(read.csv(inFile$datapath, header=input$header, sep=input$sep, quote=input$quote))
    })
    # Calculation
    
    datasetOutput<-reactive({
      
    })
    
      
    output$table2 <- renderTable({
      inFile <- input$file
      if(is.null(inFile))
        return(NULL)
      pval = read.csv(inFile$datapath, header=input$header, sep=input$sep, quote=input$quote)
      pval.new = pval
      pval.new$X<-NULL
      qval = sapply(pval.new, function(i)  p.adjust(i, method = "fdr") )
      rownames(qval)<-as.character(pval$X)
      qval.1<<-qval # <<- make it global
    })
    
  output$downloadData <- downloadHandler(
    filename = "qvalue.csv",
    content = function(file){
      write.csv(qval.1, file)
    }
  )
})