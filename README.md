---
editor_options: 
  markdown: 
     justify: true
---

```{=html}
<style>
body {
text-align: justify}
</style>
```
## Data Harvesting: Scraping stock market indexes across Europe

This work aims to scrape several indexes across various European stock markets by applying a task scheduler to automate the scraping process. Data is obtained from two financial platforms: [Yahoo Finance](https://es.finance.yahoo.com/) and [Investing](https://www.investing.com/), which provide real-time market quotes, information about stocks, futures, options, analysis, and commodities. The selected European indexes are IBEX 35, DAX, CAC 40, FTSE 100, ATX, BFX as well as the principal indexes in the world (NASDAQ 100, S&P500, NIKKEI 225, HIS...)

------------------------------------------------------------------------

\

### **Goal**

Given the volatility of stock prices, this project aims to collect historical data to show the hourly evolution of stock prices. It is particularly useful for those interested in understanding the behavior of various European markets throughout the day. The goal of the project is to effectively apply web scrapping tools and automate the data extraction process, facilitating the acquisition of updated data from European markets.

\

### **Description**

Our project focuses on three key steps:

1.  **Data Scraping and Data Cleaning**: The first step involves scraping the required data from financial websites to obtain the indexes of interest. After the data is scraped, a cleaning process is applied to facilitate its use and simplify the analysis.

2.  **Task Scheduling**: The second step is to set up a task scheduler. This scheduler will iteratively execute the script containing the scraping and cleaning processes during the day at fixed intervals. The resulting data will be automatically saved into separate CSV files.

3.  **Data Visualization**: Lastly, the data obtained from the CSV files is used to create visualizations. These visualizations plot the evolution of the indexes over certain periods of time, allowing to track stock market trends and facilitating decision-making.

\
**Please be aware**: we highly recommend [locating every script in the same file]{.underline} and ensuing that you [set it as your current working directory for the entire process.]{.underline}

\

#### **1. Data Scraping and Data Cleaning**

The code corresponding to the two first steps can be found in the `Scraping.R Script`, which contains the scraping code to be executed through the task scheduler. This script contains the essential code required to scrap and clean the stock indexes, with just brief explanations (concise notations with prefixed with a \# symbol), given that is the required format to be iteratively executed with the task scheduler.

For this reason, we complement the previous script with a more detailed and organized markdown script named `Scraping_manual.Rmd`. This script contains the same code as the `Scraping.R Script` but includes additional step-by-step explanations for each of the stock markets, allowing for a better understandability of the scraping and cleaning process (such as the use of regular expression, data transformation, tables selection...). While this R Markdown script cannot be used with the task scheduler due to its format, it can be used as a resource for manual executions, providing real-time results at the time of execution.

\

#### **2. Task Scheduling**

Since we're working with Windows, the package `taskscheduleR` has been used to automate the process. This package enables the scheduling of R scripts with the Windows task scheduler, allowing R users working on Windows to automate R processes, what we refer to as *tasks*, at specific timepoints directly from R itself. Documentation about the functioning of this package has been obtained from the [CRAN](https://cran.r-project.org/package=taskscheduleR) webpage, found under the [Reference Manual](https://cran.r-project.org/web/packages/taskscheduleR/taskscheduleR.pdf) section.

In this context, a task essentially consists of a script with R code that is executed through an R script. In our project, the task is located in the script `Tasks.R`, where we have configurate the starting execution time at 08:30 AM, corresponding to the opening time of the stock market (starttime = 08:30), and to repeat the execution at intervals of 30 minutes (schedule = MINUTE and modifier = 30).\
\

In this step, two scrips are involved:

1.  `Scraping.R` (the script containing the web scrapping code)
2.  `Tasks.R` (the script that automates the process and runs the code contained in `Scraping.R`)

\
**Scraping.R file:**

Given that we are interested in saving the results of every execution for every stock market scraped, we need to ensure that each time the script runs, it generates independent CSV files and saves them locally.

To prevent the the overlap of previous data with each new execution, we must be careful when naming the CSV files in the `Scraping.R Script`. To achieve this, we introduce a new variable containing the current date and name within the CSV filename. This step enables us to differentiate each execution, thereby avoiding the overwriting of previously generated data, as it is specified as follows:

First, the following line code creates a variable named **`timestamp`** and assigns it the current date and time in a specific format. After executing this line, the **`timestamp`** variable will hold the current date and time in the specified format.

```         
timestamp <- format(Sys.time(), "%Y%m%d_%H%M%S")`
```

\
Then, in the next line the function write.csv() saves the scrapped table to a CSV file with an specific filename. The **`paste0()`** function is also used to concatenate our directory path (where the data will be stored, the **`timestamp`** variable (which holds the current timestamp), and the file extension **`".csv"`**. This results in a unique file path and name for the CSV file, which includes the time of the execution.

We have indicated a **path** where the CSV files are stored. Please ensure to change the provided path (writen below as path/to/your/file) with the one corresponding to your working directory. Repeat this step for every stock market index.

```         
write.csv(index_table, paste0("C:/path/to/your/file/world_index", timestamp, ".csv"), row.names = FALSE)
```

**WARNING**: Make sure you do NOT change the last part of the path "/world_index". Each index has an specific name that cannot be modified, otherwise, the generated CSV files will be overwritten in each execution. This part can be found at the end of the `Scraping.R Script.`

\

**Tasks.R file:**

In particular, the specific task created for this work will look as follows:

\

Automatic call for the repository^1^, where a path is automatically generated to the "Scraping.R" script within the current working directory:

```         
 myscript <- paste(getwd(), "Scraping.R", sep = "/") 
```

\

Creation of the task with the specified arguments:

```         
taskscheduler_create(taskname = "30_min_task",
                     rscript = myscript, 
                     schedule = "MINUTE",
                     starttime = "08:30", 
                     modifier = 30) 
```

^[1]{style="font-size: smaller;"}^ [We have automated the repository to avoid the need for manual adjustments in this step. However, if the automatic call for the repository is causing errors, you can try skipping this step and directly running the taskcheduler_create() function, specifying rscript = path/to/your/Scraping.R.]{style="font-size: smaller;"}

\
\
Some other useful functions we needed to apply when learning to work with an R script and the Windows Task Scheduler are:

1.  **`taskscheduler_delete()`**: This function allows you to delete a specific task that was previously scheduled in the Windows Task Scheduler. You can specify the task name or path as an argument to remove it: taskscheduler_delete("name_of_the_task"). This function is important to be able to schedule the same task again, otherwise the console will constantly return an error when trying to execute the task.

2.  **`running_tasks <- system("schtasks /query /fo LIST /v", intern = TRUE)`**: This command executes a system call to query the current tasks scheduled in the Windows Task Scheduler. The output is stored in the variable **`running_tasks`** and is very useful when you need to check which tasks have been scheduled, as sometimes it might be difficult to know whether a task have been already executed or not.

\

\

#### **3. Data Visualization**

The code corresponding to the third step can be found in the **`Stock Markets.Rmd`** script, which contains all the CSV files we have scraped, including tables and visualizations that we have created for the desired analysis. In this part of the project one script is involved:

\

1.  `Stock Markets.Rmd` (where the output[csv files] are used to generate visualizations)

\

Note that the script `StockMarket.Rmd` must be located in the same path as the generated CSV files to successfully read the scraped output. It's recommended to save all files in the current working directory.

Using regular expressions, every CSV can be read at the same time:

```         
csv_world \<- list.files(pattern = "\^world.\*\\.csv\$", full.names = TRUE) 
list_world \<- lapply(csv_world, read_csv)                                  
data_world\<- do.call(rbind, list_world) data_world    
```

\

Finally, some visualizations will be generated with the scraped output to analyze the daily performance of the selected indexes.

\

### **Installation and Usage**

1.  Download the required scripts.

    -   `Scraping.R` - specify your directory path in the write.csv() function to ensure that the future generated CSV files are saved there.

    -   `Tasks.R`

    -   `StockMarkets.Rmd`

2.  Save the three previous scripts in the same folder and set it as your working directory for the following steps.

3.  Install the package `taskscheduleR` and run `Tasks.R Script`^1^.

4.  Run the `StockMarket.Rmd Script`.

5.  (Optional step). For manual web scraping without involving the Task Scheduler for Windows, download the `Scraping_manual.Rmd` script and execute it. This will generate single CSV files for each stock market and automatically store them in your local repository (Remind to change the provided path with your own working directory path). Run this script as many times as needed to obtain indexes at different periods of the day. Subsequently, execute the `StockMarket.Rmd` file to visualize the previously scraped data.

    \

^1^ Before running the task, you can adjust the arguments schedule, starttime, and modifier according to preferences. For a quick test, you can set the following arguments: schedule = "ONCE", starttime = format(Sys.time() + 60, "%H:%M"). This will run the task just once in the next minute, which should be enough to generate CSVs files.\
\
\

------------------------------------------------------------------------

This project is part of the Data Harvesting course in the [Computational Social Science Master's](https://www.uc3m.es/master/computational-social-science) program.

Authors: Alejandra Costa Mazón and María Jurado Millán.
