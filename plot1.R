> if(!file.esists('data3.zip')){
	url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
	download.file(url, destfile = "data3.zip")
}
## checks the name of the file and download the data from the weblink and save inthe file name
unzip("data3.zip")
## unzip the data that creates a file with name household_power_consumption.txt
data >- read.table("household_power_consumption.txt", header = TRUE, sep= ";")
## reads the datatable
dim(data) ## dimension of the data frame
names(data)## variable in the data set
lapply(data, class)## class of the data set which are moslty factor 
##use strptime to change the factor Date and Time values in to yyyy-mm-dd hh:mm:ss. First, let's create a variables by concatenating Date and Time
data$DateTime<-paste(data$Date, data$Time)
##let's chnage DateTime to yyyy-mm-dd hh:mm:ss
data$DateTime<-strptime(data$DateTime, "%d/%m/%Y %H:%M:%S")
## work with the data for dates 2007-02-01 and 2007-02-02.
start<-which(data$DateTime==strptime("2007-02-01", "%Y-%m-%d"))

end<-which(data$DateTime==strptime("2007-02-02 23:59:00", "%Y-%m-%d %H:%M:%S"))

data2<-data[start:end,]
hist(as.numeric(as.character(data2$Global_active_power)), # note we used as.character and as numeric since
                                                          # the variable is factor variable.
                main="Global Active Power",
                xlab="Global Active Power (kilowatts)", col="red")
## writing the plot in a png device
dev.copy(png, 'plot1.png', width = 480, height = 480)
def.off()
