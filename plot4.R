# download data and unzip
fileUrl<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl,dest="household_power_consumption.zip",method="curl")
unzip("household_power_consumption.zip","household_power_consumption.txt")

# read data
library(data.table)
EPC_org<-fread("household_power_consumption.txt")

# subset and transform the data
ind<-which(EPC_org$Date=="1/2/2007"|EPC_org$Date=="2/2/2007")
EPC<-data.frame(EPC_org[ind,])
EPC[,3]<-as.numeric(EPC[,3])
EPC[,4]<-as.numeric(EPC[,4])
EPC[,5]<-as.numeric(EPC[,5])
EPC[,6]<-as.numeric(EPC[,6])
EPC[,7]<-as.numeric(EPC[,7])
EPC[,8]<-as.numeric(EPC[,8])

# Convert character to date and time
EPC$DateTime<-paste(EPC$Date,EPC$Time)
EPC$DateTime<-strptime(EPC$DateTime, format="%d/%m/%Y %H:%M:%S", tz = "GMT")

# change system locale to US
Sys.setlocale("LC_TIME", "en_US.UTF-8")

# draw the plot
par(mfcol=c(2,2))
plot(EPC$DateTime,EPC$Global_active_power,type="l",xlab="",ylab="Global Active Power")
plot(EPC$DateTime,EPC$Sub_metering_1,type="l",xlab="",ylab="Energy sub metering")
lines(EPC$DateTime,EPC$Sub_metering_2,col='red')
lines(EPC$DateTime,EPC$Sub_metering_3,col='blue')
legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=c(1,1,1),col=c("black","red","blue"))
plot(EPC$DateTime,EPC$Voltage,type="l",xlab="datetime",ylab="Voltage")
plot(EPC$DateTime,EPC$Global_reactive_power,type="l",xlab="datetime",ylab="Global_reactive_power")
dev.copy(png, file = "plot4.png",width=480,height=480)
dev.off()
