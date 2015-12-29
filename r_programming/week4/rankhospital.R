rankhospital <- function(state, outcome, num = "best") {
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

        if (num != "best" && num != "worst" && num%%1 != 0) {
                stop("invalid num")
        }

	## Return hospital name in that state with the given rank
	## 30-day death rate

        filter2 <- filter1[filter1[outcome] != 'Not Available', ]
        filter2[outcome] <- as.data.frame(sapply(filter2[outcome], as.numeric))

        filter3 <- filter2[order(filter2$name, decreasing = FALSE), ]

        filter4 <- filter3[order(filter3[outcome], decreasing = FALSE), ]

	filter5 <- filter4[filter4$state == state, ]

	if (num == "best") {
		row_ndx <- 1
	} else if (num == "worst") {
		row_ndx <- nrow(filter5)
	} else {
		row_ndx <- num
	}

	filter5[row_ndx, ]$name
}
