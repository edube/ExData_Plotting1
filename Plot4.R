##function below reads in a hoursehold power consumption dataset
## and manipulates it to create 4 plots

Plot4 <-function(dt) {
        
        ##read in data into a table
        hpw = read.table("household_power_consumption.txt",header=TRUE, sep = ";",colClasses ="character" ,na.strings = "?")
        hpw <- hpw[hpw$Date == '1/2/2007' | hpw$Date == '2/2/2007',]
        
        ##create temporary vector to hold time and date in time and date format and collate to end of table
        tmp <- paste(hpw$Date,hpw$Time, sep=" ")
        dttemp<- strptime(tmp,format="%d/%m/%Y %H:%M:%S")
        new_hpw_dt<-cbind(hpw,dttemp)
        
        ##add name to new column in table
        names(new_hpw_dt)[10]<-"DateTime"
        
        ##change column type to numeric
        Data<-new_hpw_dt
        Data$Global_active_power <-as.numeric(Data$Global_active_power,Data$Sub_metering_1,Data$Sub_metering_2,Data$Sub_metering_3)
        
        ##open device
        png(filename='plot4.png',width=480,height=480,units='px')
        
        ##four plots
        par(mfrow=c(2,2))
        
        ##plotting first plot top left
        plot(Data$DateTime,Data$Global_active_power,ylab="Global Active Power", xlab="", type='l')
        
        ##plotting second plot top right
        plot(Data$DateTime,Data$Voltage,ylab="Voltage", xlab="datetime", type='l')
        
        ##plotting third plot bottom left        
        Labels <- c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3") 
        plot(Data$DateTime,Data$Sub_metering_1,ylab="Energy sub metering", xlab="", type='l', col="black")
        lines(Data$DateTime,Data$Sub_metering_2,col="red")
        lines(Data$DateTime,Data$Sub_metering_3,col="blue")
        
        ##add legend
        legend("topright", legend = Labels,col=c("black","red","blue"), lty="solid",bty="n")
        
        ##plotting third plot bottom right
        plot(Data$DateTime,Data$Global_reactive_power,ylab="Global_reactive_power", xlab="datetime", type='l')
        
        
        
        dev.off()
        
        dt<-Data
}