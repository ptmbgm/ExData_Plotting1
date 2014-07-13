

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

with(smalldata, plot(newdate, Global_active_power, type ="l", 
	ylab = "Global Active Power (kilowatts)", xlab = " " ))

##save to a png of appropriate size

dev.copy(png, filename= "plot2.png", width =480, height = 480, units="px")

dev.off()

