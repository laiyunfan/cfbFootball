############
###  Extracts the top table from wikipedia - playing (if applicable) and coaching career
############

my.function <- function(foo, bar){
  # construct a matrix with start/end character positions
  start <- head(c(1,bar+1),-1) # delete last one
  sel <- cbind(start=start,end=bar)
  strings <- apply(sel, 1, function(x) substr(foo, x[1], x[2]))
  paste(strings, collapse=',')
}

tables <- readHTMLTable(theURL)

if(nrow(tables[[1]][tables[[1]][,1]=="Coaching career (HC unless noted)",])==1){
 if(nrow(tables[[1]][tables[[1]][,1]=="Playing career",])==0){

   pc <- as.numeric(rownames(tables[[1]][tables[[1]][,1]=="Coaching career (HC unless noted)",]))
   test <- tables[[1]][c( (pc+1)),]
   years <- unlist(strsplit(as.character(test[1,1]), split="\n"))
   coach <- as.character(test[1,2])
   tp <- unlist(gregexpr(")[A-Z]",coach))                #Finds locations to add commas - right ) follwed by capital letter
   tp2 <- unlist(gregexpr("[a-z][A-Z]",coach))
    if(tp2[1]>0){
     tp.1 <- c(tp,tp2,nchar(coach))
      } else{
       tp.1 <- c(tp,nchar(coach))
      }
   tp.1 <- sort(tp.1)
   coach.1 <- unlist(strsplit(my.function(coach,tp.1),","))
   school <- gsub("*\\(.*\\)$","",coach.1)        #extracts coaching school
   position <- gsub("^.*\\(|\\)$","",coach.1)     #extracts portion in parentheses
   school <- sub("^[[:space:]]*(.*?)[[:space:]]*$", "\\1", school, perl=TRUE)    #removes trailing white space
     coaching <- cbind(years,school,position)

  } else{

    pc <- as.numeric(rownames(tables[[1]][tables[[1]][,1]=="Playing career",]))
    test <- tables[[1]][c( (pc+1),(pc+2), (pc+4) ),] 
    years <- unlist(strsplit(as.character(test[3,1]), split="\n"))
    coach <- as.character(test[3,2])
    tp <- unlist(gregexpr(")[A-Z]",coach))                #Finds locations to add commas - right ) follwed by capital letter
    tp2 <- unlist(gregexpr("[a-z][A-Z]",coach))
     if(tp2[1]>0){
      tp.1 <- c(tp,tp2,nchar(coach))
       } else{
        tp.1 <- c(tp,nchar(coach))
       }
    tp.1 <- sort(tp.1)
    coach.1 <- unlist(strsplit(my.function(coach,tp.1),","))
    school <- gsub("*\\(.*\\)$","",coach.1)        #extracts coaching school
    position <- gsub("^.*\\(|\\)$","",coach.1)     #extracts portion in parentheses
    school <- sub("^[[:space:]]*(.*?)[[:space:]]*$", "\\1", school, perl=TRUE)    #removes trailing white space
      coaching <- cbind(years,school,position)
    playcarY <- unlist(strsplit(as.character(test[1,1]), split="\n"))
    playcarT <- as.character(test[1,2])
    tp3 <- c(unlist(gregexpr("[a-z][A-Z]",playcarT)),nchar(playcarT))
    playcarT.1 <- unlist(strsplit(my.function(playcarT,tp3),","))
    playcarT <- gsub("*\\(.*\\)$","",playcarT.1)
    playpos <- rep(as.character(test[2,2]),2)
      playcar <- cbind(playcarY,playcarT,playpos)
  }

 } else { 

 if(nrow(tables[[2]][tables[[2]][,1]=="Playing career",])==0){
   pc <- as.numeric(rownames(tables[[2]][tables[[2]][,1]=="Coaching career (HC unless noted)",]))
   test <- tables[[2]][c( (pc+1)),]
   years <- unlist(strsplit(as.character(test[1,1]), split="\n"))
   coach <- as.character(test[1,2])
   tp <- unlist(gregexpr(")[A-Z]",coach))                #Finds locations to add commas - right ) follwed by capital letter
   tp2 <- unlist(gregexpr("[a-z][A-Z]",coach))
    if(tp2[1]>0){
     tp.1 <- c(tp,tp2,nchar(coach))
      } else{
       tp.1 <- c(tp,nchar(coach))
      }
   tp.1 <- sort(tp.1)
   coach.1 <- unlist(strsplit(my.function(coach,tp.1),","))
   school <- gsub("*\\(.*\\)$","",coach.1)        #extracts coaching school
   position <- gsub("^.*\\(|\\)$","",coach.1)     #extracts portion in parentheses
   school <- sub("^[[:space:]]*(.*?)[[:space:]]*$", "\\1", school, perl=TRUE)    #removes trailing white space
     coaching <- cbind(years,school,position)

  } else{

    pc <- as.numeric(rownames(tables[[2]][tables[[2]][,1]=="Playing career",]))
    test <- tables[[2]][c( (pc+1),(pc+2), (pc+4) ),] 
    years <- unlist(strsplit(as.character(test[3,1]), split="\n"))
    coach <- as.character(test[3,2])
    tp <- unlist(gregexpr(")[A-Z]",coach))                #Finds locations to add commas - right ) follwed by capital letter
    tp2 <- unlist(gregexpr("[a-z][A-Z]",coach))
     if(tp2[1]>0){
      tp.1 <- c(tp,tp2,nchar(coach))
       } else{
        tp.1 <- c(tp,nchar(coach))
       }
    tp.1 <- sort(tp.1)
    coach.1 <- unlist(strsplit(my.function(coach,tp.1),","))
    school <- gsub("*\\(.*\\)$","",coach.1)        #extracts coaching school
    position <- gsub("^.*\\(|\\)$","",coach.1)     #extracts portion in parentheses
    school <- sub("^[[:space:]]*(.*?)[[:space:]]*$", "\\1", school, perl=TRUE)    #removes trailing white space
      coaching <- cbind(years,school,position)
    playcarY <- unlist(strsplit(as.character(test[1,1]), split="\n"))
    playcarT <- as.character(test[1,2])
    tp3 <- c(unlist(gregexpr("[a-z][A-Z]",playcarT)),nchar(playcarT))
    playcarT.1 <- unlist(strsplit(my.function(playcarT,tp3),","))
    playcarT <- gsub("*\\(.*\\)$","",playcarT.1)
    playpos <- rep(as.character(test[2,2]),2)
      playcar <- cbind(playcarY,playcarT,playpos)

  }
}


