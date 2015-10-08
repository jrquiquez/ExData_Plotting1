library(dplyr)

URL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
file <- "exdata-data-household_power_consumption.zip"

if(!file.exists(file)){
  download.file(URL, file, method="curl")
}
if (!file.exists("household_power_consumption.txt")) { 
  unzip(file)
}

file <- "household_power_consumption.txt"

data<-read.csv(file,header = T,sep = ";", stringsAsFactors=F)
data$Date <- as.Date(data$Date, format="%d/%m/%Y")
subdata<-filter(data,(Date=="2007-02-01" | Date=="2007-02-02"))
rm(data)

##joins date and time
subdata<-mutate(subdata,datetime=as.POSIXct(paste(Date, Time), format="%Y-%m-%d %H:%M:%S"))

#creates the plot
plot(y=as.numeric(subdata$Global_active_power), x=subdata$datetime, type = "l",ylab = "Global Active Power (kilowatts)", xlab = "")

#Exports the plot
dev.copy(png, file="plot2.png", height=480, width=480)
dev.off()

