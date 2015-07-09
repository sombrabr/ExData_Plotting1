# The functions to read the data are in "readdata.R"
source("readdata.R")

filename <- get.file()
data <- read.data(filename) 

png( filename = "plot4.png" )

par(mfrow=c(2,2))

# 1) Global Active Power
with(data, plot(
        DateTime, 
        Global_active_power, 
        type = "l",
        xlab="", 
        ylab="Global Active Power"
    )
)


# 2) Voltage
with(data, plot(
        DateTime,
        Voltage,
        type = "l"
    )
)

# 3) Energy sub metering
with(data, plot(DateTime, Sub_metering_1, xlab="", type="n", ylab="Energy sub metering"))
with(data, lines(DateTime, Sub_metering_1, col="black"))
with(data, lines(DateTime, Sub_metering_2, col="red"))
with(data, lines(DateTime, Sub_metering_3, col="blue"))
legend("topright", lty=c(1,1), bty="n", col=c("black", "red", "blue"), legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

# 4) Global_reactive_power
with(data, plot(
        DateTime,
        Global_reactive_power,
        type = "l"
    )
)

dev.off()