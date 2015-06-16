library(shiny)
library(nortest)
library(ggplot2)

#########################
fileList = list.files(path = "data/Generated-NA/", pattern="txt")
fileList.noExt=gsub(".txt", "", fileList)
AaCode.wGly = c("Alanine","Arginine","Asparagine","Aspartate","Cystine","Glutamine","Glutamate","Glycine","Histidine","Isoleucine","Leucine","Lysine","Methionine","Fhenylalanine","Proline","Serine","Threonine","Tyrosine","Tryptophan","Valine")
aaCode.wGly = c("A","R","N","D","C","Q","E","G","H","I","L","K","M","F","P","S","T","Y","W","V")
Ss = c("Beta Strand", "Helix", "Coil")
ss = c("B", "H", "C")
re = c("CA", "CB")
col.names = c("A.B.CA", "A.B.CB", "A.B.CO", "A.C.CA", "A.C.CB", "A.C.CO", "A.H.CA", "A.H.CB", "A.H.CO", "C.B.CA", "C.B.CB", "C.B.CO", "C.C.CA",
          "C.C.CB", "C.C.CO", "C.H.CA", "C.H.CB", "C.H.CO", "D.B.CA", "D.B.CB", "D.B.CO", "D.C.CA", "D.C.CB", "D.C.CO", "D.H.CA", "D.H.CB",
          "D.H.CO", "E.B.CA", "E.B.CB", "E.B.CO", "E.C.CA", "E.C.CB", "E.C.CO", "E.H.CA", "E.H.CB", "E.H.CO", "F.B.CA", "F.B.CB", "F.B.CO",
          "F.C.CA", "F.C.CB", "F.C.CO", "F.H.CA", "F.H.CB", "F.H.CO", "G.B.CA", "G.B.CB", "G.B.CO", "G.C.CA", "G.C.CB", "G.C.CO", "G.H.CA",
          "G.H.CB", "G.H.CO", "H.B.CA", "H.B.CB", "H.B.CO", "H.C.CA", "H.C.CB", "H.C.CO", "H.H.CA", "H.H.CB", "H.H.CO", "I.B.CA", "I.B.CB",
          "I.B.CO", "I.C.CA", "I.C.CB", "I.C.CO", "I.H.CA", "I.H.CB", "I.H.CO", "K.B.CA", "K.B.CB", "K.B.CO", "K.C.CA", "K.C.CB", "K.C.CO",
          "K.H.CA", "K.H.CB", "K.H.CO", "L.B.CA", "L.B.CB", "L.B.CO", "L.C.CA", "L.C.CB", "L.C.CO", "L.H.CA", "L.H.CB", "L.H.CO", "M.B.CA",
          "M.B.CB", "M.B.CO", "M.C.CA", "M.C.CB", "M.C.CO", "M.H.CA", "M.H.CB", "M.H.CO", "N.B.CA", "N.B.CB", "N.B.CO", "N.C.CA", "N.C.CB",
          "N.C.CO", "N.H.CA", "N.H.CB", "N.H.CO", "P.B.CA", "P.B.CB", "P.B.CO", "P.C.CA", "P.C.CB", "P.C.CO", "P.H.CA", "P.H.CB", "P.H.CO",
          "Q.B.CA", "Q.B.CB", "Q.B.CO", "Q.C.CA", "Q.C.CB", "Q.C.CO", "Q.H.CA", "Q.H.CB", "Q.H.CO", "R.B.CA", "R.B.CB", "R.B.CO", "R.C.CA",
          "R.C.CB", "R.C.CO", "R.H.CA", "R.H.CB", "R.H.CO", "S.B.CA", "S.B.CB", "S.B.CO", "S.C.CA", "S.C.CB", "S.C.CO", "S.H.CA", "S.H.CB",
          "S.H.CO", "T.B.CA", "T.B.CB", "T.B.CO", "T.C.CA", "T.C.CB", "T.C.CO", "T.H.CA", "T.H.CB", "T.H.CO", "V.B.CA", "V.B.CB", "V.B.CO",
          "V.C.CA", "V.C.CB", "V.C.CO", "V.H.CA", "V.H.CB", "V.H.CO", "W.B.CA", "W.B.CB", "W.B.CO", "W.C.CA", "W.C.CB", "W.C.CO", "W.H.CA",
          "W.H.CB", "W.H.CO", "Y.B.CA", "Y.B.CB", "Y.B.CO", "Y.C.CA", "Y.C.CB", "Y.C.CO", "Y.H.CA", "Y.H.CB", "Y.H.CO")
#########################
RefDB.stat.ca = read.csv("data/RefDB.caStat.csv")
RefDB.stat.cb = read.csv("data/RefDB.cbStat.csv")
aaCode = c("A",      "R",  "N",   "D",   "C",   "Q",   "E",   "H",   "I",   "L",   "K",   "M",   "F",   "P",   "S",   "T",   "Y",  "W", "V")
aaCode.L = c("ALA", "ARG", "ASN", "ASP", "CYS", "GLN", "GLU", "HIS", "ILE", "LEU", "LYS", "MET", "PHE", "PRO", "SER", "THR", "TYR","TRP","VAL")
aaCode.l = c("Ala", "Arg", "Asn", "Asp", "Cys", "Gln", "Glu", "His", "Ile", "Leu", "Lys", "Met", "Phe", "Pro", "Ser", "Thr", "Tyr","Trp","Val")
#########################


shinyServer(function(input, output){
  RefDB.data = read.csv("data/RefDB.csv", header=F)
#############################
  output$plot1 <- renderPlot({
    name = paste(input$Aa, input$Ss, input$re, sep=".")
    a <- which(col.names==name)
    histdata <- RefDB.data[,a]
    title.hist = paste("Histogram of",name)
    hist(histdata, freq=F, main = title.hist, breaks=input$breaks)
    })
#############################
#   output$table <- renderDataTable({
#     name = paste(input$Aa, input$Ss, input$re, sep="-")
#     file.name = paste("data/Generated-NA/", name, ".txt", sep="")
#     data = read.table(file.name, quote="\"")
#     colnames(data) = name
#     data
#   })
#############################
  output$stat.table <- renderDataTable({
    name = paste("data/",input$stat.Input,sep="")
    stat.data <- read.csv(name, header = T)
    stat.data 
  })
})