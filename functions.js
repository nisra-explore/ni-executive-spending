var data;

async function getData(dataType) {
  let fileName;

  switch (dataType) {
    case 'capital':
      fileName = 'capital-data.json';
      break;
    case 'resource':
      fileName = 'resource-data.json';
      break;
    case 'all':
      fileName = 'data.json';
      break;
    default:
      throw new Error('Invalid data type');
  }

  try {
    const response = await fetch(fileName);
    const responseData = await response.json();
    data = responseData;
  } catch (error) {
    console.error('Error fetching data:', error);
  }


  // defining data driven values - called by class name (value within querySeletorAll() below) in html section tag
  const total_spend_elements = document.querySelectorAll('.total_spend_value');
    for (let i = 0; i < total_spend_elements.length; i++) {
      total_spend_elements[i].innerHTML = ['£' + Number(data.overall.spend).toFixed(1).toLocaleString('en') + ' billion'];
  }

  const total_spend_pp_elements = document.querySelectorAll('.total_spend_pp_value');
    for (let i = 0; i < total_spend_pp_elements.length; i++) {
      total_spend_pp_elements[i].innerHTML = ['£' + Number(data.overall.spend_pp).toLocaleString('en')];
  }

  const del_spend_elements = document.querySelectorAll('.del_spend_value');
    for (let i = 0; i < del_spend_elements.length; i++) {
      del_spend_elements[i].innerHTML = ['£' + Number(data.del.spend).toFixed(1).toLocaleString('en') + ' billion'];
  }
  const del_spend_pp_elements = document.querySelectorAll('.del_spend_pp_value');
    for (let i = 0; i < del_spend_pp_elements.length; i++) {
      del_spend_pp_elements[i].innerHTML = ['£' + Number(data.del.spend_pp).toLocaleString('en')];
  }
  const ame_spend_elements = document.querySelectorAll('.ame_spend_value');
    for (let i = 0; i < ame_spend_elements.length; i++) {
      ame_spend_elements[i].innerHTML = ['£' + Number(data.ame.spend).toFixed(1).toLocaleString('en') + ' billion'];
  }
  const ame_spend_pp_elements = document.querySelectorAll('.ame_spend_pp_value');
    for (let i = 0; i < ame_spend_pp_elements.length; i++) {
      ame_spend_pp_elements[i].innerHTML = ['£' + Number(data.ame.spend_pp).toLocaleString('en')];
  }

  const population_elements = document.querySelectorAll('.population_value');
    for (let i = 0; i < population_elements.length; i++) {
      population_elements[i].innerHTML = [data.overall.population.toLocaleString('en')];
    }

    const current_year_elements = document.querySelectorAll('.current_year_value');
    for (let i = 0; i < current_year_elements.length; i++) {
      current_year_elements[i].innerHTML = Object.keys(data.overall.line_data).pop();
    }

   const pop_year_elements = document.querySelectorAll('.pop_year_value');
   for (let i = 0; i < pop_year_elements.length; i++) {
    pop_year_elements[i].innerHTML = Object.keys(data.overall.line_data).pop().slice(0, 4);
  }

const first_year_elements = document.querySelectorAll('.first_year_value');
  for (let i = 0; i < first_year_elements.length; i++) {
    first_year_elements[i].innerHTML = Object.keys(data.overall.line_data)[0];
   }


  const ame_current_year_elements = document.querySelectorAll('.ame_current_year_value');
    for (let i = 0; i < ame_current_year_elements.length; i++) {
      ame_current_year_elements[i].innerHTML = ['£' + Object.values(data.ame.line_data).pop().toLocaleString() + ' million'];
  }
  const doh_current_year_elements = document.querySelectorAll('.doh_current_year_value');
    for (let i = 0; i < doh_current_year_elements.length; i++) {
      doh_current_year_elements[i].innerHTML = ['£' + Object.values(data.doh.line_data).pop().toLocaleString() + ' million'];
  }
  const dfc_current_year_elements = document.querySelectorAll('.dfc_current_year_value');
    for (let i = 0; i < dfc_current_year_elements.length; i++) {
      dfc_current_year_elements[i].innerHTML = ['£' + Object.values(data.dfc.line_data).pop().toLocaleString() + ' million'];
  }
  const de_current_year_elements = document.querySelectorAll('.de_current_year_value');
    for (let i = 0; i < de_current_year_elements.length; i++) {
      de_current_year_elements[i].innerHTML = ['£' + Object.values(data.de.line_data).pop().toLocaleString() + ' million'];
  }
  const dfi_current_year_elements = document.querySelectorAll('.dfi_current_year_value');
    for (let i = 0; i < dfi_current_year_elements.length; i++) {
      dfi_current_year_elements[i].innerHTML = ['£' + Object.values(data.dfi.line_data).pop().toLocaleString() + ' million'];
  }
  const doj_current_year_elements = document.querySelectorAll('.doj_current_year_value');
    for (let i = 0; i < doj_current_year_elements.length; i++) {
      doj_current_year_elements[i].innerHTML = ['£' + Object.values(data.doj.line_data).pop().toLocaleString() + ' million'];
  }
  const dfe_current_year_elements = document.querySelectorAll('.dfe_current_year_value');
    for (let i = 0; i < dfe_current_year_elements.length; i++) {
      dfe_current_year_elements[i].innerHTML = ['£' + Object.values(data.dfe.line_data).pop().toLocaleString() + ' million'];
  }
  const dof_current_year_elements = document.querySelectorAll('.dof_current_year_value');
    for (let i = 0; i < dof_current_year_elements.length; i++) {
      dof_current_year_elements[i].innerHTML = ['£' + Object.values(data.dof.line_data).pop().toLocaleString() + ' million'];
  }
  const daera_current_year_elements = document.querySelectorAll('.daera_current_year_value');
    for (let i = 0; i < daera_current_year_elements.length; i++) {
      daera_current_year_elements[i].innerHTML = ['£' + Object.values(data.daera.line_data).pop().toLocaleString() + ' million'];
  }
  const teo_current_year_elements = document.querySelectorAll('.teo_current_year_value');
    for (let i = 0; i < teo_current_year_elements.length; i++) {
      teo_current_year_elements[i].innerHTML = ['£' + Object.values(data.teo.line_data).pop().toLocaleString() + ' million'];
  }
  const other_current_year_elements = document.querySelectorAll('.other_current_year_value');
    for (let i = 0; i < other_current_year_elements.length; i++) {
      other_current_year_elements[i].innerHTML = ['£' + data.other.recent_spend.toLocaleString() + ' million'];
  }

  // Line charts declarations
  var overall_line_chart = declare_line_chart('overall');
  const ame_line_chart = declare_line_chart('ame');
  const doh_line_chart = declare_line_chart('doh');
  const dfc_line_chart = declare_line_chart('dfc');
  const de_line_chart = declare_line_chart('de');
  const dfi_line_chart = declare_line_chart('dfi');
  const doj_line_chart = declare_line_chart('doj');
  const dfe_line_chart = declare_line_chart('dfe');
  const dof_line_chart = declare_line_chart('dof');
  const daera_line_chart = declare_line_chart('daera');
  const teo_line_chart = declare_line_chart('teo');

  // Line Chart functions

// The function that ultimately generates each line chart is declare_line_chart()
// It takes the single input: "dep" (the department name) and can also take the optional input "dep2"
// Without declaring "dep2" the value declared as "dep" will be used by default
// "dep2" is only used when the desired formatting is different to the default formatting retured by set_line_options() for that department
// The only chart requiring the use of "dep2" is the "spend per person" line chart for total spending
function declare_line_chart (dep, dep2 = dep) {

  // A new chart object is created using the Chart() command from chart.js
  chart = new Chart(eval('ctx_' + dep + '_line'), {
    type: 'line',
    data: get_line_data(dep),       // The data is the result of calling get_line_data()
    options: set_line_options(dep2)  // The options are the result of calling set_line_options()
  });

  return chart;

};

// The function to generate the data for the line charts is get_line_data()
// It takes the single input: dep. And it is called inside declare_line_chart() above.
function get_line_data (dep) {


  // "label_words" creates labels for the lines for each department
  label_words = {
    ame: 'Annually managed expenditure',
    doh: 'Health',
    dfc: 'Communities',
    de: 'Education',
    dfi: 'Infrastructure',
    doj: 'Justice',
    dfe: 'Economy',
    dof: 'Finance',
    daera: 'Agriculture, Environment and Rural Affairs',
    teo: 'TEO'
  };

  // The "line_data" object is defined
  line_data = {
  labels: Object.keys(data[dep].line_data),    // The labels are set to be the value line_data_labels
  datasets: [{
    data: Object.values(data[dep].line_data),   // The data is defined as the line_data for the particular dep
    fill: false,                      // filled line chart feature is turned off
    borderColor: colours[dep],  // Border colour is set for the dep
    borderWidth: 1,                     // Border width is 1
    pointStyle: 'circle',               // points on charts are circles
    pointRadius: 5,                     // point size is set
    pointHoverRadius: 15
  }]
};

// For the overall line chart an extra dataset indicating spend per person is added
if (dep == "overall") {
  line_data.datasets[0].label = 'Total';
  line_data.datasets[1] = {label: "Per person",
    data: Object.values(data.overall.line_data_per_person),
    hidden: true,   // The spend per person line is initially hidden
    fill: false,
    borderColor: colours.overall,
    borderWidth: 1,
    pointStyle: 'circle',
    pointRadius: 5,
    pointHoverRadius: 15};

} else { // Departmental charts have labels calculated
  line_data.datasets[0].label = label_words[dep] + ' spending overtime';
}

  return line_data; // The "line_data" object is returned

};

  // The other function that is called inside declare_line_chart() is set_line_options()
// set_line_options() takes the single argument: dep
function set_line_options(dep) {

  // The "line_options" object is defined
  line_options = {
  hover : false ,   // hover mode is turned off
  maintainAspectRatio: true,  // chart maintains 2:1 ratio when resized
  scales: {
    y: {
      suggestedMin: 0,                                          // y axis always starts at 0
      grid: { display: false },                                 // y axis grid not displayed
      ticks: {callback: function (label) {                      
        return '£' + Number(label).toLocaleString('en') + 'm';   // y axis labels formatted with £ sign and millions units
      }}
    },
    x: { grid: { display: false },          // x axis grid not displayed
         offset: true,                      // extra space is added to the both edges and the axis is scaled to fit into the chart area 
         title: {
           display: true,                    // x axis title is displayed
           text: 'Year of spend'             // text is set
         }
    }
  },
  plugins: {
    tooltip: { enabled: false } ,       // tooltips are turned off
    legend: {
      display: false                     // legend is removed
    },
    title: {
      display: true,                    // title is displayed
    },
    datalabels: {
      color: '#000000',                                             // data labels are coloured black
      align: 'bottom',                                              // data labels are aligned to the bottom
      formatter: function (value) {
        return ['£' + Number(value).toLocaleString('en')] + 'm';    // data labels formatted with £ sign and millions units
      }}
  }
};

  // For the spend per person graph the millions units formatting is removed from the tick labels and data labels
  if (dep == 'overall_per_person') {

    line_options.scales.y.ticks.callback = function (label) {
      return '£' + Number(label).toLocaleString('en');
    }

    line_options.plugins.datalabels.formatter = function (value) {
      return ['£' + Number(value).toLocaleString('en')];
    }

  } 

  return line_options; // "line_options" object is returned

}

  // This function will toggle between the spend per person/total spend line charts when the buttons above the chart are clicked
  function toggleDataLine (want, dont_want) {  

  // If the "Spend per person" chart is selected
  if (want === 1) {
    overall_line_chart.destroy();   // Remove the last line chart
    overall_line_chart = declare_line_chart('overall', 'overall_per_person'); // plot the chart with the options for "overall_per_person"
    overall_y_label.innerHTML = `${spend_type_capitalised}Spend per person (£)`; // Change the y axis label
    overall_header.innerHTML = `Total NI Executive ${spend_type_capitalised}spending (AME & DEL) per person since ${Object.keys(data.overall.line_data)[0] // Change the chart title
    }`  
  } else {
    overall_line_chart.destroy(); // Remove the last line chart
    overall_line_chart = declare_line_chart('overall');  // plot the chart with the options for "overall"
    overall_y_label.innerHTML = `Total ${spend_type_capitalised}spend (£m)`;  // Change the y axis label
    overall_header.innerHTML = `Total NI Executive ${spend_type_capitalised}spending (AME & DEL) since ${Object.keys(data.overall.line_data)[0] // Change the chart title
    }` 
  }

  // This will switch the data values between the total spend and spend per person values:
  const showValueLine = overall_line_chart.isDatasetVisible(want);
    if(showValueLine === false) {
      overall_line_chart.hide(dont_want); 
      overall_line_chart.show(want);
    }

  }

  // Toggle charts
  const line_total = document.getElementById("line-total");
  const line_per_person = document.getElementById("line-perperson");

  line_total.onclick = function () {
    toggleDataLine(0, 1);
  }
  line_per_person.onclick = function () {
    toggleDataLine(1, 0);
  }
 
 // Treemap
 

 // chart configurations and options
 const tree_options = {
  type: 'treemap',
  data: get_tree_data('overall'),
  options: {
    legend: {
            display: false },
    plugins: {
           legend: {
            onClick: null,
            labels: {boxWidth: 0   }  },
                    tooltip: {
         enabled: false
      },
      // disables point labels from the datalabels plugin - done differently with treemap (dataset labels as opposed to tree_options options)
      datalabels: {
        display: false
      }
    },
    labels: {
      font: {
        size: inital_treemap_font()
      }
    },
    scales: {
      y: {
        beginAtZero: true
      }
    },
    responsive: true,
    maintainAspectRatio: false
  }
};

const tree_chart = new Chart(ctx_tree,
  tree_options
 );

 // calls the clickHandler function when the treemap is clicked by the user - original function in functions.js
 ctx_tree.onclick = clickHandler;

 // click handler function for treemap levels
function clickHandler(click) {
  const points = tree_chart.getElementsAtEventForMode(click, 'nearest', { intersect: true }, true);
  if (points.length) {

    const firstPoint = points[0];
    tree_value = Object.values(data.overall.tree_data)[firstPoint.index];
    
    let deps = Object.keys(data);
    deps = deps.filter(name => !["_metadata", "overall", "del", "other"].includes(name));
    
    let dep_name;

    for (let i = 0; i < deps.length; i ++) {
       if (Object.values(data[deps[i]].line_data).pop() == tree_value) {
        dep_name = deps[i];
        break
       }
    }

    if (tree_chart.config.data.datasets[0].label2 === 'NI Executive spending total (excluding non ministerial departments)') {
      tree_chart.config.data = get_tree_data(dep_name);
    }

    tree_chart.update();
  }
}

// reset tree map button
function resetChart() {
  tree_chart.config.data = get_tree_data('overall');
  tree_chart.update();
}

reset_treemap = document.getElementById("reset-treemap");
reset_treemap.onclick = function() {
  resetChart()
}

// Bar charts

const ame_bar_chart = declare_bar_chart('ame');
const doh_bar_chart = declare_bar_chart('doh');
const dfc_bar_chart = declare_bar_chart('dfc');
const de_bar_chart = declare_bar_chart('de');
const dfi_bar_chart = declare_bar_chart('dfi');
const doj_bar_chart = declare_bar_chart('doj');
const dfe_bar_chart = declare_bar_chart('dfe');
const dof_bar_chart = declare_bar_chart('dof');
const daera_bar_chart = declare_bar_chart('daera');
const teo_bar_chart = declare_bar_chart('teo');
const other_bar_chart = declare_bar_chart('other');

 // The function for generating the bar chart labels is get_bar_labels()
 // It is used inside both the get_bar_labels() and toggleData() functions
 function get_bar_labels(dep) {

  bar_labels = [];      // Start by setting an empty array "bar_labels", which will be filled with 6 separate arrays for the 6 year's data

  years = Object.keys(data[dep].bar_data);

  // Loop through each year of the dep's data from 1 to 6 (outer loop)
  for (let i = 0; i < years.length; i++) {

    // full_labels = eval(dep + '_year' + i + '_bar_labels');  // Set that year's labels to the value "full_labels"
    full_labels = Object.keys(data[dep].bar_data[years[i]]);

    wrapped_labels = [];                                    // Start with an empty array "wrapped_labels" which will contain the text wrapped versions of the labels in "full_labels"

    // Loop through each of the labels in "full_labels" (inner loop)
    for (let j = 0; j < full_labels.length; j++) {

      // The value "line_break_position" is the character index of the first space after character 27 in the label
      line_break_position = full_labels[j].indexOf(" ", 27);

      // The value "last_space_position" is the character index of the last space in the label
      last_space_position = full_labels[j].lastIndexOf(" ");       

      // If the label is under 27 characters there will be no text wrapping
      if (String(full_labels[j]).length < 27) {
        wrapped_labels[j] = full_labels[j];
      // If the label is over 27 characters but there are no spaces after character 27 then the wrapping will occur at the "last_space_position"
      } else if (line_break_position == -1) {
        wrapped_labels[j] = [full_labels[j].substring(0, last_space_position),
                            full_labels[j].substring(last_space_position)];
      // Otherwise the wrapping will occur at the first space after character 27                      
      } else {
        wrapped_labels[j] = [full_labels[j].substring(0, line_break_position),
                            full_labels[j].substring(line_break_position)];
      }

    }

    bar_labels.push(wrapped_labels);    // At the end of each run of the inner loop the "wrapped_labels" are added to the "bar_labels" array
  }

  return bar_labels; // After the outer loop has run the array "bar_labels" is returned

 }

 // The function that ultimately generates each bar chart is declare_bar_chart()
// It takes the single input: dep (the department name)
function declare_bar_chart (dep) {

  // The value "chart" is created by calling the chart.js command Chart()
  chart  = new Chart(eval('ctx_' + dep + '_bar'), {
    type: 'bar',                    // The type "bar" is selected
    data: get_bar_data(dep),        // data is called using get_bar_data()
    options: set_bar_options(dep)   // set_bar_options is called using set_bar_options()
  });

  return chart;

};

// The function to generate the data for the bar charts is get_bar_data()
// It takes the single input: dep. And it is called inside declare_bar_chart() above.
function get_bar_data (dep) {

  // First the object "bar_data" is defined with two properties: labels and datasets
  bar_data = {
    labels: get_bar_labels(dep).pop(),   // the labels are returned as the 6th element of the array generated by calling the function get_bar_labels() below
    datasets: []                      // The datasets property is initially set to empty
  };

  years = Object.keys(data[dep].bar_data);

  // A loop is used then to generate 6 years worth of data and this is stored in the datasets property of "bar_data"
  for (let i = 0; i < years.length; i++) {
    bar_data.datasets[i] = {
      label: years,               // The label for the year is obtained from the array "line_data_labels"
      data: Object.values(data[dep].bar_data[years[i]]),  // The data is obtained from the array "dep_yeari_bar+data"
      hidden: true,                                 // All bars are initially set to hidden
      backgroundColor: colours[dep],       // The background colour is obtained from the releveant array for that dep
      borderColor: '#000',                          // Border colour is set to black
      borderWidth: 1.5,                             // Border width is set to 1.5
      hoverBorderWidth: 3,                          // Hover border width is set to 3
      hoverBorderColor: '#000'                      // Hover border colour is set to black
    };
  }

  bar_data.datasets[years.length - 1].hidden = false;              // After the loop is finished running the bars for the 6th year have their hidden property set to false

  return bar_data;                                  // The function returns the "bar_data" object

};


  // Year buttons along top of charts

  // toggle function for year selector buttons
function toggleData (btn_id) {

  dep = btn_id.slice(0, btn_id.indexOf("-"));

  years = Object.keys(data[dep].bar_data);
  clicked_year = years.indexOf(btn_id.slice(dep.length + 1));

  canvas_id = dep + "_bar_chart";

  let showValue = eval(canvas_id).isDatasetVisible(clicked_year);
  if (!showValue) {
    eval(canvas_id).data.labels = get_bar_labels(dep)[clicked_year];
    for (let i = 0; i < years.length; i ++) {
      if (i != clicked_year) {
        eval(canvas_id).hide(i);
      }
    }
    eval(canvas_id).show(clicked_year)
  }

}

  const chart_btns = document.querySelectorAll('.chart-btns');
  for (let i = 0; i < chart_btns.length; i ++) {
    dep = chart_btns[i].id.slice(0, chart_btns[i].id.indexOf("-btns"));
    bar_years = Object.keys(data[dep].bar_data);
    for (let j = 0; j < bar_years.length; j ++) {
      input = document.createElement("input");
      input.type = "radio";
      input.classList.add("btn-check");
      input.name = dep + "btnradio";
      input.autocomplete = "off";
      input.id = dep + "-" + bar_years[j];
      input.onclick = function() {
        toggleData(this.id);
      }

      if (j == bar_years.length - 1) {
        input.checked = true;
      }

      label = document.createElement("label");
      label.classList.add("btn");
      label.classList.add("btn-outline-primary");
      label.htmlFor = dep + "-" + bar_years[j];;
      
      label.textContent = bar_years[j];

      chart_btns[i].appendChild(input);
      chart_btns[i].appendChild(label)
    }
  }

}



