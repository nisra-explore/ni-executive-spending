#### install packages ####

library(dplyr)
library(readxl)
library(tidyr)
library(jsonlite)
library(here)

options(useFancyQuotes = FALSE)


## update parameters

pub_date = '29/10/2026' # Publication date in DD/MM/YYYY format
data_filename = paste0(here(), "/data-processing/data/Departmental Spending Analysis DEL & AME 2016-17 to 2025-26.xlsx")
labels_filename = paste0(here(), "/data-processing/data/Labels - data and public.xlsx")


#### set thresholds ####
tree_max_categories = 5
tree_min_percent = 0.06

uos_labels = read_excel(labels_filename) %>%
  mutate(`Public Label Suggested` = case_when(is.na(`Public Label Suggested`) ~ `Data Label`,
                                              TRUE ~ `Public Label Suggested`))


df_check_new_UOS = read_excel(data_filename, sheet = "Dataset", skip = 2) %>%
  subset(`Covid Related` == "Includes Covid" & Category != "Ringfenced Resource DEL" & Category != "AME D/I") %>% 
  mutate(uos_cleaned = substr(UOS,7,100),
         uos_cleaned = gsub("FHS - ","",uos_cleaned),
         uos_cleaned = gsub("'","",uos_cleaned)) %>%
  filter(!(uos_cleaned %in% uos_labels$`Data Label`)) %>% select(Dept, uos_cleaned) %>% unique()


if(nrow(df_check_new_UOS)==0){print("Labels are all included - proceed")} else {stop(paste0("review lables in df_check_new_UOS and add to ", labels_filename))}

#### read in raw data and process ####
#ALSO REMOVED OTHER AME CAPITAL - BASED ON NIFC FEEDBACK
df_raw_data = read_excel(data_filename, sheet = "Dataset", skip = 2) %>%
  subset(`Covid Related` == "Includes Covid" & Category != "Ringfenced Resource DEL" & Category != "AME D/I" & Category != "Other AME Capital") %>% 
  mutate(Dept = case_when(Dept %in% c('FSA','NIA','NIAO','NIAUR','NIPSO','PPS') ~ 'Other',
                          TRUE ~ Dept),
         dept_grouped = case_when(`Budget Boundary` == 'AME' ~ 'AME',
                                  TRUE ~ Dept),
         department_name = case_when(dept_grouped %in% c('FSA','NIA','NIAO','NIAUR','NIPSO','PPS') ~ 'Other',
                                     dept_grouped == "AME" ~ 'Benefits and pensions (AME)',
                                     dept_grouped == "DoH" ~ 'Health',
                                     dept_grouped == "DfI" ~ 'Infrastructure',
                                     dept_grouped == "DfE" ~ 'Economy',
                                     dept_grouped == "DOJ" ~ 'Justice',
                                     dept_grouped == "DE" ~ 'Education',
                                     dept_grouped == "DoF" ~ 'Finance',
                                     dept_grouped == "DfC" ~ 'Communities',
                                     TRUE ~ dept_grouped),
         uos_cleaned = substr(UOS,7,100),
         uos_cleaned = gsub("FHS - ","",uos_cleaned),
         uos_cleaned = gsub("'","",uos_cleaned),
         uos_cleaned = factor(uos_cleaned,
                              levels = uos_labels$`Data Label`,
                              labels = uos_labels$`Public Label Suggested`),
         uos_cleaned = case_when(Year %in% c('2016-17','2017-18', '2018-19') & 
                                   dept_grouped == "AME" & 
                                   uos_cleaned %in% c("NI Housing Executive profit/capital expenditure")
                                 ~ "Other",
                                 TRUE ~ uos_cleaned),
         uos_cleaned = case_when(dept_grouped == "AME" & 
                                   uos_cleaned %in% c("NI judicial pension scheme")
                                 ~ "Other",
                                 TRUE ~ uos_cleaned),
         total_spend_millions = Amount/1000) %>% subset(uos_cleaned != "Pensions" & 
                                                          uos_cleaned != "Common Agricultural Policy") #%>%  
  # filter(Year %in% tail(unique(sort(Year)),6))

df_resource_data <- df_raw_data %>% 
  filter(Category %in% c("AME Resource", "Non Ringfenced Resource DEL", "Ringfenced Resource DEL"))

#REMOVED OTHER AME CAPITAL
df_capital_data <- df_raw_data %>% 
  filter(Category %in% c("AME Capital",
                         "Capital DEL",
                         "FT Capital DEL"))


## Read MYE from data portal ####

