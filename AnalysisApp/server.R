library(shiny)

shinyServer(function(input, output) {
  source("analysisHelpers.R")
  # a large table, reative to input$show_vars
  output$mergedTable = renderDataTable({
    library(ggplot2)
    library(zipcode)
    GetMergedData(input$ageRange[1], input$ageRange[2])
  })
 
  output$agePlot = renderPlot({
    ageData <- GetAgeData(input$ageRange[1], input$ageRange[2])
    ggplot(data=ageData, aes(x=age, y=quantity, group=answer, colour=answer)) +
      geom_line() +  geom_point()
  })
  
  output$cityPlot = renderPlot({
    mergedData <- GetMergedData(input$ageRange[1], input$ageRange[2])
    njData <- aggregate(quantity ~ city + answer, mergedData[mergedData$state=="NJ",], sum)
    head(njData)
    ggplot(data=njData, aes(x=city, y=quantity, fill=answer)) +
      geom_bar(stat="identity", position=position_dodge())
  })
  
  output$usaMapPlot = renderPlot({
    mergedData <- GetMergedData(input$ageRange[1], input$ageRange[2])
    zipData <- aggregate(quantity ~ zipcode + + latitude + longitude, mergedData, sum)
    

    library(RgoogleMaps)
    
    Lat <- as.vector(zipData$latitude)
    Long <- as.vector(zipData$longitude)
    MyMap <- MapBackground(lat = Lat, lon = Long, zoom = 1)
    PlotOnStaticMap(MyMap, Lat, Long, pch = 10, cex=zipData$quantity/2, col = "red")
    
  })
  
  output$princetonMapPlot = renderPlot({
    library(RgoogleMaps)
    mergedData <- GetMergedData(input$ageRange[1], input$ageRange[2])
    princetonZipData <- aggregate(quantity ~ zipcode+ latitude + longitude, mergedData[mergedData$city=="Princeton",], sum)
    Lat <- as.vector(princetonZipData$latitude)
    Long <- as.vector(princetonZipData$longitude)
    MyMap <- MapBackground(lat = Lat, lon = Long, zoom = 2)
    PlotOnStaticMap(MyMap, Lat, Long, pch = 10, cex=princetonZipData$quantity/8, col = "red")
  })
  
})