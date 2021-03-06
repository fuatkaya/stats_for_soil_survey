#############################

BC_All <- 
  read.table('https://raw.githubusercontent.com/ncss-tech/stats_for_soil_survey/master/presentations/sampling/pdf_example/All_30m_waccessfld.txt',
             header=TRUE, sep=",", na.strings="NA", dec=".", strip.white=TRUE)

BC_Access<- 
  read.table("https://raw.githubusercontent.com/ncss-tech/stats_for_soil_survey/master/presentations/sampling/pdf_example/Access_30m.txt",
             header=TRUE, sep=",", na.strings="NA", dec=".", strip.white=TRUE)

BC_target<- 
  read.table("https://raw.githubusercontent.com/ncss-tech/stats_for_soil_survey/master/presentations/sampling/pdf_example/BC_target.txt",
             header=TRUE, sep=",", na.strings="NA", dec=".", strip.white=TRUE)


#-------------
#there are likely better ways to accomplish this; but this was the process used for this project

#create lists with the same variable (identified by column notation) for all three datasets
# use names(BC_All) to see the orientation of columns

NDVI	<-list(BC_All[,5],BC_Access[,5],BC_target[,2])
LS_5MIN2DI	<-list(BC_All[,6],BC_Access[,6],BC_target[,3])
LS_5MIN7DI	<-list(BC_All[,7],BC_Access[,7],BC_target[,4])
DISTROAD	<-list(BC_All[,8],BC_Access[,8], BC_target[,5])
TWI	<-list(BC_All[,9],BC_Access[,9], BC_target[,6])
TPI_10	<-list(BC_All[,10],BC_Access[,10], BC_target[,7])
Strm_pwr <-list(BC_All[,11],BC_Access[,11] ,BC_target[,8])


#---------------------
#Create a vector of the sample numbers for use in the legend
#these corspond to the datasets used to create the lists
num <- c("Environmental Covariate", "Accessible Covariate", "Target Sample Covariate")
#Set line colors, types and widths
mycol = c("red", "darkcyan", "green")
mylwidth = c(4,2,2)
myback = rep("white",2)

#------------------------------
#Plot NDVI
den.NDVI = sapply(NDVI, density, kernel = "cosine", na.rm = TRUE)

#Average the bandwithds in the samples and use this number to set the bandwitdths equal
a <- sum(den.NDVI[[3,1]], den.NDVI[[3,2]], den.NDVI[[3,3]])/3

#Make all of the bandwidths for the different sample sizes the same. There may be an easier way to do this but all I could figure out was to do it one at a time.
den.NDVI[[3,1]] = a
den.NDVI[[3,2]] = a
den.NDVI[[3.3]] = a


plot(den.NDVI[,1], type = "n")
apply(den.NDVI, 2, lines, type="l", col = mycol)
plot(den.NDVI[,1],type="n", main = "NDVI", xlab = "NDVI", ylab = "Density",
     cex = 1, cex.axis = 1.5, cex.main = 2.5, cex.lab = 1.2, font.lab = 3)

for(i in 1:ncol(den.NDVI)){
  lines(den.NDVI[,i], col = mycol[i], lwd = mylwidth[i])
}

#The pch, pt.bg, and merge all get rid of the annoying little boxs that are plotted next to the line if these commands are not included. I found these at http://tolstoy.newcastle.edu.au/R/e4/help/08/01/1654.html
legend ("topleft", y = NULL, legend = num, pch = c(NA,NA,NA,NA),
        inset = c(0.01,0.01), col = mycol, pt.bg = myback, lwd = mylwidth, merge = T, bty = "o")

#This command saves whatever is in the graph window. 
#This can be changed to save where you like   
dev.copy(pdf,'C:/R_data/NDVI.pdf')
dev.off()

#------------------------------

#Plot LS_5MIN2DI
den.LS_5MIN2DI = sapply(LS_5MIN2DI, density, kernel = "cosine", na.rm = TRUE)

#Average the bandwithds in the samples and use this number to set the bandwitdths equal
#a <- sum(den.LS_5MIN2DI[[3,1]], den.LS_5MIN2DI[[3,2]])/2

#Make all of the bandwidths for the different sample sizes the same. There may be an easier way to do this but all I could figure out was to do it one at a time.
#den.LS_5MIN2DI[[3,1]] = a
#den.LS_5MIN2DI[[3,2]] = a

plot(den.LS_5MIN2DI[,1], type = "n")
apply(den.LS_5MIN2DI, 2, lines, type="l", col = mycol)
plot(den.LS_5MIN2DI[,1],type="n", main = "LS Band Ration: 5-2/5+2", xlab = "LS_5MIN2DIv5PLUS2", ylab = "Density",
     cex = 1, cex.axis = 1.5, cex.main = 2.5, cex.lab = 1.2, font.lab = 3)

for(i in 1:ncol(den.LS_5MIN2DI)){
  lines(den.LS_5MIN2DI[,i], col = mycol[i], lwd = mylwidth[i])
}

