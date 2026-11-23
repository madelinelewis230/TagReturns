library(shiny)
library(bslib)

custom_css <- "
  html {
    scroll-behavior: smooth;
  }
  body {
    background-color: #ffffff;
    /* Adds space at the bottom so content isn't covered by the fixed bottom banner */
    padding-bottom: 85px; 
  }
  .hazard-stripe {
    height: 18px;
    background: repeating-linear-gradient(
      -45deg,
      #FFC72C,
      #FFC72C 15px,
      #111111 15px,
      #111111 30px
    );
    width: 100%;
  }
  .hero-banner {
    background-color: #FFFFFF;
    color: #111111;
    padding: 1.75rem 1.5rem;
    text-align: center;
  }
  .hero-reward {
    color: #111111;
    background-color: #FFC72C;
    display: inline-block;
    padding: 0.2rem 1.25rem;
    border-radius: 6px;
    font-weight: 900;
    font-size: 2.5rem;
    letter-spacing: 1px;
    margin-top: 0.25rem;
  }
  /* Subtle sticky top jump-bar for single-page navigation */
  .jump-nav {
    position: sticky;
    top: 0;
    z-index: 1020;
    background-color: #f8f9fa;
    border-bottom: 1px solid #dee2e6;
    padding: 0.6rem 0;
  }
  .jump-nav a {
    color: #111111;
    font-weight: 700;
    text-decoration: none;
    margin: 0 1rem;
    padding: 0.35rem 0.75rem;
    border-radius: 4px;
    transition: background-color 0.2s;
  }
  .jump-nav a:hover {
    background-color: #FFC72C;
  }
  /* Offsets anchor scrolling so sticky jump-nav doesn't cover section titles */
  .page-section {
    scroll-margin-top: 65px;
    padding-top: 2rem;
    padding-bottom: 2rem;
  }
  .tag-instruction-card {
    border-left: 6px solid #FFC72C;
    background-color: #f8f9fa;
  }
  .diagram-placeholder {
    border: 2px dashed #adb5bd;
    border-radius: 8px;
    background-color: #f8f9fa;
    min-height: 380px;
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    text-align: center;
    padding: 2rem;
    color: #495057;
  }
  /* Fixed footer locked to the bottom of the browser window at all times */
  .fixed-bottom-banner {
    position: fixed;
    left: 0;
    bottom: 0;
    width: 100%;
    z-index: 1050;
    background-color: #FFFFFF;
    color: #111111;
    box-shadow: 0 -3px 10px rgba(0, 0, 0, 0.12);
  }
  .fixed-bottom-banner a {
    color: #b38000;
    font-weight: 600;
    text-decoration: none;
  }
  .fixed-bottom-banner a:hover {
    text-decoration: underline;
  }
"

