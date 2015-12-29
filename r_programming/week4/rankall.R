rankall <- function(outcome, num = "best") {
	## Read outcome data

	raw_data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
	target_columns <- c(2, 7, 11, 17, 23)
	filter1 <- raw_data[target_columns]
	names(filter1)[1] <- "name"
	names(filter1)[2] <- "state"
	names(filter1)[3] <- "heart attack"
	names(filter1)[4] <- "heart failure"
	names(filter1)[5] <- "pneumonia"

	## Check that state and outcome are valid
	##
	## State is not a supplied argument for this exercise, but
	## I use template as specified by assignment

	legal_outcomes = c("heart attack", "heart failure", "pneumonia")

	if (outcome %in% legal_outcomes == FALSE) {
		stop("invalid outcome")
	}

	if (num != "best" && num != "worst" && num%%1 != 0) {
		stop("invalid num")
	}

	## For each state, find the hospital of the given rank

	filter2 <- filter1[filter1[outcome] != 'Not Available', ]
	
	filter2[outcome] <- as.data.frame(sapply(filter2[outcome], as.numeric))
	filter3 <- filter2[order(filter2$name, decreasing = FALSE), ]
	filter4 <- filter3[order(filter3[outcome], decreasing = FALSE), ]

	## rank for state
	discoverRankedHospital <- function(data_frame, state, num) {
		filter1 <- data_frame[data_frame$state == state, ]
		filter2 <- filter1[, outcome]
		if (num == "best") {
			row_ndx <- which.min(filter2)
		} else if (num == "worst") {
			row_ndx <- which.max(filter2)
		} else {
			row_ndx <- num
		}

		filter1[row_ndx, ]$name
	}

	## Return a data frame with the hospital names and (abbreviated) state name

	states <- filter4[, 2]
	states <- unique(states)
	filter5 <- data.frame("hospital" = character(), "state" = character())
	for (ndx in states) {
		current <- discoverRankedHospital(filter4, ndx, num)
		filter5 <- rbind(filter5, data.frame(hospital=current, state=ndx))
	}

	filter6 <- filter5[order(filter5['state'], decreasing = FALSE), ]
	return(filter6)
}
