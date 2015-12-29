best <- function(state, outcome) {
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

	us_states <- filter1[, 2]
	us_states <- unique(us_states)
	if (state %in% us_states == FALSE) {
		stop("invalid state")
	}

	legal_outcomes = c("heart attack", "heart failure", "pneumonia")

	if (outcome %in% legal_outcomes == FALSE) {
		stop("invalid outcome")
	}

	## Return hospital name in state w/lowest 30 day death rate

	filter2 <- filter1[filter1$state == state & filter1[outcome] != 'Not Available', ]
	values <- filter2[, outcome]
	row_ndx <- which.min(values)
	filter2[row_ndx, ]$name
}
