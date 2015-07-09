# The functions to read the data are in "readdata.R"
source("readdata.R")

filename <- get.file()
data <- read.data(filename) 

png( filename = "plot3.png" )

with(data, plot(DateTime, Sub_metering_1, xlab="", type="n", ylab="Energy sub metering"))
with(data, lines(DateTime, Sub_metering_1, col="black"))
with(data, lines(DateTime, Sub_metering_2, col="red"))
with(data, lines(DateTime, Sub_metering_3, col="blue"))
legend("topright", lty=c(1,1), col=c("black", "red", "blue"), legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

dev.off()