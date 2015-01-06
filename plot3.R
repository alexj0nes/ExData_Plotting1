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

# Opening PNG file device for plot3
png(file="plot3.png",width = 480, height = 480)

# Creating line graph 1
with(hpc_2,plot(Time2,Sub_metering_1,xlab= "",ylab="Energy sub metering",type='l'))

# Telling R not to redraw graph
par(new=T)

# Creating line graph 2
with(hpc_2,plot(Time2,Sub_metering_2,xlab= "",ylab="Energy sub metering",type='l',col="red",axes=FALSE,ylim=y_range))

# Telling R not to redraw graph
par(new=T)

# Creating line graph 3
with(hpc_2,plot(Time2,Sub_metering_3,xlab= "",ylab="Energy sub metering",type='l',col="blue",axes=FALSE,,ylim=y_range))

# Adding a legend
legend("topright",lty=c(1,1,1),col= c("black","blue","red"), legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

# Closing PNG file device
dev.off()
