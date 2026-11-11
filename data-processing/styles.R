f_single_excel <- function(title, info, notes = c(NA), df, sheet, tablename, num_cols = NA,
                           pct_cols = NA) {
  
  r <- 1
  
  writeData(new_workbook, sheet = sheet,
            x = paste0(title),
            startRow = r,
            colNames = FALSE)
  
  addStyle(new_workbook, sheet,
           style = pt,
           rows = r,
           cols = 1)
  
  r <- r + 1
  
  writeData(new_workbook, sheet = sheet,
            x = paste0(info),
            startRow = r,
            colNames = FALSE)
  
  r <- r + 1
  if(is.na(notes[1])){
    
    
  } else {
    
    
    writeData(new_workbook, sheet = sheet,
              x = paste0(notes),
              startRow = r,
              colNames = FALSE)
    
    addStyle(new_workbook, sheet = sheet,
             style = pt2,
             rows = r,
             cols = 1)
    
    r <- r + length(notes)
    
  }
  
  writeDataTable(new_workbook, sheet = sheet,
                 x = df,
                 startRow = r,
                 tableStyle = "none",
                 tableName = tablename,
                 withFilter = FALSE,
                 bandedRows = FALSE,
                 headerStyle = ch,
                 keepNA = TRUE)
  
  # Applies style to cells of table
  addStyle(new_workbook, sheet = sheet,
           style = chl,
           rows = r,
           cols = 1)
  
  addStyle(new_workbook, sheet = sheet,
           style = ns,
           rows = r+1:(r + nrow(df)),
           cols = num_cols,
           gridExpand = TRUE)
  
  addStyle(new_workbook, sheet = sheet,
           style = ns_percent,
           rows = r+1:(r + nrow(df)),
           cols = pct_cols,
           gridExpand = TRUE)
  
}


# Styles for Page titles
pt <- createStyle(textDecoration = "bold",
                  fontSize = 15)

pt2 <- createStyle(textDecoration = "bold")

# Styles for column headers
ch <- createStyle(halign = "right",
                  valign = "bottom",
                  wrapText = TRUE,
                  textDecoration = "bold")

# Style for column header (left aligned)
chl <- createStyle(halign = "left",
                   valign = "bottom",
                   wrapText = TRUE,
                   textDecoration = "bold")

# Style for column header (center)
ch2 <- createStyle(halign = "center",
                   valign = "bottom",
                   wrapText = TRUE,
                   textDecoration = "bold")

# Style for numbers
ns <- createStyle(numFmt = "#,##0",
                  halign = "right")


# Style for decimal numbers
nsd <- createStyle(numFmt = "#,###.##",
                   halign = "right")


ns_comma <- createStyle(numFmt = "#,##0",
                        halign = "right")

ns_percent <- createStyle(numFmt = "#0.0",
                          halign = "right")

ns_billion <- createStyle(numFmt = '£#.0 "billion"',
                          halign = "right")

ns_billion2 <- createStyle(numFmt = '_-£* #,##0.0_-;-£* #,##0.0_-;_-£* "-"??_-;_-@_-',
                          halign = "right")

ns_money <- createStyle(numFmt = "£#,##0",
                        halign = "right")

ns_money2 <- createStyle(numFmt = '_-£* #,##0_-;-£* #,##0_-;_-£* "-"??_-;_-@_-',
                         halign = "right")

ns_money3 <- createStyle(numFmt = '_-* #,##0_-;-* #,##0_-;_-* "-"??_-;_-@_-',
                         halign = "right")

# Style to right align cells
ra <- createStyle(halign = "right")

# Style to left align cells
la <- createStyle(halign = "left")

# Style for contents
tw <- createStyle(wrapText = TRUE)

# Style for left aligned text headings
h3 <- createStyle(halign = "left",
                  textDecoration = "bold",
                  fontSize = 13)
# small sample size style
sh <- createStyle(halign = "right", fgFill = "#d3d3d3")

sh_comma <- createStyle(halign = "right", fgFill = "#d3d3d3", numFmt = "#,##0")

sh_percent <- createStyle(halign = "right", fgFill = "#d3d3d3", numFmt = "#0.0")

# Style for column headers needed for maketable function
hs <- createStyle(halign = "right",
                  wrapText = TRUE,
                  textDecoration = "bold")

hs2 <- createStyle(halign = "left",
                   wrapText = TRUE,
                   textDecoration = "bold")

ts <- createStyle(textDecoration = "bold",
                  fontSize = 14)