########
##extracting head coaching table - team names and records/bowl games
########

if(length(tables[[1]][,1])==1){
  winloss1<-tables[[4]]
  } else {
   winloss1<-tables[[3]]
}

winloss1$Year1<-as.numeric(as.character(winloss1$Year))
winloss<-subset(winloss1,Year1>0)#

Overall1<-as.character(winloss$Overall)
conf<-as.character(winloss$Conference)
stand<-as.character(winloss$Standing)
bowl<-as.character(winloss$"Bowl/Playoffs")

y<-c(0:(length(Overall1)-1))
n<-4
win<-rep(1+y*n,1)
loss<-rep(4+y*n,1)

winloss$oW<-as.numeric(unlist(strsplit(gsub("[^0-9]",",",Overall1),","))[win])
winloss$OL<-as.numeric(unlist(strsplit(gsub("[^0-9]",",",Overall1),","))[loss])
winloss$cW<-as.numeric(unlist(strsplit(gsub("[^0-9]",",",conf),","))[win])
winloss$cL<-as.numeric(unlist(strsplit(gsub("[^0-9]",",",conf),","))[loss])
winloss$stand <- as.numeric(unlist(gsub("[^0-9]","",stand)))

winloss$coachRank<-as.numeric(as.character(winloss[,7]))
winloss$apRank<-as.numeric(as.character(winloss[,8]))
winloss$bowl<-winloss$"Bowl/Playoffs"


hCoach<-winloss[c(2,9:length(winloss))]
colnames(hCoach)[2] <- "Year"


######
##Coaching table
######
coach1<-data.frame(coaching)
yrs<-as.character(coach1$years)
test<-data.frame(yr=unlist(strsplit(gsub("[^0-9]",",",yrs),",")),
  time=sequence(sapply(strsplit(gsub("[^0-9]",",",yrs),","),length)))
startyr<-subset(test,time==1)
endyr<-subset(test,time==7)

yrs2<-rbind(startyr,endyr)
yrs2$id<-as.numeric(rownames(yrs2))
yrs2<-yrs2[order(yrs2$id), ]
yrs2$yr<-as.numeric(as.character(yrs2$yr))

yrs2$yr<- ifelse(is.na(yrs2$yr),2012,yrs2$yr)

for(i in 1:length(yrs2$id)){
 if(i == length(yrs2$id)){
 break
} else {
 if(yrs2$time[i]==yrs2$time[i+1]){
   yrs2$st[i]<-yrs2$yr[i]
   yrs2$end[i]<-yrs2$yr[i]
  } else {
   yrs2$st[i]<-yrs2$yr[i]
   yrs2$end[i]<-yrs2$yr[i+1]
  }
 }
}

stend <- subset(yrs2,time==1)[,c(4:5)]

nyrs <- stend[,2]-stend[,1]+1

sch<-as.character(coach1$school)
pos <- as.character(coach1$position)

coach3 <- data.frame(cbind(yrs2[1,1]:yrs2[nrow(yrs2),1],rep(sch,nyrs),rep(pos,nyrs)),stringsAsFactors=FALSE)
names(coach3) <- c("Year","School","Position")

coach3$Position <- ifelse(coach3$School==coach3$Position,"HC",coach3$Position)
coach3$Career <- "Coach"

########
#Playing Career
########

play1<-data.frame(playcar)
yrs<-as.character(play1$playcarY)
test<-data.frame(yr=unlist(strsplit(gsub("[^0-9]",",",yrs),",")),
  time=sequence(sapply(strsplit(gsub("[^0-9]",",",yrs),","),length)))
startyr<-subset(test,time==1)
endyr<-subset(test,time==7)

yrs2<-rbind(startyr,endyr)
yrs2$id<-as.numeric(rownames(yrs2))
yrs2<-yrs2[order(yrs2$id),]
yrs2$yr<-as.numeric(as.character(yrs2$yr))


for(i in 1:length(yrs2$id)){
 if(i == length(yrs2$id)){
 break
} else {
 if(yrs2$time[i]==yrs2$time[i+1]){
   yrs2$st[i]<-yrs2$yr[i]
   yrs2$end[i]<-yrs2$yr[i]
  } else {
   yrs2$st[i]<-yrs2$yr[i]
   yrs2$end[i]<-yrs2$yr[i+1]
  }
 }
}

stend <- subset(yrs2,time==1)[,c(4:5)]

nyrs <- stend[,2]-stend[,1]+1

sch<-as.character(play1$playcarT)
pos <- as.character(play1$playpos)


play3 <- data.frame(cbind(yrs2[1,1]:yrs2[nrow(yrs2),1],rep(sch,nyrs),rep(pos,nyrs)),stringsAsFactors=FALSE)
names(play3) <- c("Year","School","Position")
play3$Career <- "Player"

play3 <- play3[-c(1:length(play3$Year)/2),]

career <- rbind(play3,coach3)
