# Load data
fileUrl <- "household_power_consumption.txt"
con <- file(fileUrl, 'r')
rm('fileUrl')
data <- read.table(con,  stringsAsFactors = FALSE, header = TRUE, sep = ";", na.string = "?")
close(con)
rm('con')

#Filter data
par(mfrow = c(1, 1))
minDate <- as.POSIXct("2007-02-01 00:00:00")
maxDate <- as.POSIXct("2007-02-03 00:00:00")
data$Date_Time <- strptime(sprintf("%s %s", data$Date, data$Time), "%d/%m/%Y %H:%M:%S")
data = data[data$Date_Time >= minDate & data$Date_Time <= maxDate, ]

# Plot
globalActivePowerData <- data[complete.cases(data$Global_active_power), ]

# Plot
globalActivePowerData <- data[complete.cases(data$Global_active_power), ]
with(globalActivePowerData, 
     hist(Global_active_power,
          col = "red",
          main = "Global Active Power",
          xlab = "Global Active Power (kilowatts)"
          )
     )

dev.copy(png, "plot1.png")
dev.off()

rm('minDate')
rm('maxDate')
rm('globalActivePowerData')
rm('data')