mye_raw <- fromJSON("https://ws-data.nisra.gov.uk/public/api.jsonrpc?data=%7B%22jsonrpc%22:%222.0%22,%22method%22:%22PxStat.Data.Cube_API.ReadDataset%22,%22params%22:%7B%22class%22:%22query%22,%22id%22:%5B%22fiveyrage%22,%22Sex%22%5D,%22dimension%22:%7B%22fiveyrage%22:%7B%22category%22:%7B%22index%22:%5B%22All%22%5D%7D%7D,%22Sex%22:%7B%22category%22:%7B%22index%22:%5B%22All%22%5D%7D%7D%7D,%22extension%22:%7B%22pivot%22:null,%22codes%22:false,%22language%22:%7B%22code%22:%22en%22%7D,%22format%22:%7B%22type%22:%22JSON-stat%22,%22version%22:%222.0%22%7D,%22matrix%22:%22MYE01T01%22%7D,%22version%22:%222.0%22%7D%7D")$result


mye_data <- data.frame(year = mye_raw$dimension$`TLIST(A1)`$category$index,
                       mye = mye_raw$value) %>% 
  mutate(across(everything(), as.numeric),
         year = paste0(year, "-", year - 1999))

#manual update as mye not yet present in data portal JH 30/09
#mye_data <- mye_data %>%
#  add_row(
#    year = "2025-26",
#    mye = 1928446
#  )

mye <- mye_data %>% 
  filter(year %in% unique(df_raw_data$Year)) %>% 
  pull(mye)
 


dfs <- list("capital-data" = df_capital_data, 
            "resource-data" = df_resource_data,
            "data" = df_raw_data) 


