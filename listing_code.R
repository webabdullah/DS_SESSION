getwd()
# Grammar of Grapfics & GGPlot2
# Factor in R
# Aesthetics & ggplot()
# Plotting with layers
# Overriding Aesthetics
# Mapping & Setting
# Histograms and Density Charts
# Starting Layer Tips
# Statistical Transformation
# Using Facets
# Coordinates
# Themes

getwd()
setwd("D:/DS/01")
getwd()
?read.csv

#membaca file dataset dalam format tabel.csv 
movieratings <- read.csv("MovieRatings.csv")


# Proses Explorasi Data movieratings
head(movieratings)
summary(movieratings)

#mengatur nama baris dan colom dari objek Filem
colnames(movieratings) <- c("Film", "Genre", "CriticRating", "AudienceRating", "BudgetMillions", "Year")
head(movieratings)
tail(movieratings)

#Mengkonversi tipe data filem dan genre menjadi faktor ketegori
movieratings$Film <- as.factor(movieratings$Film)
movieratings$Genre <-as.factor(movieratings$Genre)
str(movieratings)
summary(movieratings)

# membuat karater angka tahun sebagai faktor
factor(movieratings$Year)
movieratings$Year <- factor(movieratings$Year)
str(movieratings)
summary(movieratings)

#packing Install library ggplot2
#install.packages(ggplot2)

# Dan memanggil library ggplot2
library(ggplot2)

ggplot(data=movieratings, aes(x=CriticRating, y=AudienceRating))+ geom_point()
ggplot(data=movieratings, aes(x=CriticRating, y=AudienceRating, colour=Genre, size=Genre))+ geom_point()
ggplot(data=movieratings, aes(x=CriticRating, y=AudienceRating, colour=Genre, size=BudgetMillions))+ geom_point()
p<-ggplot(data=movieratings, aes(x=CriticRating, y=AudienceRating, colour=Genre, size=Genre))
p + geom_point()
p + geom_line()
p + geom_point() + geom_line()


# Overriding data berdasarkan critik ratig dan genre
q <-ggplot(data=movieratings, aes(x=CriticRating, y=AudienceRating, colour=Genre, size=BudgetMillions))
q + geom_point()
q + geom_point(aes(size=CriticRating))
q + geom_point(aes(colour=BudgetMillions))

#membuat inisiasi q untuk membuat variabel x berupa nilai bugdet
q + geom_point()
q + geom_point(aes(x=BudgetMillions))
q + geom_line() + geom_point()

#mereduce ukuran garis
q + geom_line(size=1) + geom_point()

# membuat mapping dengan inisiasi R
r <- ggplot(data=movieratings, aes(x=CriticRating, y=AudienceRating))
r+geom_point()

# menabahkan warna pada grapik

r + geom_point(aes(colour=Genre))

#2. Setting
r + geom_point(colour="DarkGreen")

#error
r + geom_point(aes(colour="DarkGreen"))

#1. Mapping
r + geom_point(aes(size=BudgetMillions))
#2. Setting
r +  geom_point(size=10)

#error
r +geom_point(aes(size=10))

#----Histogram and Density Chart
s <- ggplot(data=movieratings, aes(x=BudgetMillions))
s + geom_histogram(binwidth = 10)

#add colour
s + geom_histogram(binwidth = 10, aes(fill=Genre))

# add border
s + geom_histogram(binwidth = 10, aes(fill=Genre), colour="Black")

#Density Chart

s + geom_density(aes(fill=Genre))
s + geom_density(aes(fill=Genre), position = "stack")

#-----Starting Layer Tips
t <- ggplot(data=movieratings, aes(x=AudienceRating))
t + geom_histogram(binwidth = 10, fill="White", colour="Blue")

#Cara lain
t <- ggplot(data=movieratings)
t + geom_histogram(binwidth = 10,aes(x=AudienceRating), fill="White", colour="Blue")

#
t + geom_histogram(binwidth = 10,aes(x=CriticRating), fill="White", colour="Blue")

#-----------Statistical Transformation

geom_smooth

