#Pipes Nested using dyplr package

data("ToothGrowth")
View("ToothGrowth")
install.packages("dyplr")

filtered_tg <- filter(ToothGrowth, dose == 0.5)
filtered_tg # list out all toothgrowth that have 0.5 dose 

arrange(filtered_tg, len) # arranged in ascending order by len (length), return rows where the dose amount 0.5 only.

#Nested function
arrange(filter(ToothGrowth, dose == 0.5), len)

#Pipe operator - use ctrl+shift+m 
filtered_toothgrowth <- ToothGrowth %>%
  filter(dose == 0.5) %>%      
  arrange(len) 

filtered_toothgrowth <- ToothGrowth %>%
  filter(dose == 0.5) %>%      
  group_by(supp) %>% 
  summarize(mean_len = mean(len, na.rm = T), .group = "drop")

filtered_toothgrowth #check