// copy to clipboard for use in share button function
function copyToClipboard(text) {
  var inputc = document.body.appendChild(
    document.createElement("input")
  );
  inputc.value = window.location.href;
  inputc.select();
  document.execCommand("copy");
  inputc.parentNode.removeChild(inputc);
  alert("URL Copied.");
}

// share button functionality
(function (win, doc) {
  const testButton = doc.createElement("button");
  testButton.setAttribute("type", "share");
  if (testButton.type != "share") {
    win.addEventListener("click", function (ev) {
      ev = ev || win.event;
      let target = ev.target;
      let button = target.closest(
        'button[type="share"]'
      );
      if (button) {
        const title = "Share URL";
        const url = win.location.href;
        if (navigator.share) {
          navigator.share({
            title: title,
            url: url,
          });
        } else {
          copyToClipboard();
        }
      }
    });
  }
})(this, this.document);






// create scaled tree map colours
function colorFromRawfn(ctx_tree, dep) {
  
  if (ctx_tree.type !== 'data') {
    return 'transparent';
  }

  

  const value = ctx_tree.raw.v;
  let alpha = ((value - 0) / (10000));
  if (dep == 'doh') {
    let alpha = ((value - 0) / (5000));
    return `rgba(0, 142, 170, ${alpha})`;//hex code #008eaa
  } else if (dep == 'dfc') {
    let alpha = ((value - 0) / (500));
    return `rgba(125, 85, 199, ${alpha})`;//hex code #7d55c7
  } else if (dep == 'dfe') {
    let alpha = ((value - 0) / (500));
    return `rgba(0, 114, 206, ${alpha})`;//hex code #0072CE
  } else if (dep == 'de') {
    let alpha = ((value - 0) / (1000));
    return `rgba(202, 44, 147, ${alpha})`;//hex code #ca2c93
  } else if (dep == 'dfi') {
    let alpha = ((value - 0) / (1000));
    return `rgba(194, 132, 0, ${alpha})`;//hex code #c28400
  } else if (dep == 'doj') {
    let alpha = ((value - 0) / (500));
    return `rgba(137, 59, 103, ${alpha})`;//hex code #893b67
  } else if (dep == 'dof') {
    let alpha = ((value - 0) / (75));
    return `rgba(137, 144, 100, ${alpha})`;//hex code #899064
  } else if (dep == 'teo') {
    let alpha = ((value - 0) / (100));
    return `rgba(86, 152, 200, ${alpha})`;//hex code #5698c8
  } else if (dep == 'daera') {
    let alpha = ((value - 0) / (500));
    return `rgba(0, 154, 68, ${alpha})`;//hex code #009a44
  } else if (dep == 'ame') {
    let alpha = ((value - 0) / (7000));
    return `rgba(140, 140, 140, ${alpha})`;//hex code #8c8c8c
  } else {
    return `rgba(56, 120, 197, ${alpha})`;//hex code #3878c5
  }
}


