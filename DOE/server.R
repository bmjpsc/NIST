rm(list=ls())
source("./Toman2019-ExpDesignAug14.R")
library(waiter)



shinyServer(function(input, output,session) {
  
  
  observeEvent(input$enter, {
    
    show_waiter(
      spin_circle(),
      color = "#87A96B",
      "Just a moment ..."
      
    )
    
   
  
    
    ######### inputs through the shiny interface#########################
    totn<-input$totn
    a<-input$a
    b<-input$b
    vyl<-(input$vyl)^2
    vyu<-(input$vyu)^2
    vxl<-input$vxl
    vxu<-input$vxu
    
    betal<-input$betal
    betau<-input$betau
    etal<-(input$etal)^2
    etau<-(input$etau)^2
    vsl<-(input$vsl)^2
    vsu<-input$vsu^2
    xnew<-input$xnew
    vil<-(input$vil)^2
    viu<-(input$viu)^2
    
    std<-input$std ## required maximum relative std of the answer
    ###################################################################
    ### R code
    caln<-c(4,6,8,10,12,14,15,16,18,20,22,24,28,30,36,40,44,48)
    
    out<-NULL
    designh1<-expdesign2(caln[1],totn,a,b,vyu,vxu,betal,etau,vsu,xnew,viu)
    out<-rbind(out,c(as.integer(designh1$optI),designh1$optJ,designh1$optr,designh1$optnr,designh1$optstd))
    for(i in 2:18){if(out[i-1,5]>std){
      designh<-expdesign2(caln[i],totn,a,b,vyu,vxu,betal,etau,vsu,xnew,viu)
      out<-rbind(out,c(as.integer(designh$optI),designh$optJ,designh$optr,designh$optnr,designh$optstd)) 
    }else{break}}
    
    outng<-NULL
    outng<-out
    outg<-NULL
    while(dim(out)[1]<18){outg<-out
    totn<-totn-1
    if(totn==0){break}
    out<-NULL
    designh1<-expdesign2(caln[1],totn,a,b,vyu,vxu,betal,etau,vsu,xnew,viu)
    out<-rbind(out,c(as.integer(designh1$optI),designh1$optJ,designh1$optr,designh1$optnr,designh1$optstd))
    for(i in 2:18){if(out[i-1,5]>std){
      designh<-expdesign2(caln[i],totn,a,b,vyu,vxu,betal,etau,vsu,xnew,viu)
      out<-rbind(out,c(as.integer(designh$optI),designh$optJ,designh$optr,designh$optnr,designh$optstd)) 
    }else{break}}
    dimg<-dim(outg)[1]
    
    outgood<-outg[outg[,5]<std,] ### this contains the experimental designs that satisfy the std requirement
    optI<-outgood[1] # optimal number of calibrants
    optJ<-outgood[2]  # optimal number of replicates
    optr<-outgood[3]  # optimal number of samples in the quantitation experiment
    optnr<-outgood[4] # optimal number of replicates per sample
    optstd<-outgood[5] # optimal expected relative standard deviation of the response
    
    optx<-NULL
    optx[1]<-a
    optIm1<-optI-1
    
    for(i in 1:optIm1){
      optx[i+1]<-a+i*(b-a)/optIm1}}
    
    dimng<-dim(outng)[1]
    
   
    
  hide_waiter()
    
     if(outng[dimng,5]>std){
      ################to be printed in shiny#################
      
      #######################################################
      outbest<-outng[18,]
      optIb<-outbest[1]  # number of calibrants
      optJb<-outbest[2]  # number of replicates
      optrb<-outbest[3]  # number of samples in the quantitation experiment
      optnrb<-outbest[4] # number of replicates per sample
      optstdb<-outbest[5] # the smallest expected relative standard deviation of the response given your totn and std
      optxb<-NULL
      optxb[1]<-a
      optIm1b<-optIb-1
      for(i in 1:optIm1b){
                optxb[i+1]<-a+i*(b-a)/optIm1b}
      
   
      
      
      ######## to be printed in Shiny#######################
      # output$toPrint <- renderValueBox(box(print(paste0("optstdb: ",optstdb, "\nthis is the corresponding design",
      #                                    "\noptIb: ",optIb,
      #                                    "\noptJb: ",optJb,
      #                                    "\noptrb: ",optrb,
      #                                    "\noptnrb: ",optnrb,
      #                                    "\noptxb: ",optxb)))) ### print in Shiny
      # 
      shinyalert("Oops!", "Please increase the total number observations otherwise the best possible experimental design is:", type = "error")
      results <- matrix(c(optxb),ncol =length(optxb), nrow = 1)
      optxb.colnames = sapply(1:length(optxb), function(x){paste0("level", x)})
      colnames(results) = c( optxb.colnames)
      
      
      results2 <- matrix(c(optIb,optJb,optrb,optnrb),ncol=4, nrow = 1)
      colnames(results2) <- c("Calibrants","Calibrant replicates","Samples","Sample replicates")
      
      results3 <- matrix(c(optstdb))
      colnames(results3) <- c("Standard Deviation")

      
      
      output$toPrint <- renderTable(results,spacing=c( "l"),align="l") ### print in Shiny
      output$toPrint2 <- renderTable(results2,spacing=c( "l"),align="l",digits = 0)
      output$toPrint3 <- renderTable(results3,spacing=c( "l"),align="l")
      
      
   
      ######################################################
      
    }else{
      
  
      
      
      results <- matrix(c(optx),ncol =length(optx), nrow = 1)
      optx.colnames = sapply(1:length(optx), function(x){paste0("level", x)})
      colnames(results) = c( optx.colnames)
      
      
      results2 <- matrix(c(optI,optJ,optr,optnr),ncol=4, nrow = 1)
      colnames(results2) <- c("Calibrants","Calibrant replicates","Samples","Sample replicates")

      results3 <- matrix(c(optstd))
      colnames(results3) <- c("Standard Deviation")
      
      
    
      output$toPrint <- renderTable(results,spacing=c( "l"),align="l") ### print in Shiny
      output$toPrint2 <- renderTable(results2,spacing=c( "l"),align="l",digits = 0)
      output$toPrint3 <- renderTable(results3,spacing=c( "l"),align="l")

      #######################################################
  }
    
  
  })
})
