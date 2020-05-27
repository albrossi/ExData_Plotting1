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
  plot(datetime, 
       dados$Global_active_power, 
       type="l", 
       xlab="", 
       ylab="Global Active Power (kilowatts)")
  
  
  dev.copy(png,"plot2.png", width=480, height=480)
  dev.off()