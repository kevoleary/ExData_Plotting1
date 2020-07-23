download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
              destfile = "./hhldPwrConsumpZip", method = "curl")
unzip("hhldPwrConsumpZip")
hhldPwrConsump <- read.table("household_power_consumption.txt", sep = ";",
                             header =TRUE)
firstIndex <- min(grep("^1/2/2007$", hhldPwrConsump$Date))
lastIndex <- max(grep("^2/2/2007$", hhldPwrConsump$Date))
df <- hhldPwrConsump[firstIndex:lastIndex,]
par(mar = c(4,4,2,2))
par(cex = .9)
df$dateTime <- strptime(paste(df$Date, df$Time, sep = " "), 
                        format = "%d/%m/%Y %H:%M:%S")
plot(x = df$dateTime, y = df$Global_active_power, type = "l",
     xlab = "", ylab = "Global Active Power (kilowatts)")
dev.copy(png, file = "plot2.png")
dev.off()
