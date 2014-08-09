
##################
## File Loading ##
##################
##use package sqldf to filter the date when loading the data into R session
library(sqldf)

## download the file and unzip
fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileURL, destfile="./exdata_household_power_consumption.zip", method="curl",quiet=TRUE)
unzip("./exdata_household_power_consumption.zip")

## load data using read.csv2.sql function from the sqldf
filename<-"./household_power_consumption.txt"
f<-file(filename)
dat<-read.csv2.sql(filename, sql="select * from f where Date='1/2/2007' or Date='2/2/2007'", na.strings="?", colClasses=c("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric"))
close(f)

## format Date Time columns
dat$Date <- strptime(paste(dat$Date,dat$Time), "%d/%m/%Y %H:%M:%S")

####################
## Generate Plot2 ##
####################
plot(dat$Date, dat$Global_active_power,type="l",ylab="Global Active Power (kilowatts)",xlab="")
dev.copy(png,file="plot2.png")
dev.off()