#The pch, pt.bg, and merge all get rid of the annoying little boxs that are plotted next to the line if these commands are not included. I found these at http://tolstoy.newcastle.edu.au/R/e4/help/08/01/1654.html
legend ("topleft", y = NULL, legend = num, pch = c(NA,NA,NA,NA),
        inset = c(0.01,0.01), col = mycol, pt.bg = myback, lwd = mylwidth, merge = T, bty = "o")

#This command saves whatever is in the graph window. This can be changed to save   
dev.copy('*/LS_5MIN2DIv5PLUS2.pdf')
dev.off()

#------------------------------

##Plot LS_5MIN7DI
den.LS_5MIN7DI = sapply(LS_5MIN7DI, density, kernel = "cosine", na.rm = TRUE)

#Average the bandwithds in the samples and use this number to set the bandwitdths equal
#a <- sum(den.LS_5MIN7DI[[3,1]], den.LS_5MIN7DI[[3,2]])/2

#Make all of the bandwidths for the different sample sizes the same. There may be an easier way to do this but all I could figure out was to do it one at a time.
#den.LS_5MIN7DI[[3,1]] = a
#den.LS_5MIN7DI[[3,2]] = a

plot(den.LS_5MIN7DI[,1], type = "n")
apply(den.LS_5MIN7DI, 2, lines, type="l", col = mycol)
plot(den.LS_5MIN7DI[,1],type="n", main = "LS Band Ration: 5-7/5+7", xlab = "LS_5MIN7DIV5PLUS7", ylab = "Density",
     cex = 1, cex.axis = 1.5, cex.main = 2.5, cex.lab = 1.2, font.lab = 3)

for(i in 1:ncol(den.LS_5MIN7DI)){
  lines(den.LS_5MIN7DI[,i], col = mycol[i], lwd = mylwidth[i])
}

#The pch, pt.bg, and merge all get rid of the annoying little boxs that are plotted next to the line if these commands are not included. I found these at http://tolstoy.newcastle.edu.au/R/e4/help/08/01/1654.html
legend ("topleft", y = NULL, legend = num, pch = c(NA,NA,NA,NA),
        inset = c(0.01,0.01), col = mycol, pt.bg = myback, lwd = mylwidth, merge = T, bty = "o")

#This command saves whatever is in the graph window. This can be changed to save   
dev.copy(pdf,'*/LS_5MIN7DIV5PLUS7.pdf')
dev.off()

#------------------------------
#Plot DISTROAD
den.DISTROAD = sapply(DISTROAD, density, kernel = "cosine", na.rm = TRUE)

#Average the bandwithds in the samples and use this number to set the bandwitdths equal
#a <- sum(den.DISTROAD[[3,1]], den.DISTROAD[[3,2]])/2

#Make all of the bandwidths for the different sample sizes the same. There may be an easier way to do this but all I could figure out was to do it one at a time.
#den.DISTROAD[[3,1]] = a
#den.DISTROAD[[3,2]] = a

plot(den.DISTROAD[,1], type = "n")
apply(den.DISTROAD, 2, lines, type="l", col = mycol)
plot(den.DISTROAD[,1],type="n", main = "Distance to Road", xlab = "Distance to Road", ylab = "Density",
     cex = 1, cex.axis = 1.5, cex.main = 2.5, cex.lab = 1.2, font.lab = 3)

for(i in 1:ncol(den.NDVI)){
  lines(den.NDVI[,i], col = mycol[i], lwd = mylwidth[i])
}

#The pch, pt.bg, and merge all get rid of the annoying little boxs that are plotted next to the line if these commands are not included. I found these at http://tolstoy.newcastle.edu.au/R/e4/help/08/01/1654.html
legend ("topleft", y = NULL, legend = num, pch = c(NA,NA,NA,NA),
        inset = c(0.01,0.01), col = mycol, pt.bg = myback, lwd = mylwidth, merge = T, bty = "o")

#This command saves whatever is in the graph window. This can be changed to save   
dev.copy(pdf,'*/DISTROAD.pdf')
dev.off()

#------------------------------

#Plot TWI
den.TWI = sapply(TWI, density, kernel = "cosine", na.rm = TRUE)

#Average the bandwithds in the samples and use this number to set the bandwitdths equal
#a <- sum(den.TWI[[3,1]], den.TWI[[3,2]])/2

#Make all of the bandwidths for the different sample sizes the same. There may be an easier way to do this but all I could figure out was to do it one at a time.
#den.TWI[[3,1]] = a
#den.TWI[[3,2]] = a

plot(den.TWI[,1], type = "n")
apply(den.TWI, 2, lines, type="l", col = mycol)


plot(den.TWI[,1],type="n", main = "TWI", xlab = "TWI", ylab = "Density",
     cex = 1, cex.axis = 1.5, cex.main = 2.5, cex.lab = 1.2, font.lab = 3)

for(i in 1:ncol(den.TWI)){
  lines(den.TWI[,i], col = mycol[i], lwd = mylwidth[i])
}

