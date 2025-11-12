# Original


#.......................................................................................................
# This is the basic of how it works
#.......................................................................................................

library(httr)
library(jsonlite)
library(dplyr)
library(stringr)

res <- GET("https://serpapi.com/search.json",
           query = list(
             engine = "google_jobs",
             q = "data",
             location = "London, England, United Kingdom",
            # start = 10,
             api_key = "2beb143e1c2807e15e8809e5aa88ab95a35f75f8511b9ade15f65ceb4c30021c"
           ))
jobs <- fromJSON(content(res, "text", encoding = "UTF-8"))

# get your base
base_1 <- jobs$jobs_results


#.......................................................................................................
# This is the above however in a function form
#.......................................................................................................

library(httr)
library(jsonlite)

fetch_jobs <- function(key_word = "") {
  # Make the API request
  res <- GET(
    url = "https://serpapi.com/search.json",
    query = list(
      engine   = "google_jobs",
      q        = key_word,
      location = "London, England, United Kingdom",
      api_key  = "b45f1da2b438f565dbf46717b1e21120c636fdbe01235f65917aacf8f346d30c"
    )
  )
  
  # Convert response to JSON
  jobs <- fromJSON(content(res, "text", encoding = "UTF-8"))
  
  # Extract job results
  base <- jobs$jobs_results
  
  return(base)
}

# Example usage:
base_1 <- fetch_jobs("data")
base_2 <- fetch_jobs("data science")
#base_3 <- fetch_jobs("infection")
base_4 <- fetch_jobs("outbreak")
base_5 <- fetch_jobs("epidemiology")
base_6 <- fetch_jobs("real")
base_7 <- fetch_jobs("world")
base_8 <- fetch_jobs("evidence")
base_9 <- fetch_jobs("real world evidence")
base_10 <- fetch_jobs("real-world-evidence")
base_11 <- fetch_jobs("Real World Evidence")
base_12 <- fetch_jobs("Epidemiology")










#.......................................................................................................
# This version is like the above however it loops the names so that you can put everything into keywords
#.......................................................................................................


library(dplyr)  # for bind_rows

keywords <- c(
  # Original keywords
  "data",
  "data science",
  "infection",
  "outbreak",
  "epidemiology",
  "real",
  "world",
  "evidence",
  "real world evidence",
  "real-world-evidence",
  "Real World Evidence",
  "Epidemiology",
  "Principal Epidemiologist",
  "Epidemiologist",
  "Senior Epidemiologist",
  
  # Added roles / seniority
  "Junior Epidemiologist",
  "Lead Epidemiologist",
  "Epidemiology Analyst",
  "Clinical Epidemiologist",
  "Public Health Scientist",
  "Data Analyst",
  "Biostatistician",
  "Health Economist",
  "Associate Epidemiologist",
  "Staff Epidemiologist",
  "Principal Scientist",
  "Senior Data Scientist",
  "Lead Biostatistician",
  "Clinical Outcomes Manager",
  "Public Health Advisor",
  "Epidemiology Manager",
  
  # Skills / keywords
  "Real World Evidence",
  "Clinical Trials",
  "Health Data",
  "Observational Studies",
  "Population Health",
  "Statistical Modeling",
  "SAS",
  "R",
  "Python",
  "Statistical Analysis",
  "Machine Learning",
  "SQL",
  "Tableau",
  "Health Economics",
  "Modelling & Simulation",
  "Data Visualization",
  "Real World Data",
  "Clinical Research",
  
  # Specializations / domains
  "Infectious Disease Epidemiologist",
  "Vaccine Epidemiologist",
  "Pharmacovigilance",
  "Health Outcomes Research",
  "Public Health Surveillance",
  "Medical Affairs",
  "Regulatory Affairs",
  "Oncology Epidemiologist",
  "Cardiovascular Epidemiologist",
  "Vaccine Safety Specialist",
  "Pharmacoeconomics",
  "Outcomes Research Scientist",
  "Real-World Evidence Scientist",
  "Patient-Reported Outcomes",
  
  # Broader related roles
  "Data Scientist",
  "Health Informatics Specialist",
  "Clinical Research Associate",
  "Outcomes Research Manager",
  "Biostatistics Manager",
  "Clinical Scientist",
  "Medical Statistician",
  "Health Data Scientist",
  "Epidemiology Consultant",
  "Health Outcomes Analyst"
)

all_jobs_list <- list()

for (k in keywords) {
  df <- fetch_jobs(k)
  if (!is.null(df) && nrow(df) > 0) {
    df$keyword <- k          # track which keyword produced this job
    rownames(df) <- NULL      # reset row names to avoid duplicates
    all_jobs_list[[k]] <- df
  }
}

# Combine all data frames safely
all_jobs_df <- bind_rows(all_jobs_list)

all_jobs_df <- all_jobs_df %>%
  mutate(key = paste0(title,company_name,location)) %>%
  distinct(key, .keep_all = TRUE)









