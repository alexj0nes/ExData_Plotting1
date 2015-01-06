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

# Opening PNG file device for plot2
png(file="plot2.png",width = 480, height = 480)

# Creating line graph
with(hpc_2,plot(Time2,Global_active_power,xlab= "",ylab="Global Active Power (kilowatts)",type='l'))

# Closing PNG file device
dev.off()