// create scaled tree map label colours
function treeLabelColour(ctx_tree, threshold, denominator) {
  if (ctx_tree.type !== 'data') {
    return 'transparent';
  }
  const value = ctx_tree.raw.v;
  
  let alpha = ((value - 0) / (denominator));
  if (alpha > threshold) {
    return `white`
  } else {
    return `black`
  }
}


// sets inital font size for treemap dependent on screen size
function inital_treemap_font() {
  if(window.outerWidth > 850) {
    return[14];
  };
  if(window.outerWidth <= 850 && window.outerWidth > 780) {
    return[12];
  };
  if(window.outerWidth <= 780 && window.outerWidth > 700) {
    return[10];
  };
  if(window.outerWidth <= 700 && window.outerWidth > 600) {
    return[8];
  };
  if(window.outerWidth < 600) {
    return[6];
  };
}

// sets inital font size for tooltip title dependent on screen size - not currently used as tooltips turned off
// function inital_tooltip_font_title() {
//   if(window.outerWidth > 700) {
//     return[16];
//   };
//   if(window.outerWidth <= 700 && window.outerWidth > 600) {
//     return[14];
//   };
//   if(window.outerWidth <= 600 && window.outerWidth > 450) {
//     return[12];
//   };
//   if(window.outerWidth < 450) {
//     return[10];
//   };
// }


