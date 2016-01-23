gdp1 <- read.csv("getdata-data-GDP.csv")
gdp2 <-	gdp1[5:194, c(1, 2, 4)]
gdp3 <- gdp2 %>%
	rename(countryCode = X) %>%
	rename(countryName = X.2) %>%
	rename(gdpRank = Gross.domestic.product.2012)
gdp4 <- tbl_df(gdp3)
