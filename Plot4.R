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

#creates the plots
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(subdata, {
  plot(datetime,Global_active_power, type="l", 
       ylab="Global Active Power", xlab="")
  plot(datetime,Voltage, type="l", 
       ylab="Voltage", xlab="datetime")
  plot(datetime,Sub_metering_1, type="l", 
       ylab="Energy sub metering", xlab="")
  lines(datetime,Sub_metering_2,col='Red')
  lines(datetime, Sub_metering_3,col='Blue')
  legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
         legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(datetime,Global_reactive_power, type="l", 
       ylab="Global_reactive_power",xlab="datetime")
})

#exports the plot
dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()


