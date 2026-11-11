library(openxlsx)
library(readr)
library(here)
library(xfun)

#source(paste0(here(), "/data-processing/data_processing.R"))
source(paste0(here(), "/data-processing/styles.R"))
source(paste0(here(), "/data-processing/new_worksheet.R"))

# Most recent financial year
fin_yr <- latest_year


# Formula calculates first_yr value
first_yr <- min(df_raw_data$Year)

wb_filename <- paste0(here(), "/data-processing/dashboard_tables_", fin_yr, ".xlsx")

wb <- createWorkbook(creator = "ELMS",
                     title = "Spending tables")

# set basic formatting
modifyBaseFont(wb, fontSize = 12, fontName = "Arial")

# Cover Sheet ####
addWorksheet(wb, sheetName = "Cover sheet")

# add info for cover sheet

cover_info <- c(paste("NI Executive spending in Northern Ireland", first_yr, "to", fin_yr),
                "The following tables show public spending statistics for Northern Ireland",
                "Issued by",
                "ELMS",
                "Colby House",
                "Belfast",
                "Published",
                pub_date,
                "Email",
                "PLACEHOLDER EMAIL")

# write text to worksheet
writeData(wb, sheet = "Cover sheet",
          x = cover_info,
          startRow = 1,
          colNames = FALSE)

# email hyperlink and link text
email <- "mailto:economicstats@nisra.gov.uk" 
names(email) <- "economicstats@nisra.gov.uk"
class(email) <- "hyperlink"

# # overwrite PLACEHOLDER with hyperlink and link text
writeData(wb, sheet = "Cover sheet",
          x = email,
          startRow = which(cover_info == "PLACEHOLDER EMAIL"),
          colNames = FALSE)

# style headings etc
addStyle(wb, sheet = "Cover sheet",
         style = pt, rows = 1, cols = 1)

addStyle(wb, sheet = "Cover sheet",
         style = pt2, rows = which(cover_info %in% c("Issued by", "Published", "Email")), cols = 1)

addStyle(wb, sheet = "Cover sheet",
         style = tw, rows = 2, cols = 1)

setRowHeights(wb, sheet = "Cover sheet", rows = which(cover_info %in% c("Issued by", "Published", "Email")), heights = 22)
setColWidths(wb, sheet = "Cover sheet", cols = 1, widths = 150)


# Add contents page ####
addWorksheet(wb, "Contents")

contents <- data.frame(sheet = character(),
                       num = character(),
                       name = character(),
                       link = character())

# Table 1 ####
Table_1 <- data.frame(`Key Statistics` = c("Total NI Executive spend",
                                "Total NI Executive spend per person",
                                "NI Executive spend on public services and investment (DEL)",
                                "NI Executive spend on public services and investment (DEL) per person",
                                "NI Executive spend on benefits and pensions (AME)",
                                "NI Executive spend on benefits and pensions (AME) per person"),
                      `Rounded Value (£)` = c(data_list$overall$spend,
                                             data_list$overall$spend_pp, 
                                             data_list$del$spend, 
                                             data_list$del$spend_pp,
                                             data_list$ame$spend, 
                                             data_list$ame$spend_pp),
                      `Unrounded value (£000s)` = c(df_raw_data %>% 
                                                      subset(Year == latest_year & `Covid Related` == "Includes Covid") %>% 
                                                      summarise(total_spend_millions = sum(total_spend_millions)*1000)   %>% pull(),
                                                    NA,
                                                    df_raw_data %>% 
                                                      subset(Year == latest_year & `Covid Related` == "Includes Covid" & `Budget Boundary` != "AME") %>% 
                                                      summarise(total_spend_millions = sum(total_spend_millions) * 1000 ) %>% pull(),
                                                    NA,
                                                    df_raw_data %>% 
                                                      subset(Year == latest_year & `Covid Related` == "Includes Covid" & `Budget Boundary` == "AME") %>% 
                                                      summarise(total_spend_millions = sum(total_spend_millions) * 1000) %>%  pull(),
                                                    NA
                      ))

data_list$overall$population

names(Table_1)[1] <- paste("Key Statistics", fin_yr)
names(Table_1)[2] <- "Rounded Value (£)"
names(Table_1)[3] <- "Unrounded value (£000s)"

