####### NOTICE - THIS DATA MAY NOT BE USED COMMERCIALLY #######
## [Insert full data acceptable use information here. See RPC.txt for current statement]
## Analayze data from Royal Palm cemetery - 101 55th Street South, Saint Petersburg, Florida, 33707. Captured manually 2000 - 2001. See raw source file (RPC.txt) for a complete description of the data collection process including persons involved.
## Load needed packages
library(dplyr)
library(tidyr)
library(ggplot2)
library(shiny)
## Download the source file
if (!file.exists("RPC.txt")) {
    download.file("http://files.usgwarchives.net/fl/pinellas/cemetery/royal.txt","RPC.txt")
}
## Read the file into a data table starting at the first line with interment data (51).
rpc <- read.csv("RPC.txt",skip=50,sep=",",fill=T,header=F,col.names=c("Last_Name","First_Name_MI","Suffix","Suffix2","Honorific","Born_Died"),colClasses="character")
## DATA ANALYSIS - EXPERIMENTAL DESIGN (original pull 5/26/2015)
## Of the source data, most observations(rows) have 3 variables(columns) - Last_Name, First_Name_MI, Born_Died (actually 2 variables), but some have an additional 1 or 2 columns that store an honorific or suffix.  This analysis script will clean the source data to produce a final data set of 22,079 observations of 7 variables.  The variables are: Last_Name | First_Name_MI | Suffix | Suffix2 | Honorific | Born | Died

## DATA ANAMOLIES REMAIN AFTER CLEANUP
## Two rows from the dataset have born and died dates concatened with the First_Name_MI column, and there are other anamolies with various other names injected into the First_Name_MI column.  Nothing has been done to fix these. The very first row, Last_Name: "MOTHER" does not seem like a correct record but was left for the historians to decide. Some Honorifics are listed in Suffix or Suffix2 columns, nothing has been done to correct this. There are noted observations of incomplete variables (e.g. rpc[992,] BARRETT Thomas H. 1895 194) - only 3 digits are provided for Died. Nothing has been done to correct this.

## The following steps are implemented to resolve the other data quality issues:
## grepl the Suffix column for the string "b." followed by "n/a" or numbers - if found put that string in the Born_Died column, if not found put empty string in Born_Died.
rpc <- rpc %>% mutate(Born_Died=ifelse(grepl("b.[b. ,n/a,012]",Suffix),Suffix,""))
## If Born_Died is an empty string look in the Suffix2 & Honorific columns for the string "b." followed by "n/a" or numbers - if found put that string in the Born_Died column, if not found put empty string in Born_Died - should be no empty strings in Born_Died after this step
rpc <- rpc %>% mutate(Born_Died=ifelse(Born_Died=="" & grepl("b.[b. ,n/a,012]",Suffix2),Suffix2,Born_Died),Born_Died=ifelse(Born_Died=="" & grepl("b.[b. ,n/a,012]",Honorific),Honorific,Born_Died))
## Remove the ["b."("n/a":digit:)] from Suffix, Suffix2, & Honorific columns
rpc <- rpc %>% mutate(Suffix=ifelse(grepl("b.[b. ,n/a,012]",Suffix),"",Suffix),Suffix2=ifelse(grepl("b.[b. ,n/a,012]",Suffix2),"",Suffix2),Honorific=ifelse(grepl("b.[b. ,n/a,012]",Honorific),"",Honorific))
## Split the Born_Died to two columns "Born" and "Died", remove "b.", "d." and any whitespace, then convert the character to a numeric value for calculating
rpc <- separate(rpc, Born_Died,into=c("Born","Died"),sep=" d.",extra="drop")
rpc$Born <- sub(" b.","",rpc$Born)
rpc$Born <- as.numeric(rpc$Born)
rpc$Died <- as.numeric(rpc$Died)
## add lifeSpan column
rpc <- rpc %>% mutate(Life_Span=ifelse(Died>1700,Died-Born,NA))
##
## Data Cleaning Complete
bornYears <- unique(rpc$Born)  ## Find which years interred persons where born
l <- which(bornYears > 1700,arr.ind=T)  ## Setting to + 1700 is high enough to get the oldest dates but also culls NAs and those rows where some date information is missing (e.g. 3 digits entered for year instead of 4)
bornYears <- sort(bornYears[l]) ## This is the array for the years in which persons interred at Royal Palm cemetery were born
diedYears <- unique(rpc$Died)  ## Find which years interred persons died
m <- which(diedYears > 1700,arr.ind=T) ## See note above for bornYears - applies here
diedYears <- sort(diedYears[m]) ## This is the array for the years in which persons interred at Royal Palm cemetery died
## Figure out how many people were born each year (result == bornPerYear)
s <- as.vector(c())
for (i in 1:length(bornYears)) {
    s[i] <- nrow(filter(rpc, grepl(bornYears[i],rpc$Born)))
}
bornPerYear <- cbind(bornYears,s) ## Matrix (Year, Born_Count)
colnames(bornPerYear) <- c("Year","Born_Count")
qplot(bornPerYear[,1],bornPerYear[,2],ylab="Count of Interred Persons Born",xlab="Year",main="Count of Interred Persons Born Per Year") ## Plot the births
## Figure out how many people died each year (result == diedPerYear)
s2 <- as.vector(c())
for (i in 1:length(diedYears)) {
    s2[i] <- nrow(filter(rpc, grepl(diedYears[i],rpc$Died)))
}
diedPerYear <- cbind(diedYears,s2)  ## Matrix (Year, Died_Count)
colnames(diedPerYear) <- c("Year","Died_Count")
qplot(diedPerYear[,1],diedPerYear[,2],ylab="Count of Interred Persons Died",xlab="Year",main="Count of Interred Persons Died Per Year") ## Plot the deaths
## get the average life span for use in plots
avgLifeSpan <- mean(rpc$Life_Span,na.rm=T)
## get sirnames
sirNames <- sort(unique(rpc$Last_Name))
## get a count of how many interred per sirName
s3 <- as.vector(c())
for (i in 1:length(sirNames)) {
    s3[i] <- nrow(filter(rpc, grepl(sirNames[i],rpc$Last_Name)))
}
countSirNames <-  cbind(sirNames,s3)  ## Matrix (Sirname, Count)
colnames(countSirNames) <- c("Sirname","Count")
countSirNames <- as.data.frame(countSirNames)  ## convert to data.frame so that we can mix classes
countSirNames[,1] <- as.character(countSirNames[,1]) ## set the sirnames to character class
countSirNames[,2] <- as.numeric(countSirNames[,2]) ## set the counts to numeric class
## Clean up time
rm("s","s2","s3","i","m","l")
## Give some information about what just happened and options now
print(
    "Data reading, formatting, and analysis have been completed. See insert URL for a visual display of the output data. Variables left in R environment: 1) rpc - this the clean and tidy data set for Royal Palm cemetery [data frame] 2) avgLifeSpan - this is the mean of all observations where we have both born and died data [numeric value] 3) bornYears - these are the years in which persons interred at RPC were born [numeric vector] 4) diedYears - these are the years in which persons interred at RPC died [numeric vector] 5) bornPerYear - this is number of persons interred at RPC born per each year [matrix] 6) diedPerYear - this is count of persons interred at RPC died per each year [matrix] 7) sirNames - this is a list of unique sirnames found amongst persons interred at RPC [character vector] 8) countSirNames - this is count of persons interred at RPC per sir name [data frame]"
)
## Final cleanup
## rm("rpc","avgLifeSpan","bornYears","diedYears","bornPerYear","diedPerYear","sirNames","countSirNames")
