# Load data
fileUrl <- "household_power_consumption.txt"
con <- file(fileUrl, 'r')
rm('fileUrl')
#data <- read.table(
#    con, 
#    stringsAsFactors = FALSE,
#    header = TRUE,
#    sep = ";",
#    na.string = "?"
#)
#data$Date_Time <- strptime(sprintf("%s %s", data$Date, data$Time), "%d/%m/%Y %H:%M:%S")
close(con)
rm('con')

#Filter data
minDate <- as.POSIXct("2007-02-01 00:00:00")
maxDate <- as.POSIXct("2007-02-03 00:00:00")
data = data[data$Date_Time >= minDate & data$Date_Time <= maxDate, ]
globalActivePowerData <- data[complete.cases(data$Global_active_power), ]

# Plot
par(mfrow = c(2, 2))
par(cex.lab = 0.7)
par(mgp = c(2.5, 1, 0))
par(mar=c(4, 4, 0, 0))

### Plot 1
with(globalActivePowerData,
     plot(Date_Time, Global_active_power,
                                 main = "",
                                 xlab = "",
                                 ylab = "Global Active Power",
                                 type = "l",
                                 xaxt="n"
    )
)
axis.POSIXct(1, at = seq(
    globalActivePowerData$Date_Time[1],
    globalActivePowerData$Date_Time[length(globalActivePowerData$Date_Time)], "days"), format = "%a")


### Plot 2
with(globalActivePowerData,
     plot(Date_Time, Voltage,
          main = "",
          xlab = "datetime",
          ylab = "Voltage",
          type = "l",
          xaxt="n"
     )
)
axis.POSIXct(1, at = seq(
    globalActivePowerData$Date_Time[1],
    globalActivePowerData$Date_Time[length(globalActivePowerData$Date_Time)], "days"), format = "%a")

### Plot 3
with(globalActivePowerData, plot(Date_Time, Sub_metering_1,
                                 main = "",
                                 xlab = "",
                                 ylab = "Energy sub metering",
                                 type = "l",
                                 xaxt="n"
))
with(globalActivePowerData, lines(Date_Time, Sub_metering_2,
                                  col = "red"
))
with(globalActivePowerData, lines(Date_Time, Sub_metering_3,
                                  col = "blue"
))
axis.POSIXct(1, at = seq(
    globalActivePowerData$Date_Time[1],
    globalActivePowerData$Date_Time[length(globalActivePowerData$Date_Time)], "days"), format = "%a")
legend("topright", lty = 1, col = c("black", "red", "blue"),
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       bty = "n",
       cex = 0.7,
       inset=c(-0.1, -0.05))

### Plot 4
with(globalActivePowerData,
     plot(Date_Time, Global_reactive_power,
          main = "",
          xlab = "datetime",
          ylab = "Global_reactive_power",
          type = "l",
          xaxt="n"
     )
)

axisSeq <- seq(0.0, max(globalActivePowerData$Global_reactive_power), by = 0.1)
axisLbl <- as.character(axisSeq)
axisLbl[1] = ""
axis(2, at = axisLbl, lab = axisLbl)
axis.POSIXct(1, at = seq(
    globalActivePowerData$Date_Time[1],
    globalActivePowerData$Date_Time[length(globalActivePowerData$Date_Time)], "days"), format = "%a")

dev.copy(png, "plot4.png")
dev.off()

rm('axisLbl')
rm('minDate')
rm('maxDate')
rm('globalActivePowerData')
#rm('data')