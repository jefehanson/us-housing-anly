library(tidyverse)
read_csv("metrohousing-us-nov-2022.csv")

metro_housing_raw <- read_csv("metrohousing-us-nov-2022.csv")

metro_housing_raw

metro_housing <- metro_housing_raw %>% 
  pivot_longer(cols = -c(RegionID, SizeRank, RegionName, RegionType, StateName), 
               names_to = "date", values_to = "home_value") %>% 
  mutate(date = as.Date(date))

metro_housing


#filter CA metro areas

ca_housing <- metro_housing %>% 
  filter(StateName =="CA") %>% 
  mutate(RegionName = fct_reorder2(RegionName, date, home_value, .desc = FALSE))

ggplot(ca_housing)+
  geom_line(mapping = aes(x = date, y = home_value, color = RegionName), 
            size = .7, alpha = .7)+
  guides(color = guide_legend(reverse=TRUE))