// sets inital font size for tooltip body dependent on screen size - not currently used as tooltips turned off
// function inital_tooltip_font_body() {
//   if(window.outerWidth > 700) {
//     return[14];
//   };
//   if(window.outerWidth <= 700 && window.outerWidth > 600) {
//     return[12];
//   };
//   if(window.outerWidth <= 600 && window.outerWidth > 450) {
//     return[10];
//   };
//   if(window.outerWidth < 450) {
//     return[8];
//   };
// }



// screen size responsive fonts - only called on resize so initals need to be set above (search for comment 'chart text defaults before resize' in index.html)
// applies to all charts and all text within unless overridden by individual config (eg treemap labels or tooltip)

// not as important as inital setting on sizes based on screen size as resizing is not a common task,
//most people open in one screen size and this will rescale based on defaults, not on resize



function responsiveFonts() {
  if(window.outerWidth > 850) {
    tree_chart.config.options.labels.font.size = 14
    overall_y_label.style.fontSize = "15px";
  };
  if(window.outerWidth <= 850 && window.outerWidth > 780) {
    tree_chart.config.options.labels.font.size = 12
    overall_y_label.style.fontSize = "15px";
  };
  if(window.outerWidth <= 780) {
    tree_chart.config.options.labels.font.size = 10
  };
  if(window.outerWidth < 600) {
    tree_container.style.cssText = "height: 80vh;"
  } else {
    tree_container.style.cssText = "height: " + Math.round(tree_container.clientWidth / 2) + "px;";
  };
  if(window.outerWidth > 700) {
    Chart.defaults.font.size = 16;
    // bar_options.plugins.tooltip.titleFont.size = 16;
    // bar_options.plugins.tooltip.bodyFont.size = 14;
    // line_options.plugins.tooltip.titleFont.size = 16;
    // line_options.plugins.tooltip.bodyFont.size = 14;
    // overall_line_options.plugins.tooltip.titleFont.size = 16;
    // overall_line_options.plugins.tooltip.bodyFont.size = 14;
  };
  if(window.outerWidth <= 700 && window.outerWidth > 600) {
    Chart.defaults.font.size = 14;
    // bar_options.plugins.tooltip.titleFont.size = 14;
    // bar_options.plugins.tooltip.bodyFont.size = 12;
    // line_options.plugins.tooltip.titleFont.size = 14;
    // line_options.plugins.tooltip.bodyFont.size = 12;
    // overall_line_options.plugins.tooltip.titleFont.size = 14;
    // overall_line_options.plugins.tooltip.bodyFont.size = 12;
  };
  if(window.outerWidth <= 600 && window.outerWidth > 450) {
    Chart.defaults.font.size = 12;
    overall_y_label.style.fontSize = "12pt";
    // bar_options.plugins.tooltip.titleFont.size = 12;
    // bar_options.plugins.tooltip.bodyFont.size = 10;
    // line_options.plugins.tooltip.titleFont.size = 12;
    // line_options.plugins.tooltip.bodyFont.size = 10;
    // overall_line_options.plugins.tooltip.titleFont.size = 12;
    // overall_line_options.plugins.tooltip.bodyFont.size = 10;
  };
  if(window.outerWidth < 450) {
    Chart.defaults.font.size = 8;
    overall_y_label.style.fontSize = "8pt";
    // bar_options.plugins.tooltip.titleFont.size = 10;
    // bar_options.plugins.tooltip.bodyFont.size = 8;
    // line_options.plugins.tooltip.titleFont.size = 10;
    // line_options.plugins.tooltip.bodyFont.size = 8;
    // overall_line_options.plugins.tooltip.titleFont.size = 10;
    // overall_line_options.plugins.tooltip.bodyFont.size = 8;
  };
}