new_worksheet(table = Table_1,
              title = paste("Table 1: Key statistics", fin_yr),
              widths = c(62, 20, 20),
              notes = c("The 2025-26 data is based on provisional outturn data. All previous years are based on final outturn data",
                        #All years are based on final outturn data
                "The rounded value is presented in the NI Executive Spending dashboard",
                        paste("Per person estimates based on", substr(fin_yr, 1, 4), "mid-year population estimate of", prettyNum(as.numeric(gsub("\\D", "", data_list$overall$population)), big.mark = ",")),
                        "Some cells are intentionally blank (unrounded values per person)",
                        "This table excludes ringfenced RDEL, RAME depreciation and impairments and Other AME Capital (which contains gross Public Corporations capital expenditure)."))

# Table 2 ####
Table_2a <- df_time_trend %>%
  mutate(total_spend_millions = total_spend_millions ) %>%
  rename(`Total Spend (£ million)` = total_spend_millions,
         `Mid-year population estimate` = population,
         `Spend per person (£)` = pounds_per_person) %>%
  left_join(df_dept_timetrend %>%
              mutate(del_ame = case_when(dept_grouped == "AME" ~ "AME",
                                         TRUE ~ "DEL")) %>%
              group_by(Year, del_ame) %>%
              summarise(total_spend = sum(total_spend_millions )) %>%
              pivot_wider(names_from = del_ame,
                          names_glue = "Public services and investment ({del_ame}) total spend (£ million)",
                          values_from = total_spend),
            by = "Year") %>%
  mutate(`Public services and investment (DEL) spend per person (£)` = round(`Public services and investment (DEL) total spend (£ million)` * 1000000 / `Mid-year population estimate` / 100) * 100,
         `Public services and investment (AME) spend per person (£)` = round(`Public services and investment (AME) total spend (£ million)` * 1000000 / `Mid-year population estimate` / 100) * 100,
         `Mid-year population estimate` = round(`Mid-year population estimate` / 1000) * 1000)  %>%
  rename("Pensions and benefits (AME) total spend (£ million)"="Public services and investment (AME) total spend (£ million)", 
         "Pensions and benefits (AME) spend per person (£)" = "Public services and investment (AME) spend per person (£)") %>%
  select("Year", "Total Spend (£ million)", "Mid-year population estimate", "Spend per person (£)",                   
         "Public services and investment (DEL) total spend (£ million)", "Public services and investment (DEL) spend per person (£)",
         "Pensions and benefits (AME) total spend (£ million)", "Pensions and benefits (AME) spend per person (£)")


Table_2b = Table_2a %>% select("Year", "Total Spend (£ million)",                    
                               "Public services and investment (DEL) total spend (£ million)",
                               "Pensions and benefits (AME) total spend (£ million)") %>% 
                        mutate("Total Spend (£000s)" = `Total Spend (£ million)` * 1000,                    
                               "Public services and investment (DEL) total spend (£000s)" = `Public services and investment (DEL) total spend (£ million)` * 1000,
                               "Pensions and benefits (AME) total spend (£000s)" =  `Pensions and benefits (AME) total spend (£ million)` * 1000) %>% 
                        select("Year", "Total Spend (£000s)",                    
                                 "Public services and investment (DEL) total spend (£000s)",
                                 "Pensions and benefits (AME) total spend (£000s)") 

Table_2 = list("Table_2a" = Table_2a, "Table_2b" = Table_2b)

new_worksheet(table = Table_2,
              title = paste("Table 2: Key statistics", first_yr, "to", fin_yr),
              widths = c(11, rep(14, 7)),
              notes = c("The 2025-26 data is based on provisional outturn data. All previous years are based on final outturn data",
                        #"All years are based on final outturn data",
                        "The figures in table 2a have been rounded, as presented in the NI Executive Spending dashboard",
              "This table excludes ringfenced RDEL, RAME depreciation and impairments and Other AME Capital (which contains gross Public Corporations capital expenditure)."))

# Table 3 ####
Table_3 <- df_data_for_spreadsheet %>%
  mutate(uos_cleaned = as.character(uos_cleaned), money_1000s = money * 1000) %>%
  arrange(Year, dept_grouped, uos_cleaned)

names(Table_3) <- c("Department", "Spending Area", "Year", "Spend (£millions)",  "Spend (£000s)" )


new_worksheet(table = Table_3,
              title = paste("Table 3: Data used in dashboard"),
              widths = c(10, 50, 10, 10),
              notes = c("The 2025-26 data is based on provisional outturn data. All previous years are based on final outturn data",
                        #"All years are based on final outturn data",
                        "This table excludes ringfenced RDEL, RAME depreciation and impairments and Other AME Capital (which contains gross Public Corporations capital expenditure)."))

# Table 4 ####
Table_4 <- df_data_for_spreadsheet_detailed %>%
  mutate(uos_cleaned = as.character(uos_cleaned), money_1000s = money * 1000) %>%
  arrange(Year, dept_grouped, uos_cleaned, Category)

