# importing data file
hpc<-read.table('household_power_consumption.txt',sep=';',header=TRUE,stringsAsFactors=FALSE)

# loading dplyr
library(dplyr)

# using dplyr to filter imported data file
hpc_2<-filter(hpc,Date=='1/2/2007' | Date=='2/2/2007')

# converting date and time variables to date/time classes
hpc_2<-mutate(hpc_2,Date2 = as.Date(Date,format='%d/%m/%Y'),
              DateTime = paste(Date,Time,sep=" "),
              Time2 = as.POSIXct(DateTime,format='%d/%m/%Y %H:%M:%S'),
              Global_active_power = as.numeric(Global_active_power),
              Global_reactive_power = as.numeric(Global_reactive_power),
              Voltage = as.numeric(Voltage),
              Global_intensity = as.numeric(Global_intensity),
              Sub_metering_1 = as.numeric(Sub_metering_1),
              Sub_metering_2 = as.numeric(Sub_metering_2),
              Sub_metering_3 = as.numeric(Sub_metering_3))

# Calculating maximum y range for sub metering data series
y_range <- with(hpc_2,range(0,Sub_metering_1,Sub_metering_2,Sub_metering_3))

# Opening PNG file device for plot4
png(file="plot4.png",width = 480, height = 480)

# Setting parameter for a 2x2 matrix of charts
par(mfrow=c(2,2))

# Creating graphs
with(hpc_2, {
  plot(Time2,Global_active_power,xlab= "",ylab="Global Active Power",type='l')
  plot(Time2,Voltage,xlab= "datetime",ylab="Voltage",type='l')
  plot(Time2,Sub_metering_1,xlab= "",ylab="Energy sub metering",type='l')
  par(new=T)
  with(hpc_2,plot(Time2,Sub_metering_2,xlab= "",ylab="Energy sub metering",type='l',col="red",axes=FALSE,ylim=y_range))
  par(new=T)
  with(hpc_2,plot(Time2,Sub_metering_3,xlab= "",ylab="Energy sub metering",type='l',col="blue",axes=FALSE,,ylim=y_range))
  legend("topright",lty=c(1,1,1),col= c("black","blue","red"), legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),bty='n')
  plot(Time2,Global_reactive_power,xlab= "datetime",ylab="Global_reactive_power",type='l')
})

# Closing PNG file device
dev.off()
