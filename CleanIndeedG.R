CleanIndeed<-function(DF) {
  
  suppressWarnings(library(dplyr))
  suppressWarnings(library(stringr))  
  suppressWarnings(library(purrr))  
  suppressWarnings(library(plyr))
  
  DF<-DF[!duplicated(DF),]#remove duplicates
  DF$Location<-(str_extract(DF$Location, "(\\b[^\\d]+\\b)"))#remove postcodeds
  
  # courtesy of https://www.r-bloggers.com/osm-nominatim-with-r-getting-locations-geo-coordinates-by-its-address/
  nominatim_osmMod <- function(address = NULL)
  {
    if(suppressWarnings(is.na(address)))
      return(data.frame())
    tryCatch(
      d <- jsonlite::fromJSON( 
        gsub('\\@addr\\@', gsub('\\s+', '\\%20', address), 
             'http://nominatim.openstreetmap.org/search/@addr@?format=json&addressdetails=0&limit=1')
      ), error = function(c) return(data.frame())
    )
    if(length(d) == 0) return(data.frame())
    return(data.frame(lon = as.numeric(d$lon), lat = as.numeric(d$lat)))
  }#slightly modified to deal with NA instead of NULL
  
  DFCoord<- lapply(DF$Location, nominatim_osmMod)
  filter<-lapply(DFCoord, is_empty)
  DFCoord[unlist(filter)]<-0
  DFCoorddf <- ldply(DFCoord, data.frame)
  
  DFCoorddf[3]<-1:length(DFCoorddf[,1])#ordinal index for coord
  DF[,6]<-(1:length(DF[,1]))#ordinal index for totaljobs
  
  names(DF)[6]<-"OrdIndex"
  names(DFCoorddf)[3]<-"OrdIndex"
  
  DF2 <- merge(DF,DFCoorddf, by="OrdIndex")
  
  
  DF2$Salary<-as.character(DF2$Salary)
  DF2$Salary<-gsub(",", "", DF2$Salary)#remove commas from digits in thousands
  
  Numextract <- function(string){
    unlist(regmatches(string,gregexpr("[[:digit:]]+\\.*[[:digit:]]*",string)))
  }#curtesy of http://stla.github.io/stlapblog/posts/Numextract.html
  
  DF2$rate<-lapply(DF2$Salary, Numextract)%>%plyr::ldply(rbind)
  
  DF2$minrate<-as.numeric(as.character(unlist(DF2$rate[1])))#min rate
  DF2$maxrate<-as.numeric(as.character(unlist(DF2$rate[length(DF2$rate)])))#max rate
  DF2$maxrate[!complete.cases(DF2$maxrate)]<-DF2$minrate[!complete.cases(DF2$maxrate)]
  DF2 <- select(DF2, -rate)
  
  DF2$rateby<-(str_extract(DF$Salary, "(\\b year|month|week|day|hour\\b)"))
  
  DF2
  
}  
