ed1 <- read.csv("getdata-data-EDSTATS_Country.csv")
ed2 <- rename(ed1, countryCode = CountryCode)
ed3 <- tbl_df(ed2)
