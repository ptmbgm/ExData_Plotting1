
##This code assumes data has been downloaded.  Code executes in a 
##directory containing the file 'household_power_consumption.txt'

##File is a little big to load to memory .  Get what what we need.
##reformat date and then parse for smaller data set
##first grep on 1/2/2007 or 2/2/2007

lines <- grep('^[1-2]/2/2007', readLines('household_power_consumption.txt'))


##This indicates there are 2880 lines of interest beginning at line 66638
##Dump relevant data to smaller file

smalldata<- read.table("household_power_consumption.txt", sep=";", skip = 66637, nrows = 2880)


##We lost header data.  No bigee and easy to recover:

cnames <- colnames(read.table(
                  "household_power_consumption.txt",
                   nrow = 1, header = TRUE, sep=";"))

##Now set the col.names parameter in read.table

smalldata<- read.table("household_power_consumption.txt", sep=";", 
				skip = 66637, nrows = 2880, col.names = cnames)

##Reform date and time info

#refdate<- as.Date(as.character(smalldata$Date), format = "%d/%m/%Y")


#reftime<- strptime(as.character(smalldata$Time), format = "%H:%M:%S")


##Need to add columns with date and time 
dtime <- rep(0,2880)

for (i in 1:2880) {
		dtime[i]<- paste(as.character(smalldata$Date[i]), 
					as.character(smalldata$Time[i])) }

newtime<- strptime(dtime, format = "%d/%m/%Y %H:%M:%S")



##now add a column

smalldata$newdate <-newtime



with(smalldata, plot(newdate, Global_active_power, type ="l", 
	ylab = "Global Active Power (kilowatts)", xlab = " " ))

##save to a png of appropriate size

plot2.png <- dev.copy(png, width =480, height = 480, units="px")

dev.off()

