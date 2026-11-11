new_worksheet <- function(table, title, widths, notes = NULL) {
  
  num_tables <- if (class(table)[1] == "list") {
    length(table)
  } else {
    1
  }
  
  first_table <- if (num_tables == 1) {
    table
  } else {
    table[[1]]
  }
  
  for (i in 1:num_tables) {
    
    if (num_tables == 1) {
      table_name <- deparse(substitute(table))
    } else {
      table_name <- names(table)[i]
    }
    
  sheet_name <- deparse(substitute(table))
   
  if (i == 1) {
    addWorksheet(wb, sheet_name)
  }

    if (i == 1) {
      
      if (num_tables > 1) {
        sheet_title <- gsub(".*: ", "", title)
        table_title <- gsub(":", "a:", title)
      } else {
        sheet_title <- title
        table_title <- title
      }
      
      top_content <- c(sheet_title,
                       paste("This worksheet contains", num_tables, if (num_tables == 1) {"table of spending data"} else {"tables presented vertically and separated by a single blank row"}, "and explanatory notes."),
                       "Notes",
                       "These figures are produced from PSD data")
      
      if (!is.null(notes)) {
        top_content <- c(top_content, notes)
      }

      writeData(wb, sheet_name,
                top_content,
                startRow = 1)

      addStyle(wb, sheet_name, style = pt, rows = 1, cols = 1)
      addStyle(wb, sheet_name, style = pt2, rows = 3, cols = 1)
      
      n = length(top_content) + 1
      
      contents <<- rbind(contents,
                         data.frame(sheet = gsub("_", " ", sheet_name),
                                    num = table_name,
                                    name = table_title,
                                    link = paste0("A", n)))
      
      if (num_tables > 1) {
        writeData(wb, sheet_name, table_title, startRow = n)
        addStyle(wb, sheet_name, style = pt, rows = n, cols = 1)
        n <- n + 1
      }
      
      writeDataTable(wb, sheet_name,
                     first_table,
                     startRow = n,
                     colNames = TRUE,
                     tableStyle = "none",
                     tableName = table_name,
                     withFilter = FALSE,
                     bandedRows = FALSE,
                     headerStyle = ch)
      
      addStyle(wb, sheet_name, style = chl, rows = n, cols = 1)
      
      if (sheet_name == "Table_1") {
        
        addStyle(wb, sheet_name, style = ns_billion, rows = c(n + 1, n + 3, n + 5), cols = 2, gridExpand = TRUE)
        addStyle(wb, sheet_name, style = ns_money, rows = c(n + 2, n + 4, n + 6), cols = 2, gridExpand = TRUE)
        addStyle(wb, sheet_name, style = ns, rows = n + 7, cols = 2, gridExpand = TRUE)
        
        money_cols_4 <- which(grepl("(£000s)", names(table)))
        addStyle(wb, sheet_name, style = ns, rows = (n + 1):(n + nrow(table)), cols = money_cols_4, gridExpand = TRUE)
        
        setColWidths(wb, sheet_name, cols = 1:ncol(table), widths = widths)
        
      } else {
          
        billion_cols <- which(grepl("billion", names(first_table)))
        addStyle(wb, sheet_name, style = ns_billion2, rows = (n + 1):(n + nrow(first_table)), cols = billion_cols, gridExpand = TRUE)
        
        money_cols_1 <- which(grepl("(£)", names(first_table), fixed = TRUE))
        addStyle(wb, sheet_name, style = ns, rows = (n + 1):(n + nrow(first_table)), cols = money_cols_1, gridExpand = TRUE)
        
        money_cols_2 <- which(grepl("(£millions)", names(first_table), fixed = TRUE))
        addStyle(wb, sheet_name, style = ns, rows = (n + 1):(n + nrow(first_table)), cols = money_cols_2, gridExpand = TRUE)
        
        money_cols_3 <- which(grepl("(£ million)", names(first_table), fixed = TRUE))
        addStyle(wb, sheet_name, style = ns, rows = (n + 1):(n + nrow(first_table)), cols = money_cols_3, gridExpand = TRUE)
        
        money_cols_4 <- which(grepl("(£000s)", names(first_table)))
        addStyle(wb, sheet_name, style = ns, rows = (n + 1):(n + nrow(first_table)), cols = money_cols_4, gridExpand = TRUE)
        
        population_cols <- which(grepl("population", names(first_table)))
        addStyle(wb, sheet_name, style = ns, rows = (n + 1):(n + nrow(first_table)), cols = population_cols, gridExpand = TRUE)
        
        money_col <- which(names(first_table) == "money")
        addStyle(wb, sheet_name, style = ns_money3, rows = (n + 1):(n + nrow(first_table)), cols = money_col, gridExpand = TRUE)
        
        left_headings <- which(names(first_table) %in% c("Spending Area",	"Expenditure Category", "Year"))
        addStyle(wb, sheet_name, style = chl, rows = n, cols = left_headings)
        
        setColWidths(wb, sheet_name, cols = 1:ncol(first_table), widths = widths)
        
      }
      
      n <- n + nrow(first_table) + 2

    } else {
      
      table_title <- paste(gsub(":", "b:", title), "(unrounded)")
      
      writeData(wb, sheet_name, table_title, startRow = n)
      addStyle(wb, sheet_name, style = pt, rows = n, cols = 1)
      n <- n + 1
      
      contents <<- rbind(contents,
                         data.frame(sheet = gsub("_", " ", sheet_name),
                                    num = table_name,
                                    name = table_title,
                                    link = paste0("A", n)))
      
      writeDataTable(wb, sheet_name,
                     table[[i]],
                     startRow = n,
                     colNames = TRUE,
                     tableStyle = "none",
                     tableName = table_name,
                     withFilter = FALSE,
                     bandedRows = FALSE,
                     headerStyle = ch)
      
      addStyle(wb, sheet_name, style = chl, rows = n, cols = 1)
      
      billion_cols <- which(grepl("billion", names(table[[i]])))
      addStyle(wb, sheet_name, style = ns_billion2, rows = (n + 1):(n + nrow(table[[i]])), cols = billion_cols, gridExpand = TRUE)
      
      money_cols_1 <- which(grepl("(£)", names(table[[i]]), fixed = TRUE))
      addStyle(wb, sheet_name, style = ns, rows = (n + 1):(n + nrow(table[[i]])), cols = money_cols_1, gridExpand = TRUE)
      
      money_cols_2 <- which(grepl("(£millions)", names(table[[i]]), fixed = TRUE))
      addStyle(wb, sheet_name, style = ns, rows = (n + 1):(n + nrow(table[[i]])), cols = money_cols_2, gridExpand = TRUE)
      
      money_cols_3 <- which(grepl("(£ million)", names(table[[i]]), fixed = TRUE))
      addStyle(wb, sheet_name, style = ns, rows = (n + 1):(n + nrow(table[[i]])), cols = money_cols_3, gridExpand = TRUE)
      
      money_cols_4 <- which(grepl("(£000s)", names(table[[i]])))
      addStyle(wb, sheet_name, style = ns, rows = (n + 1):(n + nrow(table[[i]])), cols = money_cols_4, gridExpand = TRUE)
      
      population_cols <- which(grepl("population", names(table[[i]])))
      addStyle(wb, sheet_name, style = ns, rows = (n + 1):(n + nrow(table[[i]])), cols = population_cols, gridExpand = TRUE)
      
      money_col <- which(names(table[[i]]) == "money")
      addStyle(wb, sheet_name, style = ns_money3, rows = (n + 1):(n + nrow(table[[i]])), cols = money_col, gridExpand = TRUE)
      
      left_headings <- which(names(table[[i]]) %in% c("Spending Area",	"Expenditure Category", "Year"))
      addStyle(wb, sheet_name, style = chl, rows = n, cols = left_headings)
      
      if (i != 1) {
        n <- n + nrow(table[[i]]) + 2
      }
      
      setColWidths(wb, sheet_name, cols = 1:ncol(table[[1]]), widths = widths)
      
    }

  }
  
}