// Bar Chart functions

// The other function that is called inside declare_bar_chart() is set_bar_options()
// set_bar_options() takes the single argument: dep
function set_bar_options (dep) {

  // This function returns the object bar_options
  bar_options = {
    hover : false ,                   // The hover mode is turned off
    maintainAspectRatio: true,        // Chart is set to maintain aspect ratio of 2:1
    scales: {
      y: {
        grid: { display: false },     // Grid lines are turned off for the y axis
        ticks: {
          autoSkip: false             // No tickmarks are skipped
        }
      },
      x: { offset: false,            // ensures no extra space added to the left edge of the x axis 
          title: {
            display: true,          // Display a title on the x axis
            text: 'Total spend'     // Set title text
          } ,
          
        ticks: {
          callback: function(label, index, labels) {
            return '£' + Number(label).toLocaleString('en') + 'm';   // Adds £ sign and millions units to x axis labels
          },
          autoSkip: true,             // Will skip some ticks if labels become too crowded
          maxRotation: 0,             // Block rotation of tick labels
          minRotation: 0
        },
          min: 0,                     // x axis always starts at zero
          max: x_bar_range(dep),     // x axis max value is set to value returned by x_bar_range() function. See below.
      }
    },
    
    indexAxis: 'y',     // flips vertical bar chart to horizontal
    plugins: {
      tooltip: { enabled: false } ,   // Remove tooltips
      legend: {
        display: false                // Remove legend
      },
      datalabels: {
        color: '#000000',            // Data labels colour black
        display: true,               // Display data labels
        anchor: 'end',               // Position data labels
        align: 'end',                // Position data labels
        formatter: function(value) {
          return ['£' + Number(value).toLocaleString('en') + 'm'];  // Format data labels to have £ sign and millons units
        } 
      }
      // this title shrinks with the other chart text unlike h4 tags but perhaps accessibility is better with h4?
      // title: {
      //   display: true,
      //   text: 'Chart Title',
      //   align: 'start'
      // }
    },
    layout: {
      padding: {
        right: 100 //Adds 100px of padding to right hand side to ensure £m fully shows
      }
    }
  };

  return bar_options

}