names(Table_4) <- c("Department", "Spending Area", "Expenditure Category", "Year", "Spend (£millions)",  "Spend (£000s)" )

new_worksheet(table = Table_4,
              title = paste("Table 4: More detailed data"),
              widths = c(10, 50, 25, 10, 10, 10),
              notes = c("The 2025-26 data is based on provisional outturn data. All previous years are based on final outturn data",
                        #"All years are based on final outturn data",
                        "Please see notes worksheet for explanation of these expenditure categories",
                        "This table excludes ringfenced RDEL, RAME depreciation and impairments and Other AME Capital (which contains gross Public Corporations capital expenditure)."))
                      

# Notes page ####

addWorksheet(wb, "Notes")

contents <- rbind(contents,
                  data.frame(sheet = "Notes",
                             num = "Notes",
                             name = "Notes table",
                             link = "A2"))

writeData(wb, "Notes",
          "Notes and Definitions")

addStyle(wb, "Notes", style = pt, rows = 1, cols = 1)

notes <- data.frame(Item = c("Data",
                            "Spending areas",
                            "AME D/I",
                            "Other AME Capital",
                            "Ringfenced Resource DEL"),
                    Note = c(paste("The 2025-26 data is based on provisional outturn data. All previous years are based on final outturn data. This is compiled from DEL & AME Departmental Outturns as provided by Departments to Public Spending Directorate (PSD).",
                                  # paste("The data in this download is compiled from DEL & AME Departmental Final Outturn", first_yr, "to", fin_yr, "as provided by Departments to Public Spending Directorate (PSD)."),
                             "Spending Areas have been re-organised and renamed through time. Therefore spending areas will not be directly comparable over time.",
                             "Expenditure Category ''AME D/I'' relates to AME Depreciation / Impairments.",
                             "Expenditure Category ''Other AME Capital'' relates to AME capital expenditure by Public Corporations.",
                             "Expenditure Category ''Ringfenced Resource DEL'' relates to DEL Depreciation / Impairments.")))

names(notes)[2] <- "Further information"

addStyle(wb, "Notes", style = tw, rows = 3:(nrow(notes) + 3), cols = 2)

writeDataTable(wb, "Notes",
               notes,
               startRow = 2,
               colNames = TRUE,
               tableStyle = "none",
               tableName = "notes",
               withFilter = FALSE,
               bandedRows = FALSE,
               headerStyle = h3)

setColWidths(wb, "Notes", cols = 1:3, widths = c(25, 100))

#### Generate contents page ####
names(contents) <- c("Worksheet name", "Table number", "Table name", "Link")

writeData(wb, "Contents",
          "Table of contents")

addStyle(wb, "Contents", style = pt, rows = 1, cols = 1)
addStyle(wb, "Contents", style = tw, rows = 3:(nrow(contents) + 3), cols = 3)

writeDataTable(wb, "Contents",
               contents[1:3],
               startRow = 2,
               colNames = TRUE,
               tableStyle = "none",
               tableName = "Table_of_contents",
               withFilter = FALSE,
               bandedRows = FALSE,
               headerStyle = h3)

for (i in 1:nrow(contents)) {
  writeFormula(wb, "Contents",
               x = paste0('HYPERLINK("#', gsub(" ", "_", contents$`Worksheet name`[i]), '!',
                          contents$Link[i],
                          '", "', contents$`Table number`[i], '")'),
               startCol = 2, startRow = i + 2)
}

setColWidths(wb, "Contents", cols = 1:3, widths = c(20, 15, 39))

saveWorkbook(wb, wb_filename, overwrite = TRUE)

#openXL(wb_filename)

# Embed file in html ####

base64_string <- base64_encode(wb_filename)

html_files <- list.files(here(), pattern = "*.html")

for (file in html_files) {
  
  
  suppressWarnings({
    raw_html <- readLines(paste0(here(), "/", file))  
  })
  
  link_line <- which(grepl("Download data", raw_html))
  
  fixed_html <- raw_html
  
  fixed_html[link_line] <- paste0(paste(rep(" ", 12), collapse = ""), '<button class="btn btn-primary" type="button">',
                                  '<a download = "', basename(wb_filename), '" ',
                                  'href="data:application/vnd.openxmlformats-officedocument.spreadsheetml.sheet;base64,',
                                  base64_string,
                                  '">Download data (.xlsx, ',
                                  round(file.size(wb_filename) / 1024),
                                  'KB)</a></button>')
  
  writeLines(fixed_html, paste0(here(), "/", file))
  
}



