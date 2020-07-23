download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
              destfile = "./hhldPwrConsumpZip", method = "curl")
unzip("hhldPwrConsumpZip")
hhldPwrConsump <- read.table("household_power_consumption.txt", sep = ";",
                             header =TRUE)
firstIndex <- min(grep("^1/2/2007$", hhldPwrConsump$Date))
lastIndex <- max(grep("^2/2/2007$", hhldPwrConsump$Date))
df <- hhldPwrConsump[firstIndex:lastIndex,]
df$Global_active_power <- as.numeric(df$Global_active_power)
par(mar = c(4,4,2,2))
par(cex = .8)
hist(df$Global_active_power, xlab = "Global Active Power (kilowatts)",
     ylab = "Frequency", main = "Global Active Power", col = "red")
dev.copy(png, file = "plot1.png")
dev.off()

