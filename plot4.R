download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
              destfile = "./hhldPwrConsumpZip", method = "curl")
unzip("hhldPwrConsumpZip")
hhldPwrConsump <- read.table("household_power_consumption.txt", sep = ";",
                             header =TRUE)
firstIndex <- min(grep("^1/2/2007$", hhldPwrConsump$Date))
lastIndex <- max(grep("^2/2/2007$", hhldPwrConsump$Date))
df <- hhldPwrConsump[firstIndex:lastIndex,]
png(filename = "plot4.png")
par(mar = c(4,4,2,2))
par(cex = .4)
df$datetime <- strptime(paste(df$Date, df$Time, sep = " "), 
                        format = "%d/%m/%Y %H:%M:%S")
df2 <- data.frame(df[,1:2],apply(df[,3:9], 2, as.numeric),datetime = df$datetime)
par(mfcol = c(2,2))
# Top left plot
plot(x = df$datetime, y = df$Global_active_power, type = "l",
     xlab = "", ylab = "Global Active Power (kilowatts)")
# Bottom left plot
with(df2, plot(x = datetime, y = Sub_metering_1, type = "l", 
               xlab = "", ylab = "Energy sub metering"))
lines(x = df2$datetime, y = df2$Sub_metering_2, col = "red")
lines(x = df2$datetime, y = df2$Sub_metering_3, col = "blue")
legend("topright", legend = names(df2)[7:9], col = c("black", "red", "blue"),
       lty = 1, bty = "n")
# Top right plot
with(df2, plot(x = datetime, y = Voltage, type = "l"))
# Bottom rigth plot
with(df2, plot(x = datetime, y = Global_reactive_power, type = "l"))

dev.off()
