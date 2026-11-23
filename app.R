library(shiny)

custom_css <- "
  @import url('https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&family=Oswald:wght@700&display=swap');

  html {
    scroll-behavior: smooth;
    font-size: 18px; /* Scales up all rem-based sizing across the whole page */
  }
  body {
    background-color: #ffffff;
    font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
    font-size: 1.05rem;
    line-height: 1.6;
    color: #212529;
    padding-bottom: 95px;
    margin: 0;
  }
  h1, h2, h3, h4, h5 {
    font-family: 'Oswald', Impact, 'Arial Narrow', sans-serif;
    letter-spacing: 0.5px;
  }
  .container-fluid {
    padding-left: 0 !important;
    padding-right: 0 !important;
  }
  /* Expands the main content container to fill wide desktop screens nicely */
  .main-content-container {
    width: 92%;
    max-width: 1550px;
    margin: 0 auto;
    padding: 0 15px;
  }
  .hazard-stripe {
    height: 22px;
    background: repeating-linear-gradient(
      -45deg,
      #FFC72C,
      #FFC72C 18px,
      #111111 18px,
      #111111 36px
    );
    width: 100%;
  }
  .hero-banner {
    background-color: #FFFFFF;
    color: #111111;
    padding: 2rem 1.5rem;
    text-align: center;
  }
  .hero-title {
    font-size: 3.5rem;
    font-weight: 700;
    margin-bottom: 0;
    line-height: 1.1;
  }
  .hero-reward {
    color: #111111;
    background-color: #FFC72C;
    display: inline-block;
    padding: 0.25rem 1.5rem;
    border-radius: 6px;
    font-weight: 900;
    font-size: 3rem;
    letter-spacing: 1px;
    margin-top: 0.35rem;
  }
  .hero-subtitle {
    font-size: 1.35rem;
    font-weight: 600;
    margin-top: 0.75rem;
    margin-bottom: 0;
  }
  /* Subtle sticky top jump-bar for single-page navigation */
  .jump-nav {
    position: sticky;
    top: 0;
    z-index: 1020;
    background-color: #f8f9fa;
    border-bottom: 1px solid #dee2e6;
    padding: 0.75rem 0;
    font-size: 1.05rem;
  }
  .jump-nav a {
    color: #111111;
    font-weight: 700;
    text-decoration: none;
    margin: 0 1.25rem;
    padding: 0.45rem 0.9rem;
    border-radius: 4px;
    transition: background-color 0.2s;
    display: inline-block;
  }
  .jump-nav a:hover {
    background-color: #FFC72C;
  }
  /* Offsets anchor scrolling so sticky jump-nav doesn't cover section titles */
  .page-section {
    scroll-margin-top: 75px;
    padding-top: 2.25rem;
    padding-bottom: 2.25rem;
  }
  .custom-card {
    border: 1px solid #dee2e6;
    border-radius: 8px;
    background-color: #ffffff;
    box-shadow: 0 2px 8px rgba(0,0,0,0.06);
    margin-bottom: 1.5rem;
    overflow: hidden;
  }
  .custom-card-header {
    background-color: #f1f3f5;
    border-bottom: 1px solid #dee2e6;
    padding: 1rem 1.5rem;
  }
  .custom-card-header h4 {
    font-size: 1.5rem;
    margin: 0;
    font-weight: 700;
  }
  .custom-card-body {
    padding: 1.5rem;
    font-size: 1.05rem;
  }
  .custom-card-body h5 {
    font-size: 1.25rem;
    font-weight: 700;
  }
  .custom-card-body li {
    margin-bottom: 0.4rem;
  }
  .tag-instruction-card {
    border-left: 7px solid #FFC72C;
    background-color: #f8f9fa;
  }
  /* Clean native collapsible FAQ styling */
  details.faq-item {
    border: 1px solid #dee2e6;
    border-radius: 6px;
    margin-bottom: 0.9rem;
    background-color: #ffffff;
    overflow: hidden;
  }
  details.faq-item summary {
    padding: 1.15rem 1.5rem;
    font-size: 1.15rem;
    font-weight: 700;
    cursor: pointer;
    background-color: #f8f9fa;
    list-style: none;
    display: flex;
    justify-content: space-between;
    align-items: center;
  }
  details.faq-item summary::-webkit-details-marker {
    display: none;
  }
  details.faq-item summary::after {
    content: '+';
    font-size: 1.5rem;
    font-weight: 700;
    color: #111111;
  }
  details.faq-item[open] summary::after {
    content: '−';
  }
  details.faq-item[open] summary {
    background-color: #fff8e1;
    border-bottom: 1px solid #dee2e6;
  }
  .faq-answer {
    padding: 1.25rem 1.5rem;
    margin: 0;
    font-size: 1.05rem;
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
  .fixed-bottom-banner p {
    margin-bottom: 0;
    font-size: 1rem;
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

ui <- fluidPage(
  tags$head(
    tags$title("Rathbun Lake Fish Tag Reward"),
    tags$style(HTML(custom_css))
  ),
  
  # -------------------------------------------------------------------------
  # TOP HAZARD BANNER & HEADER
  # -------------------------------------------------------------------------
  div(class = "hazard-stripe"),
  div(
    class = "hero-banner",
    h1("ATTENTION ANGLERS", class = "hero-title"),
    div(class = "hero-reward", "$100 REWARD"),
    p(
      class = "hero-subtitle",
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
    class = "main-content-container",
    
    # =======================================================================
    # SECTION 1: TAG INFORMATION & DIAGRAM
    # =======================================================================
    div(
      id = "tag-info",
      class = "page-section",
      fluidRow(
        # Left Column (5 cols): Sign Instructions & Contact Info
        column(
          width = 5,
          div(
            class = "custom-card tag-instruction-card",
            div(class = "custom-card-header", h4("How to Claim Your $100 Reward")),
            div(
              class = "custom-card-body",
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
              h5("Eligible External Tags to Look For:"),
              tags$ul(
                style = "margin-bottom: 0;",
                tags$li(strong("Hybrid Striped Bass:"), " Yellow dorsal external tag (near top fin), yellow belly external tag, and/or a metal jaw tag."),
                tags$li(strong("Paddlefish:"), " Yellow belly external tag.")
              )
            )
          ),
          
          div(
            class = "custom-card",
            div(class = "custom-card-header", h4("How to Report a Tagged Fish")),
            div(
              class = "custom-card-body",
              p(icon("phone"), strong(" Call Iowa DNR:"), " (641)-647-2406"),
              p(icon("envelope"), strong(" Email:"), " fishtags@iastate.edu"),
              p(style = "margin-bottom: 0;", icon("globe"), strong(" Visit:"), " https://tagreturns.nrem.iastate.edu/")
            )
          )
        ),
        
        # Right Column (7 cols): Fish Tag Diagram
        column(
          width = 7,
          div(
            class = "custom-card",
            div(class = "custom-card-header", h4("Eligible Fish & Tag Locations")),
            div(
              class = "custom-card-body text-center",
              tags$img(
                src = "TD.png",
                class = "img-responsive center-block",
                style = "width: 100%; max-width: 850px; height: auto; border-radius: 6px; margin: 0 auto;",
                alt = "Hybrid Striped Bass and Paddlefish Tag Diagram"
              )
            )
          )
        )
      )
    ),
    
    hr(),
    
    # =======================================================================
    # SECTION 2: FREQUENTLY ASKED QUESTIONS (FAQ)
    # =======================================================================
    div(
      id = "faq-section",
      class = "page-section",
      h2("Frequently Asked Questions", style = "font-size: 2.25rem; font-weight: 700; margin-bottom: 1.25rem;"),
      
      tags$details(
        class = "faq-item",
        open = "open",
        tags$summary("What if I catch a fish with a different type of tag? Or a fish with an internal tag only?"),
        p(class = "faq-answer", "If you catch a fish with a different type of tag, or a fish with an internal tag only, please retain the tag and contact us. We will assess the eligibility for reward on a case-by-case basis.")
      ),
      
      tags$details(
        class = "faq-item",
        tags$summary("What do I do if I catch a tagged fish and want to release it?"),
        p(class = "faq-answer", "Please do NOT cut or pull out the external yellow tags or jaw tag if you are releasing the fish. Simply take a clear photograph showing the fish and the external tag(s), write down the ID number printed on the tag, and contact us via email at fishtags@iastate.edu or call (641)-647-2406.")
      ),
      
      tags$details(
        class = "faq-item",
        tags$summary("What if I harvest the fish? How do I return the internal tag?"),
        p(class = "faq-answer", "If you harvest a tagged Hybrid Striped Bass or Paddlefish, remove the black cylindrical internal transmitter from the body cavity when cleaning the fish (circled in orange on the diagram). Call the Iowa DNR at (641)-647-2406 or email fishtags@iastate.edu to arrange drop-off or mail return so we can process your $100 reward.")
      ),
      
      tags$details(
        class = "faq-item",
        tags$summary("How long does it take to receive my $100 reward?"),
        p(class = "faq-answer", "Once your photo (for released fish) or physical internal transmitter (for harvested fish) is received, reward checks are typically processed and mailed within 3 to 4 weeks.")
      ),
      
      tags$details(
        class = "faq-item",
        tags$summary("What other information do you need about the fish?"),
        p(class = "faq-answer", "We will send you a basic questionnaire that will request the following information: Date of catch, approximate location, species targeted, length (optional), weight (optional), total fish caught, hours fished, number of anglers in group.")
      )
    ),
    
    hr(),
    
    # =======================================================================
    # SECTION 3: PROJECT BACKGROUND & RESEARCH GOALS
    # =======================================================================
    div(
      id = "history-section",
      class = "page-section",
      h2("Project Information", style = "font-size: 2.25rem; font-weight: 700; margin-bottom: 1rem;"),
      fluidRow(
        column(
          width = 11,
          h4("Collaborative Fisheries Research", style = "font-size: 1.5rem; font-weight: 700; margin-top: 0.5rem;"),
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
      class = "main-content-container text-center",
      style = "padding-top: 0.6rem; padding-bottom: 0.6rem;",
      p(
        strong("Iowa State University NREM & Iowa DNR"),
        "  |  Call: ", strong("(641)-647-2406"),
        "  |  Email: ", tags$a(href = "mailto:fishtags@iastate.edu", "fishtags@iastate.edu")
      )
    ),
    div(class = "hazard-stripe")
  )
)

server <- function(input, output, session) {
}

shinyApp(ui = ui, server = server)
