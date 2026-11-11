# ELMS public spending dashboard
# test

## :newspaper: Aim
Documentation to outline the structure and processes needed to create or modify the ELMS public spending dashboard.

## :house: Structure

### File structure 

| File | Purpose  |
| --- | --- |
| `index.html` | The dashboard home page |
| `main.html` | The detailed explainer |
| `quick-read.html` | The quick read version of the dashboard main page |
| `custom.css` | Pre-defined styling for the dashboards - colours, fonts, sizing, spacing etc |
| `data.json` | Data file created from R code - used to power all data elements in the dashboard |
| `capital-data.json` | Data file created from R code - used to power capital data elements in the dashboard |
| `resource-data.json` | Data file created from R code - used to power resource data elements in the dashboard |
| `functions.js` | Javascript functionality used throughout dashboard |
| `cookies_script.js` | Javascript to handle cookie banner |
| `*.png, *.jpg` | Logos, photographs, icons |

### Input and outputs expected

| File | Type | Purpose  |
| --- | --- | --- |
| `Labels - data and public.xlsx` | Input | Label recoding |
| `Departmental Spending Analysis DEL & AME 20XX-XX to 20XX-XX.xlsx` | Input | Data for R script to create data.js |
| | | |
| `data.json` | Output | Data create by R script, used by the web page for charts etc. |
| `capital-data.json` | Data create by R script, used by the web page for charts etc. |
| `resource-data.json` | Data create by R script, used by the web page for charts etc. |
| `tables_20XX-XX.xlsx` | Output | Excel download file for users to download |

### Code structure

| Section | Purpose  |
| --- | --- |
| Head | Page title, import css and js dependencies, Google Analytics code, header and feedback survey bar |
| Body | Header and branding, more Google Analytics code, headings (h1, h2 etc.), key findings, Q&A, overall line chart, treemap, department accordions, further information, roadmap, footer |
| Key findings | A 12-column[^1] (max) 'total' and two 6-column (half each) boxes |
| Q&A | 3x buttons with 3x expandable accordions with definitions |
| Overall line chart | Chart.js line chart with toggle for total/PP |
| Treemap | Chart.js treemap with drill down, department colours, text-wrapping for boxes, automatic vertical flip for mobile |
| Accordions | Each accordion is within a `<div class="accordion-item">`. Within is an `accordion-header` and `accordion-body`. Each includes an information box, background text, a time series Chart.js chart and a Chart.js barchart with year selector |
| Further info | Accessibility statement & accordion, text and links |
| Roadmap | Image with formatting for mobile |
| Footer | Standard NISRA footer |

[^1]: The CSS used for the page works on the width of an element (the 'boxes' here) being up to 12 columns wide. So a 12 column item is 100%, a 6 column item is 50%, a 4 column item is 33% and so on. The classes used here are "col-sm-12" and "col-sm-6" for example.

## :bell: Processes

### Preparing your data (using R/Rstudio) :hammer:
#### Data to create data JS file (powers the web page, charts etc.)
1. Open 'Public-Expenditure.Rproj' in R and within that project navigatie to the `data-processing` folder and open `data_processing.R`.
1. Input file defined using filename e.g. `filename = "data/Departmental Spending Analysis DEL & AME 2016-17 to 2021-22.xlsx"`
1. Update publication date - `pub_date` variable
1. The MYE population values are now updated automatically using the data available on the NISRA data portal and no longer need to be manually entered.
1. (As required) GDP deflator variable `gdp_deflator` e.g. `gdp_deflator = c(50.001, 60.002, 70.003, 80.004, 90.005, 100.000)`
1. Label tidying occurs in via the Labels - data and public.xlsx spreadsheet - check the old/new labels match what is required in the spreadsheet before running code.
   - If new labels appear in the data, the process will stop at this point and inform you to check the file. The records listed there are new and need to be added to the Labels file you intend to use, making sure to populate the third column with a display version as this is what will be shown in the final product
1. Run R code (Click the __Source__ button or press <kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>S</kbd>)
1. Output files `data_YYYY-YY.json`, `capital-data_YYYY-YY.json` and `resource-data_YYYY-YY.json` (defined with penultimate `write_json` command) will be created in the `data-processing` folder
1. Output files `data.json`, `capital-data.json` and `resource-data.json` (defined with final `write_json` command) will be created in the the root directory

#### Data download file (Excel) - Note: ensure data_processing.R has been updated and is functioning correctly before running this step
1. Open `dashboard_tables.R` in R
1. Run R code (Click the __Source__ button or press <kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>S</kbd>)
1. Output file as defined by `wb_filename` will be created in the R project folder
1. The `Download data` buttons found on the 3 html pages will be updated with a link to download the Excel workbook.

### Update the dashboard with any necessary changes :chart_with_upwards_trend:
These may be things such as:
- Updating text or definitions/information boxes
- Adding/removing charts or sections
- Replacing images

### Testing phase :mortar_board:
When modifications have been made (new data or otherwise), carry out a systematic testing of content:
- Spelling and definitions
- Data is being presented accurately in text, charts, images etc.
- All links are still working e.g. Downloads, share buttons, links to external websites, links that make reference to other parts of the dashboard etc.

### explore.nisra.gov.uk hosting :computer:
1. Instructions to follow

### 'Live' check :sun_with_face:
1. Once the dashboard has gone live, re-run the 'Testing phase' actions from above to ensure they have translated to the DataVis platform
1. Perform checks on mobile devices as necessary to ensure functionality and accessibility

## :warning: Troubleshooting
- No charts are appearing
  - Check for changes to Javascript - a single issue with JS/data can result in all charts failing to render
- Labels in tree map aren't line breaking correctly
  - Go to `functions.js` and around line 918 you will find code that deals with the line breaks in tree map labels. Alter the tolerances in there by adding a value after `ctx_tree.raw.w` which will create extra padding 
- The order of Departmental categories has changed
  - The tree map and the accordions below are ordered in descending order of spending. If this order changes in data, the tree map Departmental boxes will not link to the correct underlying data. The accordions will be in the wrong order in this instance. To rectify this simply move the appropriate code up or down the `main.html` code. The same will apply to the quick read. 

## :question: Links
- [Chart.js documentation](https://www.chartjs.org/docs/latest/)
- [Chart.js YouTube tutorials](https://www.youtube.com/c/ChartJS-tutorials)
- [CSS / styling guide on W3schools](https://www.w3schools.com/Css/)
- [HTML guide on W3schools](https://www.w3schools.com/html/default.asp)
- [Javascript guide on W3schools](https://www.w3schools.com/js/default.asp)
- [Test HTML/css/javascript on web sandbox - DO NOT UPLOAD SENSITIVE DATA](https://jsfiddle.net/)
- [Visual Studio Code documentation](https://code.visualstudio.com/Docs)
- [Github.com documentation](https://docs.github.com/en)
- [R cheatsheet PDFs](https://github.com/rstudio/cheatsheets)
