corr <- function(directory, threshold = 0) {
        ## 'directory' is a character vector of length 1 indicating
        ## the location of the CSV files

        ## 'threshold' is a numeric vector of length 1 indicating the
        ## number of completely observed observations (on all
        ## variables) required to compute the correlation between
        ## nitrate and sulfate; the default is 0

        ## Return a numeric vector of correlations
        ## NOTE: Do not round the result!

	file_list <- list.files(directory, full.names=TRUE)

	candidates <- complete(directory)

	result_frame <- data.frame()
	for (ndx in 1:nrow(candidates)) {
		if (candidates[ndx, 2] > threshold) {
			raw_data <- read.csv(file_list[candidates[ndx, 1]])
			good_flag <- complete.cases(raw_data)
			filtered <- raw_data[good_flag,]
			cor_coef <- cor(filtered[,2], filtered[,3])
			result_frame <- rbind(result_frame, cor_coef)
		}
	}

	print(sprintf("result:%d", nrow(result_frame)))

	if (nrow(result_frame) == 0) {
		result_vector <- numeric(0)
		return(result_vector)
	} else {
		return(result_frame[,1])
	}
}
