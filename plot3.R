    library(dplyr)
    library(lubridate)
    
    filename <- "power.zip"
    folder <- "exdata_data_household_power_consumption"
    
    # File already exists?
    if (!file.exists(filename)){
      fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
      download.file(fileURL, filename, method="curl")
    }  
    
    # Folder exists?
    if (!file.exists(folder)) { 
      unzip(filename) 
    }
    
    arquivo <- read.table("household_power_consumption.txt", 
                          sep = ";",
                          dec = ".",
                          header = TRUE,
                          na.strings = "?",
                          colClasses = c('character','character','numeric',
                                         'numeric','numeric','numeric',
                                         'numeric','numeric','numeric')
    )
    
    dados <- subset(arquivo, dmy(Date) >= "2007-02-01" & dmy(Date) <= "2007-02-02")
    
    datetime <- strptime(paste(dados$Date, dados$Time, sep=" "), "%d/%m/%Y %H:%M:%S") 
    
    plot(datetime, dados$Sub_metering_1, type="l", ylab="Energy sub metering", xlab="")
    lines(datetime, dados$Sub_metering_2, type="l", col="red")
    lines(datetime, dados$Sub_metering_3, type="l", col="blue")
    legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
           lty=1, lwd=2.5, 
           col=c("black", "red", "blue"))
    
    
    dev.copy(png,"plot3.png", width=480, height=480)
    dev.off()