#load libraries
library(rvest)
library("xml2")
library("XML")
library("stringr")
library(dplyr)
library(naniar)

# scrape the info from pages
getmetadataindeed<-function(url){
  meta<-read_html(url)%>%
    htmlParse( asText=TRUE)%>%xpathSApply( "//*[contains(@class,'jobsearch-JobMetadataHeader-iconLabel')]", xmlValue)
  if (is.list(meta)) {meta<-NA
  }
  meta
  }

getjobdescindeed<-function(url){
  read_html(url)%>%
    htmlParse( asText=TRUE)%>%xpathSApply( "//*[contains(@id,'jobDescriptionText')]", xmlValue)%>%paste(collapse=', ')%>%str_replace_all("\n", " ")
}

getjobtitle<-function(url){
  tit<-read_html(url)%>%
    htmlParse( asText=TRUE)%>%xpathSApply( "//*[contains(@class, 'icl-u-xs-mb--xs icl-u-xs-mt--none jobsearch-JobInfoHeader-title')]", xmlValue)
  if (is.list(tit)) {
    tit<-NA
  }
  tit
}

####
#get links from search pages

getlinks<-function(url){
  linksb<-read_html(url)%>%htmlParse(asText = TRUE)%>%xmlRoot()%>%xpathSApply("//*[contains(@class,'title')]", xmlGetAttr, 'href')
  linksb[sapply(linksb, is.null)] <- NULL
  linksb<-as.character(linksb)
  linksb<-paste("https://www.indeed.co.uk", linksb,sep="")
    }

####################

#all toghether now
  
scrapeindeed<-function(urlres) {
  linksbb<-getlinks(urlres)
  jobtitles<-lapply(FUN=getjobtitle, linksbb)%>%plyr::ldply(rbind)%>%mutate_if(is.factor,as.character)
  jobsdesc<-lapply (FUN=getjobdescindeed, linksbb)%>%plyr::ldply(rbind)%>%mutate_if(is.factor,as.character)
  jobmeta<-lapply (FUN=getmetadataindeed, linksbb)%>%plyr::ldply(rbind)%>%mutate_if(is.factor,as.character)
  tobemoved <- grepl("£", jobmeta[,2])
  jobmeta[tobemoved,3 ]<-jobmeta[tobemoved,2 ] 
  jobmeta[tobemoved,2 ] <-NA
  final<-cbind(jobtitles,jobsdesc,jobmeta)%>%`colnames<-`(c("Title", "Description", "Location","Type","Salary"))
  final
}

###############
#test 

results1<-scrapeindeed("https://www.indeed.co.uk/jobs?as_and=&as_phr=&as_any=&as_not=&as_ttl=&as_cmp=&jt=all&st=&as_src=&salary=&radius=25&l=ne18&fromage=3&limit=50&sort=&psf=advsrch")
head(results1)
