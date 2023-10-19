library(shinyBS)
library(readr)
library(shinycssloaders)




options(java.parameters = "-Xss2560k")


shinyUI(fluidPage(
  
  HTML('
    <link rel="stylesheet" href="css/nist-combined.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="js/nist-header-footer.js" type="text/javascript" defer="defer"></script>
    <html class="nist-footer-bottom">
    '),
  
  tags$head(HTML("
    <!-- Google tag (gtag.js) -->
    <script async src='https://www.googletagmanager.com/gtag/js?id=G-1L2H9B3YCD'></script>
    <script>
      window.dataLayer = window.dataLayer || [];
      function gtag(){dataLayer.push(arguments);}
      gtag('js', new Date());
    
      gtag('config', 'G-1L2H9B3YCD');
    </script>")),
  
    tags$style("#mu_est {font-size:14px;
               color:steelblue;
               }"),
    tags$style("#mu_se {font-size:14px;
               color:steelblue;
               }"),
    tags$style("#mu_median {font-size:14px;
               color:steelblue;
               }"),
    tags$style("#mu_quant {font-size:14px;
               color:steelblue;
               }"),
    
    ###
    
    tags$style("#mu_est1 {font-size:14px;
               color:steelblue;
               }"),
    tags$style("#mu_se1 {font-size:14px;
               color:steelblue;
               }"),
    tags$style("#mu_median1 {font-size:14px;
               color:steelblue;
               }"),
    tags$style("#mu_quant1 {font-size:14px;
               color:steelblue;
               }"),
    tags$head(tags$style(
      HTML('#title {
           color: red;
           font-size: 40px;
           font-style: bold;
          }'))),
    tags$head(
      tags$style(HTML("
      .shiny-output-error-validation {
        color: red;
      }
    "))
    ),
    
  theme = "style.css",
     withMathJax(),
     tags$head(
       tags$style(HTML("
                      .shiny-output-error-validation {
                      color: red;
                      }
                      "))
     ),
    


    h1(id="big-heading", strong("NIST Chemical Analysis Package: Design for a plate with 24 wells")),
    tags$style(HTML("#big-heading{color:steelblue;}")),
   
    br(),
    
   
    navlistPanel(
      
      widths=c(4,8),
      tabPanel(
      h4("About Well App "),
      h2("About the Well App", style = "color:steelblue"), 
      h4("This package consists of two modules: Pre-Experiment and Design of Experiment. "),
      br(),
      h4("The Pre-Experiment module takes as input data from a balanced random factor one-way ANOVA 
         experiment  and calculatesthe 'within' or repeatability, 
         and 'between' or heterogeneity, uncertainty components. "),
      br(),
      h4("The Design of Experiment module derives an optimal allocation of 24 wells in
      a two-part experiment where the first experiment is with 24 wells and the second is with 96 wells.
      The 24 well layout determines the 96 well layout. "),
 
      br(),
      br(),
     
      ),
      
      "Pre-Experiment",
      
      selected =  h4("Data entry"),
      
      tabPanel(
        h4("Background"),

        em(h3("Background for the Pre-Experiment ", style = "color:steelblue")),
        br(),
        
        h4("The Pre-Experiment module takes as input a csv file with the following format."),
        br(),
         img(src='Background_IMG5.png', align = "center", height = 250, width = 500),
         br(),
        
         h4("The columns are arranged as:"),
        
        
         h4(" Column 1 is the input data for chemical one, column 2 are the assigned levels of the 
         random factor (for example plate), column 3 is the input data for chemical 2, etc. 
         There can be up to 5 different chemicals and their accompanying assigned levels,
         that is, up to 10 columns."),
         
         h4("The results:"),
         h4("The results are the TCsigv (heterogeneity or between) and repsigTCv 
         (repeatability or within) for each of the chemicals. For the data in the table, we obtain:"),
        img(src='Background_IMG6.png', align = "center", height = 150, width = 260),
        br(),
        h4("These results are the ANOVA type estimator based on a balanced random effects model.")
        
        
        # hr(),
        # em(h4("Data Table Upload")),
        # hr(),
        # br(),
        # h4("Experiments that generate multiple calibration curves to determine a single result are supported. For example:"),
        # h4("- measurements conducted over several days with separate calibrations"),
        # h4("- employment of multiple different techniques using internal standards"),
        # br(),
        # em(h4("Multiple data files can be uploaded simultaneously. Upload calibration and corresponding sample tables in the same order.")),
        # br(),
        # img(src='Background_IMG3.png', align = "center", height = 350, width = 825),
        # hr(),
        # h4("Calibration Data Tables"),
        # 
        # 
        # 
        # em(h3("Model Settings")),
        # hr(),
        # h4("1) Specify coverage interval of estimated result. Default is 95 %."),
        # h4("2) Indicate destired number of decimal places printed for results"),
        # h4("3) Total number of iterations should be adjusted if app indicates that more iterations are needed"),
        # h4("4) Length of burn in should only be increased if app indicates that the model has not converged. Do not decrease this value."),
        # br(),
        # img(src='Background_IMG4.png', align = "center", height = 350, width = 825),
        # br(),
        # hr(style="border-color: black;"), 
        
      ),
    
      tabPanel(
        h4("Data entry"),
        
        
      
          fluidRow(style='margin: 0px;',
         column(12,
          tabsetPanel(
          tabPanel(
            title=h4("Upload  Data Tables:",style = "color:steelblue"),
            br(),
            # column(12, downloadButton('downloadCalTable', 'Download  Data Table Template')),
            
            # column(6, 
            #        em(h5("X data:")),
            #        em(h5("mid: Quantity (mass or volume) of internal standard added to calibrant(Only for internal standard use)")),
            #        em(h5("mad: Quantity (mass or volume) of analyte working standard solution in calibrant")),
            #        em(h5("Analyte working standard solution ID # (e.g. 1, 2)"))),
            
            # column(6,
            #        em(h5("Y data:")),
            #        em(h5("raci: Analyte: Internal Standard Peak Areas Ratio for calibrant repeat measurement i"))),
            
            fileInput(
              inputId = "file",
              label = "",
              multiple = TRUE,
              accept = c("text/csv",".xlsx",
                         "text/comma-separated-values,text/plain",
                         ".csv"),
              placeholder = ""
            )),
          
          
          tabPanel(
            title=h4(""),
           
           
          )))),
        
                    
                   uiOutput("expui"),
                   uiOutput("doe12"),
                  uiOutput("doeinput"),
                  
        
        br(),
        
        ########Fit the model ui#######
        
        ##################################################################
        ### MCMC Results #################################################
        ##################################################################
        mainPanel(
          fluidRow(style='margin: 0px;',
            actionButton("go","Fit the model",  
                         style="color: #fff; background-color: #337ab7; border-color: #2e6da4", width = '30%')
          ),
          fluidRow(style='margin: 0px;',
            helpText("Please check your data first and then fit the model")
          )
        ),
        
        fluidRow(style='margin: 0px;',
          
          column(6,
                 tableOutput("calnum")
                 
          ),
          column(6,
                 tableOutput("samplenum2")
          )
        )
        ,
        
        fluidRow(style='margin: 0px;',
          column(6,
                 tableOutput("caltables")
          ),
          column(6,
                 tableOutput("sampletables")
          )
        )
        ,
        hr(),
        
       
          
        
        conditionalPanel(

          condition="input.go >= 1",

          h2("Model Results",style = "color:steelblue"),
          tableOutput("preresult")
          ),

          
           
           uiOutput("muest"),
          
          
          uiOutput("plots"),
                 uiOutput("out1"),
          
        
         # downloadButton("report", "Generate PDF report"),
         
       
          plotOutput("mu_post_plot", width = "auto", height = "600px"),
         # downloadButton('download_mu_post_plot', 'Download plot'),
          
          br(),
          br(),
          
          
          plotOutput("mu_trace_plot", width = "auto", height = "600px"),
         # downloadButton('download_mu_trace_plot', 'Download plot')
          
          ),
      
      
        
      "Design of Experiment",
      
      tabPanel(
        h4("Background"),
        em(h3("Background for Design of Experiment ", style = "color:steelblue")),
        br(),
       
     
        h4("Here is an example of the two plates with the 96-plate experiment having 3 replicates of each test chemical and negative control."),
        br(),
        img(src='Background_IMG1.png', align = "center", height = 400, width = 700),
        br(),
        h4(" The Design of Experiment algorithm is based on the smallest limit of detection for a single test 
           chemical or a minimum of the maximum limit of detection for up to four different test chemicals.
           The limit of detection is calculated as"),
        img(src='Background_IMG2.png', align = "center", height = 150, width = 550),
        h4("The input quantities are:"),
        img(src='Background_IMG3.png', align = "center", height = 180, width = 580),
        br(),
        h4("  Also, to be specified is the number of wells already in use."),
        h4("  Results (using the Optimal design for single TC):"),
        h4(" This module calculates the optimal allocation for a negative control and a single test chemical.  Using the 2nd test chemical in the Background 
           Pre-Experiment data set with 8 wells already in use the Data entry and results screen shot is:  "),
        img(src='Background_IMG4.png', align = "center", height = 600, width = 800),
        br(),
        h4("  The output gives the total number of wells used totn, the limit of detection optdif,
           the optimal negative control allocation optNC, and the optimal test chemical allocation optTC. "),
       
        
        h4("  Here the results are that given totn = 16 wells (24 - 8) the limit of detection is 0.025 with 7 wells for the negative 
           control and 9 wells for the test chemical.  "),
        
        h4("In some cases, where the totn can be further subdivided, results are also given for other values of totn. 
        Here we get results for totn = 8 and totn = 4. This shows the effect of sample size on the design and the limit of detection.
        So, cutting the totn in half leads to an increase in the limit of detection to 0.04, cutting further leads to 0.084. 
        This is an estimate of the number of separate experiments (different negative control and test chemical) 
        with the same size uncertainties that could be fit onto the 24 well plate. 
        For example, if limit of detection of 0.04 was satisfactory we could fit two separate experiments on the 24-well plate.")
       
      ),
      tabPanel(
        h4("Data entry"),
        
        fluidRow(style='margin: 0px;',
                 column(12,
                        wellPanel(
                          h3(strong("Optimal designs of modules",style = "color:seagreen")),
                          
                          radioButtons("doeoption",
                                       label=NULL,
                                       choices=list(
                                         "Optimal design for Single TC"=1,
                                         "Optimal design with multiple TCs"=2),
                                       inline = T
                          )
                        ))
                 
        ),
        uiOutput("doeoption1"),
        
       
        
        mainPanel( 
          fluidRow(style='margin: 0px;',
                   actionButton("enter","Run the model", 
                                style="color: #fff; background-color: #337ab7; border-color: #2e6da4", width = '30%')
          ),
          fluidRow(style='margin: 0px;',
                   
                   helpText("Please check your data first and then run the model")
                   
          )),
        
        br(),
        
        conditionalPanel(
          
          # id="results",
          condition="input.enter >= 1",
          
          
          
          fluidRow(style='margin: 0px;',
                   column(12,
                          withSpinner(uiOutput("doeenter"), type = 8,color = "seagreen"),
                          
                          uiOutput("totnerr") ,
                    
                          uiOutput("outmul")             
                          
                         # uiOutput("doeoutput")

            )
         )
          
        )
      
        )
    
        )
    )
      
)
   
      
      


