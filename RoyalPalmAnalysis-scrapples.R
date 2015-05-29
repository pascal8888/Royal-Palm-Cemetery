# s <- rpc[grep("b.", rpc$Suffix2,fixed=T), ]
# l <- mutate(rpc,Born_Died=Suffix2)
# grepl("b.",l)
# rpc <- rpc %>% mutate(Born_Died=ifelse(grepl("b.[n/a,0123456789]",Suffix),Suffix,NA)) #works
# l <- grepl("b.[n/a,12,$0123456789]",rpc$Suffix) #returns t/f which indices contain the string
# l <- as.Date(rpc$Born,format="%Y")
# l <- filter(rpc, grepl(1984,rpc$Died))
# l <- filter(rpc, grepl(1984,Died) & grepl(1897,Born))
# l <- filter(rpc, grepl("TAYLOR",Last_Name))
# mbirth <- mean(rpc$Born,na.rm=T)
# mdeath <- mean(rpc$Died,na.rm=T)
# bornYears <- unique(rpc$Born)
# bornYears <- na.omit(bornYears)
# l <- filter(rpc, grepl(1984,rpc$Died))
# l <- which(bornYears > 1800,arr.ind=T)
# bornYears[l]
# qplot(rpc$Died[200:400])
# qplot(rpc$Born[200:400])
# qplot(rpc$Died[200:400],rpc$Born[200:400])
# qplot(diedPerYear[100:120,1],diedPerYear[100:120,2],ylab="Count of Interred Persons Died",xlab="Year",main="Count of Interred Persons Died Per Year")