// This function is used to calculate the max value of the x axis for bar charts
function x_bar_range (dep) {

  years = Object.keys(data[dep].bar_data);

  // Start with an empty array "values". The max bar height for each year will be added to the array
  values = [];

  // Loop through the 6 years of data for each year
  for (let i = 0; i < years.length; i++) {
    year_values = Object.values(data[dep].bar_data[years[i]]);
    for (let j = 0; j < year_values.length; j ++) {
      values.push(year_values[j]);
    }
  }

  // Return the max value of the "values" array
  max_value = Math.max(...values);

  // If the max value is between £0m-£100m then round up to the nearest £10m
  if (max_value < 100) {
    return(Math.ceil(max_value / 10)) * 10;
  // Else the max value is between £101m-£1000m then round up to the nearest £100m
  } else if (max_value < 1000) {
    return(Math.ceil(max_value / 100)) * 100;
  // Otherwise round up to the nearest £500m
  } else {
    return(Math.ceil(max_value / 500)) * 500;
  }

}



// Function to define treemaps. Using one input: dep
function get_tree_data (dep) {

  // The "label_words" object defines the label that will appear at top of treemap when each dep is clicked on
  label_words = {
      ame: 'AME',
      doh: 'Health DEL',
      dfc: 'Communities DEL',
      de: 'Education DEL',
      dfi: 'Infrastructure DEL',
      doj: 'Justice DEL',
      dfe: 'Economy DEL',
      dof: 'Finance DEL',
      daera: 'Agriculture, Environment and Rural Affairs DEL',
      teo: 'TEO DEL'
    }

  // The object "tree_data" is defined
  tree_data = {
    labels: Object.keys(data[dep].tree_data),     // The labels are defined as the dep's tree_labels value

    datasets: [{
      tree: Object.values(data[dep].tree_data),       // The tree data for the dep is read in
      labels: {
        display: true,                      // Labels are displayed
        align: 'center',                    // And centre aligned
        position: 'center',
        formatter: (ctx_tree) => {
          // Calculate the maximum characters per line based on the box width
          const chars_per_line = Math.max(1, Math.round(ctx_tree.raw.w / 10)); // Ensure at least 1 char/line
          const original_label = tree_data.labels[ctx_tree.index];
          
          // Split the label into multiple lines based on chars_per_line
          const splitLabel = (label, maxChars) => {
            const lines = [];
            let start = 0;
        
            while (start < label.length) {
              let end = start + maxChars;
              
              // Ensure we don't cut off mid-word, adjust to nearest space if possible
              if (end < label.length && label[end] !== ' ') {
                const spaceIndex = label.lastIndexOf(' ', end);
                if (spaceIndex > start) {
                  end = spaceIndex;
                }
              }
        
              lines.push(label.substring(start, end).trim()); // Push the line, trimmed of any leading/trailing spaces
              start = end; // Move to the next character (skip the space automatically)
              if (label[start] === ' ') start++; // Skip an extra space, if present
            }
        
            return lines;
          };
        
          // Split the original label
          const labelLines = splitLabel(original_label, chars_per_line);
        
          // Add value as the last line (formatted)
          const valueLine = `£${Number(ctx_tree.raw.v.toFixed(0)).toLocaleString('en')}m`;
          labelLines.push(valueLine);
        
          return labelLines.filter((line) => line); // Filter out any empty lines
        }
        
      },
      borderWidth: 1,        // Border is given width 1
      hoverBorderWidth: 3,  // Border on hover is given width 3
      hoverBorderColor: '#000', // Border is given colour black on hover
      spacing: 1               // Spacing between rectangles is 1
    }]
  }

  // The if/else tree below will apply different settings for the overall treemap and the individual departmental ones
  if (dep == "overall") {

    // colour array used to colour top level of treemap
    var colourArray = []

    for (let i = 0; i < tree_data.labels.length; i++) {
      if (tree_data.labels[i] == "Benefits and pensions (AME)") {
        colourArray.push(`rgba(140,140,140,1)`);
      } else {
        colourArray.push(`rgba(54,162,235,1)`)
      }
    }
    
    // Colours are set using value of "colourArray"
    tree_data.colours = colourArray;

    // The top label is calculated as the total spending
    tree_data.datasets[0].label = ['NI Executive ' + spend_type_capitalised + 'spending total (excluding non ministerial departments) = £' +
    Number(Object.values(data.ame.line_data).pop() + 
            Object.values(data.doh.line_data).pop() + 
            Object.values(data.dfc.line_data).pop() + 
            Object.values(data.de.line_data).pop() + 
            Object.values(data.dfi.line_data).pop() + 
            Object.values(data.doj.line_data).pop() + 
            Object.values(data.dfe.line_data).pop() + 
            Object.values(data.daera.line_data).pop() + 
            Object.values(data.teo.line_data).pop() + 
            Object.values(data.dof.line_data).pop()).toLocaleString(undefined,{'minimumFractionDigits':0}) + 'm¹'];
    tree_data.datasets[0].label2 = 'NI Executive spending total (excluding non ministerial departments)';

    // Background colour is set
    tree_data.datasets[0].backgroundColor = function(context) {
      var index = context.dataIndex % colourArray.length;
      return colourArray[index];
    };

    // Border colour is set to white
    tree_data.datasets[0].borderColor = '#ffffff';
    
  } else { // For deparments apply these settings:

    // For departments the top label is set
    tree_data.datasets[0].label = [label_words[dep] + ' ' + spend_type_capitalised + 'spending total = £' + 
      Number(Object.values(data[dep].line_data).pop()).toLocaleString(undefined,{'minimumFractionDigits':0}) + 'm'];

      // Background colours for departments are set here
    tree_data.datasets[0].backgroundColor = (ctx_tree) => colorFromRawfn(ctx_tree, dep);

    // Border colour is set to black
    tree_data.datasets[0].borderColor = '#000';

  }

  // Some departments require white text when background colours are too dark
  if (dep == 'ame') {
    tree_data.datasets[0].labels.color = (ctx_tree) => treeLabelColour(ctx_tree, 0.7, 7000);
  } else if (dep == 'de') {
    tree_data.datasets[0].labels.color = (ctx_tree) => treeLabelColour(ctx_tree, 0.7, 1000);
  } else if (dep == "dfi") {
    tree_data.datasets[0].labels.color = (ctx_tree) => treeLabelColour(ctx_tree, 0.8, 1000);
  } else if (dep == "doj") {
    tree_data.datasets[0].labels.color = (ctx_tree) => treeLabelColour(ctx_tree, 0.5, 500);
  } else if (dep == "dfe") {
    tree_data.datasets[0].labels.color = (ctx_tree) => treeLabelColour(ctx_tree, 0.9, 500);
  }

  return tree_data;

};

