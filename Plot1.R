library(dplyr)

#Downloads and unzips the data if it does not already exists. 
URL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
file <- "exdata-data-household_power_consumption.zip"

if(!file.exists(file)){
  download.file(URL, file, method="curl")
}
if (!file.exists("household_power_consumption.txt")) { 
  unzip(file)
}

file <- "household_power_consumption.txt"

##reads the table and strips it down to only the two dates.
data<-read.csv(file,header = T,sep = ";", stringsAsFactors=F)
data$Date <- as.Date(data$Date, format="%d/%m/%Y")
##use dplyr to filter the data to desired dates.
subdata<-filter(data,(Date=="2007-02-01" | Date=="2007-02-02"))
rm(data)

#creates the plot
hist(as.numeric(subdata$Global_active_power), main="Global Active Power", xlab = "Global Active Power (kilowatts)", col = "Red", ylab = "Frecuency")

#Exports the plot
dev.copy(png, file="plot1.png", height=480, width=480)
dev.off()