for (i in 1:length(dfs)) {
  #### check to see if the order of the departments is the same as last year
  df_check_dept_order = dfs[[i]] %>% filter(dept_grouped != 'Other') %>%
    group_by(dept_grouped, Year) %>% summarise(money = sum(total_spend_millions)) %>% 
    ungroup() %>% group_by(Year) %>%
    mutate(dept_rank = rank(-money, ties.method = "max")) %>% select(-money) %>% pivot_wider(names_from = Year, values_from = dept_rank) %>% filter(.[6] != .[7])
  
  if(nrow(df_check_dept_order)==0){print("Depts are in the same order - proceed")} else {print("review department order in df_check_dept_order and manually modify order in webpage")}
  
  df_data_for_spreadsheet = dfs[[i]] %>% group_by(dept_grouped, uos_cleaned, Year) %>% summarise(money = sum(total_spend_millions))
  
  df_data_for_spreadsheet_detailed = dfs[[i]] %>% group_by(dept_grouped, uos_cleaned, Category, Year) %>% summarise(money = sum(total_spend_millions))
  
  #### create latest year variable ####
  
  latest_year = max(dfs[[i]]$Year)
  
  
  #### calculate numbers for the Treemap ####
  df_dept_spend = dfs[[i]] %>% 
    subset(Year == latest_year) %>% 
    group_by(dept_grouped, department_name) %>%
    summarise(total_spend_millions = sum(total_spend_millions)) %>% 
    arrange(desc(total_spend_millions)) %>% subset(dept_grouped != "Other")
  
  
  #### calculate numbers for the first line chart ####
  
  df_time_trend = dfs[[i]] %>% group_by(Year) %>% 
    subset(`Covid Related` == "Includes Covid") %>% 
    summarise(total_spend_millions = sum(total_spend_millions)) %>%
    mutate(population = mye,
           pounds_per_person = round(total_spend_millions/mye * 1000000,-2)
           # , 
           # deflator = gdp_deflator,
           # deflated_total_spend_millions = round(total_spend_millions/ gdp_deflator*100,1), deflator = gdp_deflator,
           # deflated_pounds_per_person = round(deflated_total_spend_millions/ mye* 1000000,-2)
    )
  
  
  #### calculate numbers for the line charts by department ####
  # will be filtered in the loop below
  df_dept_timetrend = dfs[[i]] %>% 
    group_by(Year, dept_grouped, department_name) %>% 
    summarise(total_spend_millions = sum(total_spend_millions)) %>%
    ungroup()
  
  #### calculate numbers for the bar charts and treemap by department ####
  # will be filtered in the loop below
  df_dept_spend_detail = dfs[[i]] %>% 
    #  subset(Year == latest_year ) %>% 
    group_by(dept_grouped, Year, department_name, uos_cleaned) %>%
    select(dept_grouped, Year, department_name, uos_cleaned, total_spend_millions) %>%
    summarise(total_spend_millions = sum(total_spend_millions)) %>% 
    ungroup()%>% arrange(desc(total_spend_millions))
  
  #### calculating data for other ####
  
  dept_breakdown_other = dfs[[i]] %>% 
    subset(dept_grouped == "Other") %>% 
    group_by(uos_cleaned, Year) %>% summarise(total_spend_millions = sum(as.numeric(total_spend_millions))) %>% arrange(desc(total_spend_millions),Year)
  
  dept_breakdown_other_total = dept_breakdown_other %>% subset(Year == latest_year) %>% ungroup() %>% summarise(total_spend_millions = round(sum(as.numeric(total_spend_millions)),0))
  
  
  #### create data for json as list and create meta data ####
  
  data_list = list(
    `_metadata` = c("Data for NI Executive webpage",
                    paste0("updated on ", format(Sys.time(), "%d/%m/%Y %H:%M:%S")),
                    paste0("based on data from ", df_time_trend$Year[1]," to ", latest_year),
                    paste0("input file name = ", data_filename))
  )
  
  #### Overall data ####
  
  data_list$overall = list(
    spend = dfs[[i]] %>% 
      subset(Year == latest_year & `Covid Related` == "Includes Covid") %>% 
      summarise(total_spend_millions = sum(total_spend_millions)) %>% 
      mutate(total_spend_billions = round(total_spend_millions/1000,1)) %>% pull(),
    spend_pp = dfs[[i]] %>% 
      subset(Year == latest_year & `Covid Related` == "Includes Covid") %>% 
      summarise(total_spend_millions = sum(total_spend_millions)) %>% 
      mutate(total_spend_pp = round(total_spend_millions / tail(mye, 1) * 1000000, -2)) %>% pull(),
    population = round(tail(mye, 1), -3),
    tree_data = as.list(setNames(
      round(df_dept_spend$total_spend_millions, 0),
      df_dept_spend$department_name
    )),
    line_data = as.list(setNames(
      round(df_time_trend$total_spend_millions, 0),
      df_time_trend$Year
    )),
    line_data_per_person = as.list(setNames(
      df_time_trend$pounds_per_person,
      df_time_trend$Year
    ))
  )
  
  #### DEL data ####
  
  data_list$del = list(
    spend = dfs[[i]] %>% 
      subset(Year == latest_year & `Covid Related` == "Includes Covid" & `Budget Boundary` != "AME") %>% 
      summarise(total_spend_millions = sum(total_spend_millions) /  1000) %>% pull() %>%  round(., 1),
    spend_pp = dfs[[i]] %>% 
      subset(Year == latest_year & `Covid Related` == "Includes Covid" & `Budget Boundary` != "AME") %>% 
      summarise(total_spend_millions = sum(total_spend_millions)) %>% 
      mutate(del_spend_pp = round(total_spend_millions / tail(mye, 1) * 1000000, -2))%>% pull()
  )
  
  #### AME data ####
  
  data_list$ame = list(
    spend = dfs[[i]] %>% 
      subset(Year == latest_year & `Covid Related` == "Includes Covid" & `Budget Boundary` == "AME") %>% 
      summarise(total_spend_millions = sum(total_spend_millions) / 1000 ) %>% pull() %>% round(., 1),
    spend_pp = dfs[[i]] %>% 
      subset(Year == latest_year & `Covid Related` == "Includes Covid" & `Budget Boundary` == "AME") %>% 
      summarise(total_spend_millions = sum(total_spend_millions)) %>% 
      mutate(del_spend_pp = round(total_spend_millions / tail(mye, 1) * 1000000, -2))%>% pull()
  )
  
  #### Departmental data ####
  
  for (j in 1:nrow(df_dept_spend)) {
    
    dept_name = df_dept_spend$dept_grouped[j]
    dept_name_lower = tolower(dept_name)
    print(dept_name)  
    
    
    dept_recent_spend = df_dept_timetrend %>% subset(dept_grouped == dept_name & Year == latest_year)  %>%      
      mutate(total_spend_millions = round(total_spend_millions,0))%>% pull(total_spend_millions)
    
    dept_timetrend = df_dept_timetrend %>% subset(dept_grouped == dept_name) %>% select(Year, total_spend_millions) %>%      
      mutate(total_spend_millions = round(total_spend_millions,0))
    
    
    dept_breakdown = df_dept_spend_detail %>% subset(dept_grouped == dept_name) %>% select(Year, uos_cleaned,   total_spend_millions) %>%      
      mutate(total_spend_millions = round(total_spend_millions,0)) %>%  arrange(desc(total_spend_millions),Year)
    
    
    dept_breakdown_latest = df_dept_spend_detail %>% subset(dept_grouped == dept_name & Year == latest_year) %>% select(uos_cleaned,   total_spend_millions) %>%      
      mutate(total_spend_percent = total_spend_millions/dept_recent_spend)
    
    # limit the treemap data to tree_max_categories
    if(nrow(dept_breakdown_latest) >= tree_max_categories 
       ## for the AME breakdown
       & dept_name !='AME'
    ){
      tot = sum(dept_breakdown_latest$total_spend_millions)
      dept_breakdown_short_tree = dept_breakdown_latest %>% head(tree_max_categories) %>% select(uos_cleaned,   total_spend_millions)
      tot_tree_max_categories = sum(dept_breakdown_short_tree$total_spend_millions)
      tot_oth = tot-tot_tree_max_categories
      dept_breakdown_short_tree = rbind(dept_breakdown_short_tree,c(uos_cleaned= 'Other', total_spend_millions = tot_oth))
      dept_breakdown_short_tree = dept_breakdown_short_tree %>%
        group_by(uos_cleaned) %>% summarise(total_spend_millions = sum(as.numeric(total_spend_millions))) %>%     
        mutate(total_spend_percent = total_spend_millions/dept_recent_spend) 
      
      
    } else {dept_breakdown_short_tree = dept_breakdown_latest }
    
    
    # limit the treemap data those bigger than tree_min_percent%
    if(min(dept_breakdown_short_tree$total_spend_percent ) < tree_min_percent  
       ## for the AME breakdown
       & dept_name !='AME'
    ){
      tot = sum(dept_breakdown_short_tree$total_spend_millions)
      dept_breakdown_short_tree = dept_breakdown_short_tree %>% subset(total_spend_percent >= tree_min_percent) %>% select(uos_cleaned,   total_spend_millions)
      tot_tree_max_categories = sum(dept_breakdown_short_tree$total_spend_millions)
      tot_oth = tot-tot_tree_max_categories
      
      df_tot_other =  data.frame(uos_cleaned= 'Other', total_spend_millions = tot_oth)
      
      dept_breakdown_short_tree = rbind(
        dept_breakdown_short_tree,df_tot_other)
      
      dept_breakdown_short_tree = dept_breakdown_short_tree %>%
        group_by(uos_cleaned) %>% 
        summarise(total_spend_millions = sum(as.numeric(total_spend_millions))) %>%
        mutate(total_spend_percent = total_spend_millions/dept_recent_spend)
      
    }
    
    # make sure treemap data is sorted
    dept_breakdown_short_tree = dept_breakdown_short_tree %>%   mutate(total_spend_millions = round(as.numeric(total_spend_millions),0))  %>% 
      arrange(desc(total_spend_millions))
    
    if (!dept_name_lower %in% names(data_list)) {
      data_list[[dept_name_lower]] <- list()
    }
    
    data_list[[dept_name_lower]]$tree_data <- as.list(setNames(
      round(dept_breakdown_short_tree$total_spend_millions, 0),
      dept_breakdown_short_tree$uos_cleaned
    ))
    
    data_list[[dept_name_lower]]$line_data <- as.list(setNames(
      dept_timetrend$total_spend_millions,
      df_time_trend$Year
    ))
    
    data_list[[dept_name_lower]]$bar_data <- list()
    
    for (year in df_time_trend$Year) {
      
      dept_breakdown_by_year = dept_breakdown %>% subset(Year == year)
      
      data_list[[dept_name_lower]]$bar_data[[year]] <- as.list(setNames(
        round(dept_breakdown_by_year$total_spend_millions,0),
        dept_breakdown_by_year$uos_cleaned
      ))
      
    }
    
  }
  
  #### Add other data ####
  
  data_list$other$bar_data <- list()
  
  for (year in df_time_trend$Year) {
    otherdept_breakdown_by_year = dept_breakdown_other %>% subset(Year == year)
    
    data_list$other$bar_data[[year]] <- as.list(setNames(
      round(otherdept_breakdown_by_year$total_spend_millions,0),
      otherdept_breakdown_by_year$uos_cleaned
    ))
    
  }
  
  data_list$other$recent_spend <- dept_breakdown_other_total$total_spend_millions
  
  #### Write Data to JSON file ####
  
  write_json(data_list, paste0(here(), "/data-processing/", names(dfs)[i], "_", latest_year, ".json"), pretty = TRUE, auto_unbox = TRUE)
  write_json(data_list, paste0(here(), "/", names(dfs)[i], ".json"), pretty = TRUE, auto_unbox = TRUE)
  
  
}
