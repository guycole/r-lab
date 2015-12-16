complete <- function(directory, id = 1:332) {
        ## 'directory' is a character vector of length 1 indicating
        ## the location of the CSV files

        ## 'id' is an integer vector indicating the monitor ID numbers
        ## to be used
        
        ## Return a data frame of the form:
        ## id nobs
        ## 1  117
        ## 2  1041
        ## ...
        ## where 'id' is the monitor ID number and 'nobs' is the
        ## number of complete cases

        data_frame <- data.frame()

        file_list <- list.files(directory, full.names=TRUE)
        for (ndx in id) {
		raw_data <- read.csv(file_list[ndx])
		good_flag <- complete.cases(raw_data)
		filtered <- raw_data[good_flag,]
		data_frame <- rbind(data_frame, c(ndx, nrow(filtered)))
        }

	colnames(data_frame) <- c("id", "nobs")

	return(data_frame)
}