u <-ggplot(data=movieratings, aes(x=CriticRating, y=AudienceRating, colour=Genre))

u + geom_point()+ geom_smooth()
u + geom_point()+ geom_smooth(fill=NA)

#boxplots
u <- ggplot(data=movieratings, aes(x=Genre, y=AudienceRating, colour=Genre))
u + geom_boxplot()
u + geom_boxplot(size=1.2)
u + geom_boxplot(size=1.2) +geom_point()

#tip
u + geom_boxplot(size=1.2)+geom_jitter()

#cara lain
u + geom_jitter()+ geom_boxplot(size=1.2, alpha=0.5)

# ----Using Facet

v <- ggplot(data=movieratings, aes(x=BudgetMillions))
v + geom_histogram(binwidth = 10, aes(fill=Genre),colour="Black")

#facet
v + geom_histogram(binwidth = 10, aes(fill=Genre), colour="Black")+
  facet_grid(Genre~., scales="free")

#Scatterplots:
w <- ggplot(data=movieratings, aes(x=CriticRating, y=AudienceRating, colour=Genre))

w + geom_point(size = 3)
#Facet
w + geom_point(size = 3)+
  facet_grid(Genre~.)

w + geom_point(size = 3)+
  facet_grid(.~Year)

w + geom_point(size = 3)+
  facet_grid(Genre~Year)

w + geom_point(size = 3) +
  geom_smooth() +
  facet_grid(Genre~Year) w + geom_point(aes(size = BudgetMillions)) +
  geom_smooth() + facet_grid(Genre~Year)

#-----Coordinates

m <- ggplot(data=movieratings, aes(x=CriticRating, y= AudienceRating, size=BudgetMillions, colour=Genre))
m + geom_point()  

m + geom_point() +
  xlim(50, 100) + # menghapus 304 row containing missing value
  ylim(50,100) # menghapus 335 row containing missing value

#fungsi xlim dan Ylim tidak jalan utk kasus berikut
n <- ggplot(data=movieratings, aes(x=BudgetMillions))
n + geom_histogram(binwidth = 10, aes(fill=Genre), colour="Black")

n + geom_histogram(binwidth = 10, aes(fill=Genre), colour="Black")+
  ylim(0,50)

#instead - zoom
n + geom_histogram(binwidth = 10, aes(fill=Genre), colour="Black")+
  coord_cartesian(ylim=c(0,50))

#improve
w + geom_point(aes(size = BudgetMillions)) +
  geom_smooth() + facet_grid(Genre~Year) + coord_cartesian(ylim=c(0,100))

?theme
# Modify components of a theme
o <- ggplot(data=movieratings, aes(x=BudgetMillions))
h <- o + geom_histogram(binwidth = 10, aes(fill=Genre),colour="Black")
h
# Membuat grapik X dan Y Genre
h +
  xlab("Money Axis") +
  ylab("Number of movieratings")
#label formatting
h +
  xlab("Money Axis") +
  ylab("Number of movieratings")+
  theme(axis.title.x = element_text(colour="DarkGreen", size=30),
        axis.title.y = element_text(colour="Red", size=30))



# tick mark formatting
h +
  xlab("Money Axis") +
  ylab("Number of movieratings")+
  theme(axis.title.x = element_text(colour="DarkGreen", size=30),
        axis.title.y = element_text(colour="Red", size=30),
        axis.text.x = element_text(size=20),
        axis.text.y = element_text(size=20))
?theme

#legend formatting
h +
  xlab("Money Axis") +
  ylab("Number of movieratings")+
  ggtitle("Movie Budget Distribution")+
  theme(axis.title.x = element_text(colour="DarkGreen", size=30),
        axis.title.y = element_text(colour="Red", size=30),
        axis.text.x = element_text(size=20),
        axis.text.y = element_text(size=20),
        
        legend.title = element_text(size=30),
        legend.text = element_text(size=20),
        legend.position = c(1,1),
        legend.justification = c(1,1),
        plot.title = element_text(colour="DarkBlue",
                                  size=40,
                                  family = "Courier"))
