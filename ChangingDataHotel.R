## Step 1: Load Packages
install.packages('tidyverse')
install.packages('skimr')
install.packages('janitor')

library('tidyverse')
library('skimr') #compact and summaries data
library('janitor') #Examining and cleaning dirty
-------------------------------------------------

## Step 2: Import Data
hotel_bookings <- read.csv("HotelBookings.csv")

-------------------------------------------------

## Step 3 : Getting to know your data
head(hotel_bookings)     #head function to preview the columns and the first several rows
str(hotel_bookings)      #structured and glimpse function to get summarize of each column arranged horizontally
glimpse(hotel_bookings)
colnames(hotel_bookings) #to get the names of each columns and total columns
----------------------------------------------------------------------------------------------------------------

## Step 4: Manipulating Data
  
arrange(hotel_bookings, lead_time) #arrange hotel bookings by lead time
hotel_bookings_v2 <- arrange(hotel_bookings, lead_time) #create new df that had those changes saved, assign new df to alter the existing data frame
head(hotel_bookings_v2)

#arrange automatically orders by ascending order and you need to specifically tell it when to order by descending order, like below
arrange(hotel_bookings, desc(lead_time))
hotel_bookings_v2 <- arrange(hotel_bookings, desc(lead_time))
head(hotel_bookings_v2)

# Minimum and Maximum lead times without sorting the whole data set 
max(hotel_bookings$lead_time) #specify which column by run : max (which Dataset$which Columns))
min(hotel_bookings$lead_time)

# Average for booking session using mean function 
mean(hotel_bookings$lead_time)                  #104.0114
mean(hotel_bookings$arrival_date_day_of_month)  #15 hb (middle of month)
mean(hotel_bookings$arrival_date_week_number)   #Week 27 (almost in 6 months)
mean(hotel_bookings$arrival_date_year)          #2016

# Create new data set that only contains data about city hotels
# for min,max,mean or any calculation function we use $ between, for arrange and filter we use , between
hotel_bookings_city <- filter(hotel_bookings, hotel_bookings$hotel=="City Hotel") 
head(hotel_bookings_city) #to check out data
mean(hotel_bookings_city$lead_time) #to quickly check the average lead time of City Hotel from dataset hotel_bookings_city

#Calculate Lead time Hotel summary

hotel_summary <-
  hotel_bookings %>%  
  group_by(hotel) %>% 
  summarise (average_lead_time = mean(lead_time),
             min_lead_time = min(lead_time),
             max_lead_time = max(lead_time))

head(hotel_summary)

hotel_summary #average -> 110 - city hotel   , 92.7 - Resort Hotel
              #max     -> 737 - Resort Hotel , 629 - City Hotel
---------------------------------------------------------------------------
#Visualizing data using ggplot2
install.packages('ggplot2')
library('ggplot2')

ggplot(data=hotel_bookings) + geom_col (mapping = aes (x=arrival_date_month, y=lead_time, color=arrival_date_month)) + facet_wrap(~hotel)
ggplot(data=hotel_bookings) + geom_point(mapping = aes(x=lead_time, y = adults, color = is_repeated_guest))
ggplot(data=hotel_bookings) + geom_point(mapping = aes(x=stays_in_weekend_nights, y=children, color=is_repeated_guest)) 

#ggplot - aesthetics
ggplot(data=hotel_bookings) + geom_point(mapping = aes(x=stays_in_weekend_nights, y=children, shape=is_repeated_guest))  #difference from shape
ggplot(data=hotel_bookings) + geom_point(mapping = aes(x=stays_in_weekend_nights, y=children, size=is_repeated_guest))   #difference from size
ggplot(data=hotel_bookings) + geom_point(mapping = aes(x=stays_in_weekend_nights, y=children, alpha=is_repeated_guest))  #difference from alpha
ggplot(data=hotel_bookings) + geom_point(mapping = aes(x=stays_in_weekend_nights, y=children), color="purple")  #change the appearance of our overall plot without regard to specific variable

#geom - the geometrical object used to represent data
#1.geom_point with smooth line to know the pattern
ggplot(data=hotel_bookings) + 
  geom_smooth (mapping = aes (x=stays_in_weekend_nights, y=lead_time)) +
  geom_point (mapping = aes (x=stays_in_weekend_nights, y=lead_time)) 

#geom_point with different smooth line based on hotel 
ggplot(data=hotel_bookings) + 
  geom_smooth (mapping = aes (x=stays_in_weekend_nights, y=lead_time, linetype=hotel)) +
  geom_point (mapping = aes (x=stays_in_weekend_nights, y=lead_time)) 

