# Read the household power consumption

library(reshape2)
library(sqldf)

URL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

# Get the files and save it to the argument folder
#
# @param data_folder [default: "data"] the folder to save the file
#
# @return the saved file name
#
get.file <- function(data_folder = "data") {
    # Save the files in the DATA_FOLDER folder
    if ( ! dir.exists(data_folder) ) {
        dir.create(data_folder)
    }
    
    # Create the file names
    dest_zip <- file.path(data_folder, "household_power_consumption.zip")
    dest_file <- file.path(data_folder, "household_power_consumption.txt")
    
    # Only read the file if it does not exist
    if ( ! file.exists(dest_file) ) {
        download.file(URL, destfile = dest_zip, method = "curl" )
        unzip(dest_zip, exdir=data_folder)
    }
    
    dest_file
}

# Make the function to read the data, using closures.
#
# Has bultin cache, because it is slow to read the data all the time.
make.read.data <- function() {
    cache <- list(filename=NULL, data=NULL)
    
    f <- function(filename) {
        if(list(cache$filename) == filename) return (cache$data)
        
        # Using sqldf to filter the data
        # the Date variable is in d/m/yyyy format.
        data <- read.csv.sql(
            filename, 
            sql = "select * from file where Date = '1/2/2007' or Date = '2/2/2007'", 
            sep = ";",
            colClasses = c("character", "character", "numeric", "numeric","numeric","numeric","numeric","numeric","numeric"))
        
        # Close the slqdf connection
        if (!is.null(getOption("sqldf.connection"))) sqldf()
        
        # Convert the Date and Time columns to only one column as POSIXlt
        data$DateTime <- strptime(paste(data$Date, data$Time), format='%d/%m/%Y %H:%M:%S')
        
        # Sets the cache
        cache <<- list(filename=filename, data=data)
        
        return (data)
    }
    
    return ( f )
}

# Reads the Household power consumption data from a file, where
# Date is 1/2/2007 or 2/2/2007.
#
# @param filename the file to read the data from.
#
# @return a data frame with the data.
if(! exists("read.data")) read.data <- make.read.data()
