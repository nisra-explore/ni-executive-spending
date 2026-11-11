
## THIS CLEANS UP THE NEW YEAR INTO THE PREVIOUS FILE FORMAT FOR ADDING ON



library(dplyr)
library(readxl)
library(tidyr)
library (stringr)
library(writexl)


options(useFancyQuotes = FALSE)


## update parameters

data_filename = "G:/STATISTICIANS/Economic Accounts for NI/Public expenditure HTML/OCT 2026/2025-26 Provisional Outturn Data for NISRA.xlsx"

new_table_save_destination = "G:/STATISTICIANS/Economic Accounts for NI/Public expenditure HTML/OCT 2026/Provisional Outturn Data NISRA 2025-26 - R formatted.xlsx"


#### read in new data and process ####
df_raw_data = read_excel(data_filename, sheet = "Data")

#combine UOS
df_raw_data <- df_raw_data %>%
  mutate(UOS = str_c(UOSNAME, UOSDESCRIPTION, sep = " - "))

#combine UOB
df_raw_data <- df_raw_data %>%
  mutate(UOB = str_c(UOBNAME, UOBDESCRIPTION, sep = " - "))

#combine Record
df_raw_data <- df_raw_data %>%
  mutate(Record = str_c(RECORDNUMBER, STRUCTURALRECORDDESCRIPTION, sep = " - "))

#create new empty variable columns
df_raw_data <- df_raw_data %>%
  mutate('Economic Category' = "", 'Account Code' = "", 'Spending Authority' = "",
         'COFOG' = "", 'Managed Expenditure Group' = "")

#add year column - AMEND HERE
df_raw_data <- df_raw_data %>%
  mutate(`Year` = "2024-25") 

#add covid column
df_raw_data <- df_raw_data %>%
  mutate(`Covid Related` = "Includes Covid") 

#AUG 2025 - Start of 24/25 prov changes

#REMOVE ROWS WITH UOSDESCRIPTION 'Overcommitment' as these were 0 and don't fall into a particular area
df_raw_data <- df_raw_data %>%
  filter(UOSDESCRIPTION != "Overcommitment")

#REMOVE NON BUDGET ROWS
df_raw_data <- df_raw_data %>%
  filter(CATEGORYDESCRIPTION != "NON BUDGET")

#ADD NEW MUTATE VAR TO CREATE Category Description 2
df_raw_data <- df_raw_data %>%
  mutate(Category_Description_2 = case_when(
    CATEGORYDESCRIPTION == "AME CAPITAL"       ~ "AME Capital",
    CATEGORYDESCRIPTION == "AME ADM D/I"       ~ "AME D/I",
    CATEGORYDESCRIPTION == "AME RES D/I"       ~ "AME D/I",
    CATEGORYDESCRIPTION == "AME RESOURCE"      ~ "AME Resource",
    CATEGORYDESCRIPTION == "DEL CAPITAL"       ~ "Capital DEL",
    CATEGORYDESCRIPTION == "DEL FT CAPITAL"    ~ "FT Capital DEL",
    CATEGORYDESCRIPTION == "DEL ADMIN"         ~ "Non Ringfenced Resource DEL",
    CATEGORYDESCRIPTION == "DEL OTH RES"       ~ "Non Ringfenced Resource DEL",
    CATEGORYDESCRIPTION == "OTH AME CAP"       ~ "Other AME Capital",
    CATEGORYDESCRIPTION == "DEL ADM D/I"       ~ "Ringfenced Resource DEL",
    CATEGORYDESCRIPTION == "DEL RES D/I"       ~ "Ringfenced Resource DEL",
    CATEGORYDESCRIPTION == "STUDENT LOAN"      ~ "Ringfenced Resource DEL",
    TRUE ~ NA_character_  # default if no match
  ))

#End of 24/25 prov changes




#Remove extra columns
df_raw_data <- df_raw_data %>%
  select(-HMT_ENT, -UOSNAME, -UOSDESCRIPTION, -UOBNAME, -UOBDESCRIPTION, -RECORDNUMBER,
         -STRUCTURALRECORDDESCRIPTION, -CATEGORY, -CATEGORYDESCRIPTION)

#Rename variables
df_raw_data <- df_raw_data %>%
  rename(
    Dept = DEPARTMENTNAME,
    'OSCAR Code' = OSCAR,
    'Accounting Authority' = HMT_AA,
   Category = 'Category_Description_2',
    Amount = AMOUNT,
    'Budget Boundary' = BUD_BOUND
  )

#Reorder variables
df_raw_data <- df_raw_data %>%
  select(Dept, UOS, UOB, Record, `Economic Category`, `Account Code`, `OSCAR Code`,
         `Accounting Authority`, 'Spending Authority', COFOG, Amount, Year,
         'Covid Related', Category, 'Managed Expenditure Group', `Budget Boundary`)

#Save new file
write_xlsx(df_raw_data, new_table_save_destination)


#NOW ADD ROWS TO END OF PREVIOUS YEAR FILE MANUALLY IN EXCEL
