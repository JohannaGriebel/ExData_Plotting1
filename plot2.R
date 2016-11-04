#read in neccessary packages
library(data.table)
library(lubridate)
#set directory
path<-setwd("~/ExData_Plotting1")
path

#download data and unpack it
url<- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url, "powerconsumption.zip")
unzip(zipfile="./powerconsumption.zip",exdir=path)

#read in file as data table
power<-fread("household_power_consumption.txt", na.strings="?")

#check for Data and Time
head(power)

#change class to Date for Time and Date and merge both

power$DateTime <- with(power, as.POSIXct(paste(Date, Time), format="%d/%m/%Y %H:%M:%S"))
power$Date<-dmy(power$Date)
power$Time<-hms(power$Time)


#subset from 2007-02-01 to 2007-02-02
powerfeb<-subset(power, Date >= "2007-02-01" & Date <= "2007-02-02")

#open png device
png(file="plot2.png", width=480, height=480)

#create line graph
with(powerfeb, plot(DateTime,Global_active_power, 
                    #defines line graph
                    type="l", 
                    # change the x and y axis
                    xlab="", 
                    ylab="Global Active Power (kilowatts)"))
#close device
dev.off()