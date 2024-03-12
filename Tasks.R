#### TASK SCRIPT ####

### 1. Load required package ###

install.packages("taskscheduleR")
library(taskscheduleR)


### 2. Create and initiate the task ###

myscript <- paste(getwd(), "Scraping.R", sep = "/")
getwd()

taskscheduler_create(taskname = "30_min_task", 
                     rscript = myscript, 
                     schedule = "MINUTE", 
                     starttime = "08:30",
                     modifier = 30)


# Be aware: if you are having problems reading the task file, you might try introducing the path manually, as in the following example:

taskscheduler_create(taskname = "30_min_task", 
                     rscript = "C:/Users/aleco/AppData/Local/R/win-library/4.3/taskscheduleR/extdata/Scraping.R", 
                     schedule = "MINUTE", 
                     starttime = "08:33",
                     modifier = 30)


### 3. Finalize the task ###

Sys.sleep(3600 * hours_to_wait) # Replace hours_to_wait with the number of hours you want to wait


### 3. Delete the ongoing task  ###

taskscheduler_delete(taskname = "30_min_task")


### 4. Check for the current running tasks (if needed)

running_tasks <- system("schtasks /query /fo LIST /v", intern = TRUE)
print(running_tasks)



