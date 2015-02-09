
## File: plot4.R


## PA 1 - Course Project - DS4
## Exploratory Data Analysis

## Course ID: exdata-011

## https://class.coursera.org/exdata-011/human_grading
## Go to assignment -> https://class.coursera.org/exdata-011/human_grading/view/courses/973505/assessments/3/submissions

setwd("C:/Users/wbflaptop/Google Drive/edu-COURSERA - Data Science 4 Exploratory Data Analysis/Coursera-WD - DS4/PA 1 - Course Project - DS4")

## Download data file
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, destfile = "./data/exdata-data-household_power_consumption.zip", method = "auto")
dateDownloaded <- date()

## Extract the data from the .zip file
?unzip ## get help on zipfiles
## http://stat.ethz.ch/R-manual/R-devel/library/utils/html/unzip.html
## http://www.r-bloggers.com/read-compressed-zip-files-in-r/

unzip("./data/exdata-data-household_power_consumption.zip", 
      exdir = "./data/Dataset") 
## extract contents from single zip file into Data folder in WD

## Check contents of the unziped folder 
list.files("./data")
list.files("./data/Dataset")

## Loading the data

## 1
## 
## The dataset has 2,075,259 rows and 9 columns. 
## First calculate a rough estimate of how much memory the dataset will 
## require in memory before reading into R. 
## Make sure your computer has enough memory (most modern computers should be fine). 

## # rows * # columns * 8 bytes / 2^20
## 2,075,259 rows * 9 columns * 8 bytes / 2^20
memoryNeed <- 2075259 * 9 * 8 / 2^20
print(memoryNeed) 
## This gives us the number of megabytes of the data frame 
## (roughly speaking, it could be less). 
## If this number is more than half the amount of memory on your computer, 
## then you might run into trouble.
# > print(memoryNeed)
# [1] 142.4967
# > 

## 2
## 
## We will only be using data from the dates 2007-02-01 and 2007-02-02. 
## One alternative is to read the data from just those dates rather than 
## reading in the entire dataset and subsetting to those dates.

?read.csv
mydata <- read.csv("./data/Dataset/household_power_consumption.txt", 
                   header = T, sep = ";", 
                   na.strings = "?", 
                   nrows = 2075259, 
                   check.names = F, 
                   stringsAsFactors = F, 
                   comment.char = "", 
                   quote = '\"')


## Date: Date in format dd/mm/yyyy
## Time: time in format hh:mm:ss

str(mydata)
## > str(mydata)
## 'data.frame':        2075259 obs. of  9 variables:
## $ Date                 : chr  "16/12/2006" "16/12/2006" "16/12/2006" "16/12/2006" ...
## $ Time                 : chr  "17:24:00" "17:25:00" "17:26:00" "17:27:00" ...
## $ Global_active_power  : num  4.22 5.36 5.37 5.39 3.67 ...
## $ Global_reactive_power: num  0.418 0.436 0.498 0.502 0.528 0.522 0.52 0.52 0.51 0.51 ...
## $ Voltage              : num  235 234 233 234 236 ...
## $ Global_intensity     : num  18.4 23 23 23 15.8 15 15.8 15.8 15.8 15.8 ...
## $ Sub_metering_1       : num  0 0 0 0 0 0 0 0 0 0 ...
## $ Sub_metering_2       : num  1 1 2 1 1 2 1 1 1 2 ...
## $ Sub_metering_3       : num  17 16 17 17 17 17 17 17 17 16 ...
## > 

mydata$Date <- as.Date(mydata$Date, format = "%d/%m/%Y")


dataSelection <- subset(mydata, subset = (Date >= "2007-02-01" & Date <= "2007-02-02"))
## Subsetting the data

rm(mydata)

head(dataSelection)
head(dateTime)

## Converting dates 
dateTime <- paste(as.Date(dataSelection$Date), dataSelection$Time)
dataSelection$DateTime <- as.POSIXct(dateTime)

head(dataSelection)

## Making Plots 
## using the base plotting system 
## how household energy usage varies over a 2-day period in February, 2007


## Plot 4

png(file = "./plot4.png")
par(mfrow = c(2,2), mar = c(4,4,2,1), oma = c(0,0,2,0))
with(dataSelection, {
        plot(Global_active_power ~ DateTime, type = "l", 
             ylab = "Global Active Power", xlab = "")
        plot(Voltage ~ DateTime, type = "l", ylab = "Voltage", xlab = "DateTime")
        plot(Sub_metering_1 ~ DateTime, type = "l", ylab = "Energy sub metering",
             xlab = "")
        lines(Sub_metering_2 ~ DateTime, col = "Red")
        lines(Sub_metering_3 ~ DateTime, col = "Blue")
        legend("topright", col = c("black", "red", "blue"), lty = 1, lwd = 2, 
               bty = "n",
               legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
        plot(Global_reactive_power ~ DateTime, type = "l", 
             ylab = "Global_rective_power", xlab = "DateTime")
})
dev.off()










 