#The pch, pt.bg, and merge all get rid of the annoying little boxs that are plotted next to the line if these commands are not included. I found these at http://tolstoy.newcastle.edu.au/R/e4/help/08/01/1654.html
legend ("topright", y = NULL, legend = num, pch = c(NA,NA,NA,NA),
        inset = c(0.01,0.01), col = mycol, pt.bg = myback, lwd = mylwidth, merge = T, bty = "o")

#This command saves whatever is in the graph window. This can be changed to save   
dev.copy(pdf,'*/TWI.pdf')
dev.off()

#------------------------------

#Plot TPI_10
den.TPI_10= sapply(TPI_10, density, kernel = "cosine", na.rm = TRUE)

#Average the bandwithds in the samples and use this number to set the bandwitdths equal
#a <- sum(den.TPI_10[[3,1]], den.TPI_10[[3,2]])/2

#Make all of the bandwidths for the different sample sizes the same. There may be an easier way to do this but all I could figure out was to do it one at a time.
#den.TPI_10[[3,1]] = a
#den.TPI_10[[3,2]] = a

plot(den.TPI_10[,1], type = "n")
apply(den.TPI_10, 2, lines, type="l", col = mycol)
plot(den.TPI_10[,1],type="n", main = "TPI_10", xlab = "TPI_10", ylab = "Density",
     cex = 1, cex.axis = 1.5, cex.main = 2.5, cex.lab = 1.2, font.lab = 3)

for(i in 1:ncol(den.TPI_10)){
  lines(den.TPI_10[,i], col = mycol[i], lwd = mylwidth[i])
}
#The pch, pt.bg, and merge all get rid of the annoying little boxs that are plotted next to the line if these commands are not included. I found these at http://tolstoy.newcastle.edu.au/R/e4/help/08/01/1654.html
legend ("topright", y = NULL, legend = num, pch = c(NA,NA,NA,NA),
        inset = c(0.01,0.01), col = mycol, pt.bg = myback, lwd = mylwidth, merge = T, bty = "o")

#This command saves whatever is in the graph window. This can be changed to save   
dev.copy(pdf,'C:/Documents and Settings/skye.wills/My Documents/Projects/WY-Powder River/R/Graphs/TPI_10.pdf')
dev.off()

#------------------------------
#Plot Strm_pwr
den.Strm_pwr = sapply(Strm_pwr, density, kernel = "cosine", na.rm = TRUE)

#Average the bandwithds in the samples and use this number to set the bandwitdths equal
#a <- sum(den.Strm_pwr[[3,1]], den.Strm_pwr[[3,2]])/2

#Make all of the bandwidths for the different sample sizes the same. There may be an easier way to do this but all I could figure out was to do it one at a time.
#den.Strm_pwr[[3,1]] = a
#den.Strm_pwr[[3,2]] = a

plot(den.Strm_pwr[,1], type = "n")
apply(den.Strm_pwr, 2, lines, type="l", col = mycol)
plot(den.Strm_pwr[,1],type="n", main = "Stream Power", xlab = "Stream Power", ylab = "Density",
     cex = 1, cex.axis = 1.5, cex.main = 2.5, cex.lab = 1.2, font.lab = 3)

for(i in 1:ncol(den.Strm_pwr)){
  lines(den.Strm_pwr[,i], col = mycol[i], lwd = mylwidth[i])
}

#The pch, pt.bg, and merge all get rid of the annoying little boxs that are plotted next to the line if these commands are not included. I found these at http://tolstoy.newcastle.edu.au/R/e4/help/08/01/1654.html
legend ("topright", y = NULL, legend = num, pch = c(NA,NA,NA,NA),
        inset = c(0.01,0.01), col = mycol, pt.bg = myback, lwd = mylwidth, merge = T, bty = "o")

#This command saves whatever is in the graph window. This can be changed to save   
dev.copy(pdf,'*/Strm_pwr.pdf')
dev.off()


#------------------------------
############################
#------------------------------
#Plot NDVI all only
NDVIA	<-list(BC_All[,5])
den.NDVIA = sapply(NDVIA, density, kernel = "cosine", na.rm = TRUE)

plot(den.NDVIA[,1], type = "n")
apply(den.NDVIA, 2, lines, type="l", col = mycol)
plot(den.NDVIA[,1],type="n", main = "NDVI", xlab = "NDVI", ylab = "Density",
     cex = 1, cex.axis = 1.5, cex.main = 2.5, cex.lab = 1.2, font.lab = 3)

for(i in 1:ncol(den.NDVIA)){
  lines(den.NDVIA[,i], col = "red", lwd = 2)
}


#The pch, pt.bg, and merge all get rid of the annoying little boxs that are plotted next to the line if these commands are not included. I found these at http://tolstoy.newcastle.edu.au/R/e4/help/08/01/1654.html
legend ("topleft", y = NULL, legend = num, pch = c(NA,NA,NA,NA),
        inset = c(0.01,0.01), col = mycol, pt.bg = myback, lwd = mylwidth, merge = T, bty = "o")

#This command saves whatever is in the graph window. This can be changed to save   
dev.copy(pdf,'C:/Documents and Settings/skye.wills/My Documents/Projects/WY-Powder River/R/Graphs/NDVI_all.pdf')
dev.off()