#different smooth line based on hotel without geom_point
ggplot(data=hotel_bookings) + 
  geom_smooth (mapping = aes (x=stays_in_weekend_nights, y=lead_time, color=hotel, linetype=hotel)) 

#2.geom_jitter - scatter plot add a small amount of random noise to each point in the plot
ggplot(data=hotel_bookings) + 
  geom_jitter (mapping = aes (x=stays_in_weekend_nights, y=lead_time, color=hotel)) 

#3.geom_bar - use bar to create bar chart
ggplot(data=diamonds) + 
  geom_bar(mapping=aes(x=cut, color=cut))

ggplot(data=diamonds) + 
  geom_bar(mapping=aes(x=cut, fill=cut)) #different color by cut

ggplot(data=diamonds) + 
  geom_bar(mapping=aes(x=cut, fill=clarity)) #stacked bar chart and difference in clarity, difference in volume for each clarity

#4.geom_line - create line chart
ggplot(data=hotel_bookings) + 
  geom_line (mapping = aes (x=stays_in_weekend_nights, y=lead_time, linetype=hotel, color=hotel)) 

#5.Facet Functions
#Facet_wrap() - facet plot by single variable
ggplot(data=penguins) + 
  geom_point(mapping = aes(x=flipper_length_mm, y=body_mass_g, color=species)) +
  facet_wrap(~species)

ggplot(data=penguins)+
  geom_point(aes(color=species))+
  facet_wrap(~species)

ggplot(data=diamonds) + 
  geom_bar(mapping=aes(x=color, fill=cut)) +
  facet_wrap(~cut)

#Facet_grid() - facet your plot with 2 variables, split the plot into facet vertically
ggplot(data=penguins) + 
  geom_point(mapping = aes(x=flipper_length_mm, y=body_mass_g, color=species)) +
  facet_grid(sex~species) #2 variables
---------------------------------------------------------------------------------------------------
#Making any different charts
  #a bar chart showing each hotel type and market segment. use different color
  
ggplot(data=hotel_bookings) +
  geom_bar(mapping=aes(x=hotel, fill=market_segment))

ggplot(data=hotel_bookings) +
  geom_bar(mapping=aes(x=hotel, fill=hotel)) +
  facet_wrap(~market_segment)

#Filtering
library('tidyverse')
onlineta_city_hotels <- filter(hotel_bookings,
                               (hotel=="City Hotel" &
                                  hotel_bookings$market_segment=="Online TA"))

View(onlineta_city_hotels)

onlineta_city_hotels_v2 <- hotel_bookings %>%
  filter(hotel=="City Hotel") %>%
  filter(market_segment=="Online TA"
         
View(onlineta_city_hotels_v2)

#Use your new dataframe

ggplot(data=onlineta_city_hotels) +
  geom_point(mapping=aes(x=lead_time, y=children))
------------------------------------------------------------
#Annotating your chart

ggplot(data=hotel_bookings)+
  geom_bar(mapping=aes(x=market_segment))+
  facet_wrap(~hotel)+
  labs(title="Comparison of market segments by hotel type for hotel bookings"))

#Add another detail about what time period this data covers

min(hotel_bookings$arrival_date_year) #2015
max(hotel_bookings$arrival_date_year) #2017

#but you will need to save them as variables in order to easily use them in your labeling
mindate <- min(hotel_bookings$arrival_date_year)
maxdate <- max(hotel_bookings$arrival_date_year)

#Now, you will add in a subtitle using `subtitle=` in the `labs()` function. Then, you can use the `paste0()` function to use your newly-created variables in your labels.
#subtitle will be appear on the top of chart
ggplot(data=hotel_bookings)+
  geom_bar(mapping=aes(x=market_segment))+
  facet_wrap(~hotel)+
  labs(title="Comparison of market segments by hotel type for hotel bookings",
       subtitle=paste0("Data from: ", mindate, " to ", maxdate))

#switch the `subtitle`  to a `caption` which will appear in the bottom right corner instead.
ggplot(data=hotel_bookings)+
  geom_bar(mapping=aes(x=market_segment))+
  facet_wrap(~hotel)+
  labs(title="Comparison of market segments by hotel type for hotel bookings",
       caption=paste0("Data from: ", mindate, " to ", maxdate))

#clean up the x and y labels to make sure they are really clear. To do that, you can add to the labs() and use x and y
ggplot(data=hotel_bookings)+
  geom_bar(mapping=aes(x=market_segment))+
  facet_wrap(~hotel)+
  labs(title="Comparison of market segments by hotel type for hotel bookings",
       caption=paste0("Data from: ", mindate, " to ", maxdate),
       x="Market Segment",
       y="Number of bookings")

#Save plot
ggsave('hotel_booking_chart.png',
       width=16,
       height=8)