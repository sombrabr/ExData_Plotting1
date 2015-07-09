# The functions to read the data are in "readdata.R"
source("readdata.R")

filename <- get.file()
data <- read.data(filename) 

png( filename = "plot1.png" )

hist(
    data$Global_active_power,
    main="Global Active Power",
    xlab="Global Active Power (kilowatts)", 
    col="red")

dev.off()