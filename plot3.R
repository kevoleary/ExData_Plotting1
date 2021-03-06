download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
              destfile = "./hhldPwrConsumpZip", method = "curl")
unzip("hhldPwrConsumpZip")
hhldPwrConsump <- read.table("household_power_consumption.txt", sep = ";",
                             header =TRUE)
firstIndex <- min(grep("^1/2/2007$", hhldPwrConsump$Date))
lastIndex <- max(grep("^2/2/2007$", hhldPwrConsump$Date))
df <- hhldPwrConsump[firstIndex:lastIndex,]
par(mar = c(4,4,2,2))
par(cex = .8)
df$dateTime <- strptime(paste(df$Date, df$Time, sep = " "), 
                        format = "%d/%m/%Y %H:%M:%S")
df2 <- data.frame(df[,1:2],apply(df[,3:9], 2, as.numeric),dateTime = df$dateTime)
with(df2, plot(x = dateTime, y = Sub_metering_1, type = "l", 
               xlab = "", ylab = "Energy sub metering"))
lines(x = df2$dateTime, y = df2$Sub_metering_2, col = "red")
lines(x = df2$dateTime, y = df2$Sub_metering_3, col = "blue")
legend("topright", legend = names(df2)[7:9], col = c("black", "red", "blue"),
       lty = 1)
dev.copy(png, file = "plot3.png")
dev.off()