ui <- page_fluid(
  theme = bs_theme(
    version = 5,
    bootswatch = "flatly",
    primary = "#111111",
    secondary = "#FFC72C",
   # base_font = font_google("Inter"),
    #heading_font = font_google("Oswald")
  ),
  class = "p-0",
  tags$head(tags$style(HTML(custom_css))),
  
  # -------------------------------------------------------------------------
  # TOP HAZARD BANNER & HEADER
  # -------------------------------------------------------------------------
  div(class = "hazard-stripe"),
  div(
    class = "hero-banner",
    h1("ATTENTION ANGLERS", class = "display-5 fw-bold mb-0"),
    div(class = "hero-reward", "$100 REWARD"),
    p(
      class = "lead mt-2 mb-0 fw-semibold",
      "For the return of select tags on Hybrid Striped Bass and Paddlefish caught in or below Rathbun Lake."
    )
  ),
  div(class = "hazard-stripe"),
  
  # Sticky Quick-Jump Bar
  div(
    class = "jump-nav text-center",
    tags$a(href = "#tag-info", icon("fish"), " Tag Identification & Reporting"),
    tags$a(href = "#faq-section", icon("question-circle"), " Frequently Asked Questions"),
    tags$a(href = "#history-section", icon("book-open"), " History of the Project")
  ),
  
  # -------------------------------------------------------------------------
  # MAIN SINGLE-PAGE CONTENT CONTAINER
  # -------------------------------------------------------------------------
  div(
    class = "container",
    
    # =======================================================================
    # SECTION 1: TAG INFORMATION & DIAGRAM PLACEHOLDER
    # =======================================================================
    div(
      id = "tag-info",
      class = "page-section",
      layout_columns(
        col_widths = c(5, 7),
        
        # Left Column: Sign Instructions & Contact Info
        div(
          card(
            class = "tag-instruction-card mb-3",
            card_header(h4("How to Claim Your $100 Reward", class = "mb-0 fw-bold")),
            card_body(
              p(
                strong("If harvested:"),
                " You must physically return the ",
                span("large internal acoustic tag", style = "color: #d9534f; font-weight: bold;"),
                " (located inside the belly cavity, circled in orange on the diagram). For drop-off locations or mail-in instructions, please use the contact information below."
              ),
              p(
                strong("If released:"),
                " Leave all tags attached! Provide a clear photo of the fish with the external tags visible, and report the ID numbers printed on the tags."
              ),
              hr(),
              h5("Eligible External Tags to Look For:", class = "fw-bold"),
              tags$ul(
                class = "mb-0",
                tags$li(strong("Hybrid Striped Bass:"), " Yellow dorsal external tag (near top fin), yellow belly external tag, and/or a metal jaw tag."),
                tags$li(strong("Paddlefish:"), " Yellow belly external tag.")
              )
            )
          ),
          
          card(
            card_header(h4("How to Report a Tagged Fish", class = "mb-0 fw-bold")),
            card_body(
              p(icon("phone"), strong(" Call Iowa DNR:"), " (641)-647-2406"),
              p(icon("envelope"), strong(" Email:"), " fishtags@iastate.edu"),
              p(class = "mb-0", icon("globe"), strong(" Visit:"), " https://tagreturns.nrem.iastate.edu/")
            )
          )
        ),
        
        # Right Column: Fish Tag Diagram
        card(
          card_header(h4("Eligible Fish & Tag Locations", class = "mb-0 fw-bold")),
          card_body(
           # tags$img(
            #  src = "TD.png", # Must match your exact filename & extension (.png or .jpg)
             # class = "img-fluid rounded mx-auto d-block",
             # alt = "Hybrid Striped Bass and Paddlefish Tag Diagram"
            #)
          )
        )
      )
    ),
    
    hr(class = "my-2"),
    
    # =======================================================================
    # SECTION 2: FREQUENTLY ASKED QUESTIONS (FAQ)
    # =======================================================================
    div(
      id = "faq-section",
      class = "page-section",
      h2("Frequently Asked Questions", class = "fw-bold mb-2"),
      
      accordion(
        id = "faq_accordion",
        open = c("faq1"),
        
        accordion_panel(
          value = "faq1",
          title = "What if I catch a fish with a different type of tag? Or a fish with an internal tag only?",
          p("If you catch a fish with a different type of tag, or a fish with an internal tag only, please retain the tag and contact us. We will assess the eligibility for reward on a case-by-case basis.")
        ),
        
        accordion_panel(
          value = "faq2",
          title = "What do I do if I catch a tagged fish and want to release it?",
          p("Please do NOT cut or pull out the external yellow tags or jaw tag if you are releasing the fish. Simply take a clear photograph showing the fish and the external tag(s), write down the ID number printed on the tag, and contact us via email at fishtags@iastate.edu or call (641)-647-2406.")
        ),
        
        accordion_panel(
          value = "faq3",
          title = "What if I harvest the fish? How do I return the internal tag?",
          p("If you harvest a tagged Hybrid Striped Bass or Paddlefish, remove the black cylindrical internal transmitter from the body cavity when cleaning the fish (circled in orange on the diagram). Call the Iowa DNR at (641)-647-2406 or email fishtags@iastate.edu to arrange drop-off or mail return so we can process your $100 reward.")
        ),
        
        accordion_panel(
          value = "faq5",
          title = "How long does it take to receive my $100 reward?",
          p("Once your photo (for released fish) or physical internal transmitter (for harvested fish) is received, reward checks are typically processed and mailed within 3 to 4 weeks.")
        ),
        
        accordion_panel(
          value = "faq6",
          title = "What other information do you need about the fish?",
          p("We will send you a basic questionnaire that will request the following information: Date of catch, approximate location, species targeted, length (optional), weight (optional), total fish caught, hours fished, number of anglers in group.")
        )
      )
    ),
    
    hr(class = "my-2"),
    
    # =======================================================================
    # SECTION 3: PROJECT BACKGROUND & RESEARCH GOALS
    # =======================================================================
    div(
      id = "history-section",
      class = "page-section",
      h2("Project Information", class = "fw-bold mb-3"),
      
      layout_columns(
        col_widths = c(11, 1),
        
        div(
          h4("Collaborative Fisheries Research", class = "fw-bold mt-2"),
          p("This telemetry and tagging initiative is a joint partnership between the ", strong("Iowa Department of Natural Resources (Iowa DNR)"), " and the ", strong("Department of Natural Resource Ecology and Management (NREM) at Iowa State University"), "."),
          p("Hybrid Striped Bass (Wipers) and Paddlefish are two important sportfish in Iowa. This project aims to better understand the movement and habitat use of both species, as well as their natural mortality and harvest rates. All of this information will be used to develop management plans to maintain these fisheries in a sustainable manner.")
        )
        
       
      )
    )
  ),
  
  # -------------------------------------------------------------------------
  # FIXED BOTTOM BANNER (ALWAYS FOLLOWS SCROLL)
  # -------------------------------------------------------------------------
  div(
    class = "fixed-bottom-banner",
    div(
      class = "container py-2 text-center",
      p(
        class = "mb-0 small",
        strong("Iowa State University NREM & Iowa DNR"),
        "  |  Call: ", strong("(641)-647-2406"),
        "  |  Email: ", tags$a(href = "mailto:fishtags@iastate.edu", "fishtags@iastate.edu")
      )
    ),
    div(class = "hazard-stripe")
  )
)

shinyApp(ui, server)

