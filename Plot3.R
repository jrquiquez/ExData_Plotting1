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

#creates and exports the plot
png("plot3.png", width=480, height=480)
plot(subdata$datetime,as.numeric(subdata$Sub_metering_1) ,ylab = "Energy Submetering",xlab = "",type = "l")
lines(subdata$datetime,as.numeric(subdata$Sub_metering_2), col="red",type = "l")
lines(subdata$datetime,as.numeric(subdata$Sub_metering_3), col="blue", type= "l")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, lwd=2.5, col=c("black", "red", "blue"))
dev.off()


