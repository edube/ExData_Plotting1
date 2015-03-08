##function below reads in a hoursehold power consumption dataset
## and manipulates it to create a  plot of the gloable active power vs time.

Plot2 <-function(dt) {
        
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
        Data$Global_active_power <-as.numeric(Data$Global_active_power)
        
        ##open device
        png(filename='plot2.png',width=480,height=480,units='px')
        
        ##plotting
        plot(Data$DateTime,Data$Global_active_power,ylab="Global Active Power (kilowatts)", xlab="", type='l')

        ##close device
        dev.off()
        
        dt <- Data
        
}