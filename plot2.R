# The functions to read the data are in "readdata.R"
source("readdata.R")

filename <- get.file()
data <- read.data(filename) 

png( filename = "plot2.png" )

with(data, plot(
             DateTime, 
             Global_active_power, 
             type = "l",
             xlab="", 
             ylab="Global Active Power (kilowatts)"
           )
)

dev.off()