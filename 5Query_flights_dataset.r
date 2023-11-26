##HW01 - 5 Questions ask about flights data set
##modifies add comments
##add new comments test conncet with gits

view(airlines)
## Q1: Which five airlines traveled the most in the year 2013?
ans1 <- flights %>%
  select(carrier, distance)%>%
  group_by(carrier)%>%
  summarise(total_distance = sum(distance))%>%
  arrange(desc(total_distance))%>%
  head(5)%>%
  left_join(airlines, by  = "carrier")
  
## Q2:Which arrival station was the busiest in December 2013?
ans2 <- flights %>%
  filter(month==12)%>%
  count(dest)%>%
  arrange(-n)%>%
  head(5)%>%
  left_join(airports, by = c("dest"="faa"))%>%
  select(dest, name, n)%>%
  rename(airport_name = name, amount = n)
 
##Q3. Which flight had the longest haul in March 2013?
##  mutate(clean_air_time = ifelse(is.na(air_time), "Missing value", air_time))%>%
ans3 <- flights %>%
  filter(month==3)%>%
  mutate(flight_number = paste0(carrier,flight))%>%
  mutate(clean_air_time = ifelse(is.na(air_time), 0 , air_time))%>%
  select(flight_number, origin, dest, distance, clean_air_time)%>%
  group_by(flight_number, origin, dest)%>%
  summarise(max_distance = max(distance),
            max_air_time = max(clean_air_time))%>%
  arrange(desc(max_distance), desc(max_air_time))%>%
  head(10)
  
print(ans3)
  
## Q4. Which aircraft type has accumulated the most distance ?
flights %>%
  #select(carrier, tailnum, distance)%>%
  group_by(carrier, tailnum)%>%
  summarise(total_distance = sum(distance))%>%
  arrange(desc(total_distance))%>%
  drop_na(tailnum)%>%
  head(10)

##Q5. Which flight experienced the most delayed in November?
ans5 <- flights %>%
  filter(month==11)%>%
  mutate(flight_number = paste0(carrier,flight))%>%
  select(flight_number, origin, dest, sched_dep_time, dep_time, dep_delay)%>%
  group_by(flight_number, origin)%>%
  arrange(desc(dep_delay))%>%
  head(5)