function downloadChart(chart, yLabel = null, title = null, btns = null) {
  // Get the chart's canvas element.
  const sourceCanvas = chart.canvas || chart;
  const width = sourceCanvas.width;
  const height = sourceCanvas.height;
  
  // Define padding values.
  const sidePadding = 15;   // left/right padding remains 25px
  const topPadding = 65;    // top padding is increased to 45px (25 + 20)
  const bottomPadding = 15; // bottom padding remains 25px

  // Retrieve label text if yLabel is provided (as an element id)
  let labelText = null;
  if (yLabel !== null) {
    const labelElement = document.getElementById(yLabel);
    if (labelElement) {
      labelText = labelElement.textContent;
    }
  }

  // Retrieve title text if title is provided (as an element id)
  let titleText = null;
  if (title !== null) {
    const titleElement = document.getElementById(title);
    if (titleElement) {
      titleText = titleElement.textContent;
    }
  }

  // Retrieve button text if provided
  let buttonText = null;
  if (btns !== null) {
    const btns_div = document.getElementById(btns);
    const inputs = btns_div.getElementsByTagName("input");
    for (let i = 0; i < inputs.length; i ++) {
      if (inputs[i].checked) {
        buttonText = inputs[i].id.slice(inputs[i].id.indexOf("-") + 1);
        break;
      }
    }
  }

  if (buttonText !== null) {
    titleText += ` ${buttonText}`;
  }

  if (titleText !== null) {
    fileName = `${titleText.toLowerCase().replaceAll(" ", "-")}.png`
  } else {
    fileName = "ni-executive-spending-treemap.png"
  }

  // Helper function to draw the title and/or label text, then trigger the download.
  function drawTextAndDownload(ctx, canvasToDownload) {
    if (titleText && labelText) {
      // Draw yLabel: 15px sans-serif, grey.
      ctx.fillStyle = 'grey';
      ctx.font = '15px sans-serif';
      ctx.textBaseline = 'bottom';
      // The bottom edge of yLabel aligns with the top edge of the chart (topPadding).
      ctx.fillText(labelText, sidePadding, topPadding + 15);
      
      // Draw title: 1rem sans-serif, black, 10px above yLabel.
      ctx.fillStyle = 'black';
      ctx.font = 'bold 1rem sans-serif';
      ctx.textBaseline = 'bottom';
      ctx.fillText(titleText, sidePadding, topPadding - 25);
    } else if (labelText) {
      ctx.fillStyle = 'grey';
      ctx.font = '15px sans-serif';
      ctx.textBaseline = 'bottom';
      ctx.fillText(labelText, sidePadding, topPadding + 15);
    } else if (titleText) {
      ctx.fillStyle = 'black';
      ctx.font = 'bold 1rem sans-serif';
      ctx.textBaseline = 'bottom';
      ctx.fillText(titleText, sidePadding, topPadding - 25);
    }
    
    const imageData = canvasToDownload.toDataURL('image/png');
    const link = document.createElement('a');
    link.href = imageData;
    link.download = fileName;
    document.body.appendChild(link);
    link.click();
    document.body.removeChild(link);
  }

  // Load the watermark image.
  const watermark = new Image();
  watermark.src = 'nisra-only-colour.png';

  watermark.onload = function() {
    const wmWidth = watermark.width;
    const wmHeight = watermark.height;

    // New canvas dimensions:
    // width: original width + left & right sidePadding.
    // height: topPadding + original chart height + bottomPadding + watermark height.
    const newWidth = width + sidePadding * 2;
    const newHeight = topPadding + height + bottomPadding + wmHeight;

    const extendedCanvas = document.createElement('canvas');
    extendedCanvas.width = newWidth;
    extendedCanvas.height = newHeight;
    const ctx = extendedCanvas.getContext('2d');

    // Fill the entire canvas with a white background.
    ctx.fillStyle = '#ffffff';
    ctx.fillRect(0, 0, newWidth, newHeight);

    // Draw the original chart offset by sidePadding and topPadding.
    ctx.drawImage(sourceCanvas, sidePadding, topPadding);

    // Place the watermark at the bottom right of the chart area.
    // The watermark is drawn within the padded area below the chart.
    const x = sidePadding + (width - wmWidth);
    const y = topPadding + height;
    ctx.drawImage(watermark, x, y, wmWidth, wmHeight);

    // Draw the optional title and/or label, then trigger the download.
    drawTextAndDownload(ctx, extendedCanvas);
  };

  // Fallback: if the watermark fails to load, export the chart with padding and text only.
  watermark.onerror = function(error) {
    console.error("Watermark image failed to load:", error);
    const newWidth = width + sidePadding * 2;
    const newHeight = topPadding + height + bottomPadding;
    const tempCanvas = document.createElement('canvas');
    tempCanvas.width = newWidth;
    tempCanvas.height = newHeight;
    const tempCtx = tempCanvas.getContext('2d');

    tempCtx.fillStyle = '#ffffff';
    tempCtx.fillRect(0, 0, newWidth, newHeight);
    tempCtx.drawImage(sourceCanvas, sidePadding, topPadding);

    if (titleText || labelText) {
      if (titleText && labelText) {
        tempCtx.fillStyle = 'grey';
        tempCtx.font = '15px sans-serif';
        tempCtx.textBaseline = 'bottom';
        tempCtx.fillText(labelText, sidePadding, topPadding);
        tempCtx.fillStyle = 'black';
        tempCtx.font = '1rem sans-serif';
        tempCtx.textBaseline = 'bottom';
        tempCtx.fillText(titleText, sidePadding, topPadding - 10);
      } else if (labelText) {
        tempCtx.fillStyle = 'grey';
        tempCtx.font = '15px sans-serif';
        tempCtx.textBaseline = 'bottom';
        tempCtx.fillText(labelText, sidePadding, topPadding);
      } else if (titleText) {
        tempCtx.fillStyle = 'black';
        tempCtx.font = '1rem sans-serif';
        tempCtx.textBaseline = 'bottom';
        tempCtx.fillText(titleText, sidePadding, topPadding - 10);
      }
    }

    const imageData = tempCanvas.toDataURL('image/png');
    const link = document.createElement('a');
    link.href = imageData;
    link.download = fileName;
    document.body.appendChild(link);
    link.click();
    document.body.removeChild(link);
  };
}

