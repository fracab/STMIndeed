CleanSalaryIndeed<-function(DF) {
suppressWarnings(library(dplyr))
suppressWarnings(library(stringr))
    
DF<-DF[!duplicated(DF),]#remove duplicates

DF$Salary<-as.character(DF$Salary)
DF$Salary<-gsub(",", "", DF$Salary)#remove commas from digits in thousands

Numextract <- function(string){
  unlist(regmatches(string,gregexpr("[[:digit:]]+\\.*[[:digit:]]*",string)))
}#curtesy of http://stla.github.io/stlapblog/posts/Numextract.html

DF$rate<-lapply(DF$Salary, Numextract)%>%plyr::ldply(rbind)

DF$minrate<-as.numeric(as.character(unlist(DF$rate[1])))#min rate
DF$maxrate<-as.numeric(as.character(unlist(DF$rate[length(DF$rate)])))#max rate
DF$maxrate[!complete.cases(DF$maxrate)]<-DF$minrate[!complete.cases(DF$maxrate)]
DF <- select(DF, -rate)

DF$rateby<-(str_extract(DF$Salary, "(\\b year|month|week|day|hour\\b)"))

DF

}


