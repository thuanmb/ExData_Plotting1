# Load data
fileUrl <- "household_power_consumption.txt"
con <- file(fileUrl, 'r')
rm('fileUrl')
data <- read.table(
    con, 
    stringsAsFactors = FALSE,
    header = TRUE,
    sep = ";",
    na.string = "?"
)

close(con)
rm('con')

#Filter data
minDate <- as.POSIXct("2007-02-01 00:00:00")
maxDate <- as.POSIXct("2007-02-03 00:00:00")
data$Date_Time <- strptime(sprintf("%s %s", data$Date, data$Time), "%d/%m/%Y %H:%M:%S")
data = data[data$Date_Time >= minDate & data$Date_Time <= maxDate, ]

# Plot
par(mfrow = c(1, 1))
globalActivePowerData <- data[complete.cases(data$Global_active_power), ]

with(globalActivePowerData, plot(Date_Time, Global_active_power,
    main = "",
    xlab = "",
    ylab = "Global Active Power (kilowatts)",
    type = "l",
    xaxt="n"
))
axis.POSIXct(1, at = seq(
    globalActivePowerData$Date_Time[1],
    globalActivePowerData$Date_Time[length(globalActivePowerData$Date_Time)], "days"), format = "%a")

dev.copy(png, "plot2.png")
dev.off()

rm('minDate')
rm('maxDate')
rm('globalActivePowerData')
rm('data')