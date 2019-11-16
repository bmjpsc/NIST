rm(list=ls())
library(shiny)
library(shinyBS)
library(shinydashboard)
library(shinyalert)
library(waiter)

dashboardPage(
  
  dashboardHeader(title = "Experimental Design App",dropdownMenu(type ="notification"),titleWidth = 350),
  
  
  
  dashboardSidebar(
    width = 350,
    sidebarMenu(
      
      )
    
  ),
  dashboardBody(
    
    tags$head(tags$style(HTML('
      .main-header .logo {
        font-family: "Georgia", Times, "Times New Roman", serif;
        font-weight: bold;
        font-size: 22px;
      }
    '))),
    
 
    tabItem(
            tags$head(
              tags$style(type="text/css","label{ display: table-cell; text-align: left;
vertical-align: right; } .form-group { display: table-row;}")
            ),
            
            
             fluidRow(style='margin: 0px;',
            box(width='100%',
            title = "Number of test chemicals", status = "primary",solidHeader = TRUE,
            fluidRow(
              column(4,
                     numericInput("N",label = NULL,value = 7)
              )
            )
            ),
           
           fluidRow(style='margin: 0px;',
            box( width='100%',
              title = "Total number of test chemical measurements",status = "success",solidHeader = TRUE,
              fluidRow(
                column(4,
                       numericInput("std",
                                    label = NULL,
                                    value = 2.5)
                )
              )
            )
            ),
           
           fluidRow(style='margin: 0px;',
                    box(width='100%',
                        title = "The expected approximate value of the measurand, quantity of A",status = "success",solidHeader = TRUE,
                        fluidRow(
                          column(4,
                                 numericInput("xnew",
                                              label = NULL,
                                              value = 0.79)
                          )
                        )
                    )
                    ),
           
           fluidRow(style='margin: 0px;',
           
                    box( width='100%', 
           title ="Target calibration region; x-axis range in terms of concentrations of A:I in the calibration solutions",status = "success",solidHeader = TRUE,
           fluidRow( 
             
           column(3,
              numericInput(
              "a",
              label = h4("Minimum:"),
              value = 0.24)),
            column(3,
            numericInput(
              "b",
              label = h4("Maximum:"),
              value = 1.62))
           ) 
           )
            )
           ),
           
           fluidRow(style='margin: 0px;',
                    box( width='100%', 
                         title ="Expected slope of your calibration line",status = "success",solidHeader = TRUE,
                         fluidRow( 
                           column(3,
                                  numericInput(
                                    "betal",
                                    label = h4("Minimum:"),
                                    value = 1.32)),
                           column(3,
                                  numericInput(
                                    "betau",
                                    label = h4("Maximum:"),
                                    value = 1.44)
                         ) 
                    )
           )
    ),
        
    fluidRow(style='margin: 0px;',
             box( width='100%', 
                  title ="Expected standard deviation of peak area ratios (A:I) from repeat measurement of a calibration solution; (uy)",status = "warning",solidHeader = TRUE,
                  fluidRow( 
                    column(3,
                           numericInput(
                             "vyl",
                             label = h4("Minimum:"),
                             value = 0.017)),
                    column(3,
                           numericInput(
                             "vyu",
                             label = h4("Maximum:"),
                             value = 0.066)
                    ) 
                  )
             )
    ),
    
    
    
    fluidRow(style='margin: 0px;',
             box( width='100%', 
                  title ="Expected standard uncertainty of the concentration ratios of A:I in the calibration experiment; (ux) ",status = "warning",solidHeader = TRUE,
                  fluidRow( 
                    column(3,
                           numericInput(
                             "vxl",
                             label = h4("Minimum:"),
                             value = 0)),
                    column(3,
                           numericInput(
                             "vxu",
                             label = h4("Maximum:"),
                             value = 0)
                    ) 
                  )
             ),
             
             fluidRow(style='margin: 0px;',
                      box( width='100%', 
                           title ="Expected relative standard deviation of peak area ratios (A:I) from repeat measurement of a calibration solution; (ruy) ",status = "warning",solidHeader = TRUE,
                           fluidRow( 
                             column(3,
                                    numericInput(
                                      "etal",
                                      label = h4("Minimum:"),
                                      value = 0.016)),
                             column(3,
                                    numericInput(
                                      "etau",
                                      label = h4("Maximum:"),
                                      value = 0.046)
                             ) 
                           )
                      ),
                      
                      fluidRow(style='margin: 0px;',
                               box( width='100%', 
                                    title ="Expected between-sample variability (standard deviation) of peak area ratios (A:I) from the quantitation experiment; (us); e.g., due to heterogeneity or variability in sample preparation ",status = "warning",solidHeader = TRUE,
                                    fluidRow( 
                                      column(3,
                                             numericInput(
                                               "vsl",
                                               label = h4("Minimum:"),
                                               value = 0.01)),
                                      column(3,
                                             numericInput(
                                               "vsu",
                                               label = h4("Maximum:"),
                                               value = 0.026)
                                      ) 
                                    )
                               ),
                               fluidRow(style='margin: 0px;',
                                        box( width='100%', 
                                             title ="Expected relative standard uncertainty of the concentration of I in samples measured for the quantitation experiment; (ui) ",status = "warning",solidHeader = TRUE,
                                             fluidRow( 
                                               column(3,
                                                      numericInput(
                                                        "vil",
                                                        label = h4("Minimum:"),
                                                        value = 0.01)),
                                               column(3,
                                                      numericInput(
                                                        "viu",
                                                        label = h4("Maximum:"),
                                                        value = 0.037)
                                               ) 
                                             )
                                        ),
                                        
                                        
                                             
                                        
                                        
                                               actionButton("enter","GO!",icon("paperr-plane"), 
                                                            style="color: #fff; background-color: #337ab7; border-color: #2e6da4", width = '15%'),
                                               helpText("Please check your inputs first and click 'go' to see the output results"),
                                     
                                        use_waiter(), 
                                        useShinyalert(),
                                        bsModal("Results",
                                                box(width='100%', title ="The best possible experimental design:",status = "primary",height = 0,solidHeader = TRUE),
                                                 "enter",size = "large",
                                                tableOutput("toPrint2"), tableOutput("toPrint"),tableOutput("toPrint3"))
                                        )
                            
                               
                               
                               
                      )
                      
                      
             )
             
    )
    
    
    )
    )
    
    )
      
         



  
