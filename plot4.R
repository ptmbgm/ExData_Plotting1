

##This code is intended to address requirements for the Coursera offering
##Exploratory Data Analysis

##The code assumes data has been downloaded and that the code is run
##in a directory containing the file 'household_power_consumption.txt'

##The file is a little big to load to memory.  To extract the two days of 
##data required, first grep on 1/2/2007 or 2/2/2007

lines <- grep('^[1-2]/2/2007', readLines('household_power_consumption.txt'))

##str(lines)

##This indicates there are 2880 lines of interest beginning at line 66638
##Dump relevant data to smaller file

smalldata<- read.table("household_power_consumption.txt", sep=";", skip = 66637, nrows = 2880)

##Reformat the header:  

cnames <- colnames(read.table(
                  "household_power_consumption.txt",
                   nrow = 1, header = TRUE, sep=";"))

##Now set the col.names parameter in read.table

smalldata<- read.table("household_power_consumption.txt", sep=";", 
				skip = 66637, nrows = 2880, col.names = cnames)

##smalldata contains the data of interest.  Next, we reformat the data
##to extract information quickly


##Need to add columns with date and time 
dtime <- rep(0,2880)

for (i in 1:2880) {
		dtime[i]<- paste(as.character(smalldata$Date[i]), 
					as.character(smalldata$Time[i])) }

newtime<- strptime(dtime, format = "%d/%m/%Y %H:%M:%S")


##now add a column

smalldata$newdate <-newtime


##Final graph
attach(smalldata)
par(mfrow =c(2,2))
par(mar=c(5, 5, 4,3))
{plot(newdate, Global_active_power, type ="l", 
	ylab = "Global Active Power (kilowatts)", xlab = " " )
plot(newdate, Voltage, type ="l", xlab = "datetime" )}
plot(newdate, Sub_metering_1, type ="l", 
	ylab = "Energy sub metering", xlab = " " )
points(newdate, Sub_metering_2, type ="l", col="red")
points(newdate, Sub_metering_3, type ="l", col="blue")
legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3")
	,lty = c(1, 1, 1),cex= 1, inset = .05, col=c("Black","Red","Blue"),bty="n");

plot(newdate, Global_reactive_power, type ="l", 
	xlab = "datetime" )

dev.copy(png, filename= "plot4.png", width =480, height = 480, units="px")

dev.off()