let spend_type_capitalised = '';

function getSpendType() {
  const current_url = window.location.href;
  if (current_url.indexOf("?") > -1) {
    let spend_type = current_url.slice(current_url.indexOf("=") + 1);
    if (spend_type.indexOf("#") > -1) {
      spend_type = spend_type.slice(0, spend_type.indexOf("#"));
    }
    getData(spend_type);
    spend_type_capitalised = `${spend_type.charAt(0).toUpperCase() + spend_type.slice(1)} `;
    document.getElementsByTagName("title")[0].textContent = `NI Executive ${spend_type_capitalised}Spending`;
    const spend_elements = document.getElementsByClassName("spend-type");
    for (let i = 0; i < spend_elements.length; i ++) {
      spend_elements[i].textContent = spend_type_capitalised;
    }
    if (spend_type == "capital") {
      document.getElementById("whatIsIncluded").innerHTML += '<li style="font-size: 0.75rem; list-style-type: square;"><strong>Investments</strong></li>'
    } else if (spend_type == "resource") {
      document.getElementById("whatIsIncluded").innerHTML += '<li style="font-size: 0.75rem; list-style-type: square;"><strong>Public services</strong> that NI departments make decisions on</li> <li style="font-size: 0.75rem; list-style-type: square;"><strong>Benefits and pensions</strong></li>'
    }
  } else {
    getData("all")
    document.getElementById("whatIsIncluded").innerHTML += '<li style="font-size: 0.75rem; list-style-type: square;"><strong>Public services</strong> that NI departments make decisions on</li> <li style="font-size: 0.75rem; list-style-type: square;"><strong>Investments</strong></li> <li style="font-size: 0.75rem; list-style-type: square;"><strong>Benefits and pensions</strong></li>'
  }
}