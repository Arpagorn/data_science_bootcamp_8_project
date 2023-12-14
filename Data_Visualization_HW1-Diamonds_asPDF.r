---
title: "HW1_Data_Visualization_Diamonds"
author: "Amp Arpagorn"
date: "2023-11-23"
output:
  pdf_document: default
  html_document: default
---

# Data Visualization
## HW: Use diamonds dataset to creat 5 charts
```{r include=FALSE}
library(tidyverse)
library(patchwork)
```

Diamonds table
```{r message=TRUE, warning=TRUE}
head(diamonds)
```

**1. Which color of diamond has the most IF clarity?**

```{r}
ggplot(diamonds, aes(color, fill = clarity))+
  geom_bar(position = "dodge")+
  theme_minimal()
```
<p>The chart above displays distribution of clarity across all colors of diamonds.
The bars for each clarity are stacked within each color. <br>
The proportion of **IF** is higher among **G, F**, and **H** colors.<p>

```{r}
diamonds%>%
  filter(clarity == "IF")%>%
  group_by(color)%>%
  count(clarity)%>%
  arrange(desc(n))%>%
  head()
```


**2.What is the correlation between carat and the price?**
```{r}
set.seed(24)
min_diamonds <- sample_frac(diamonds, 0.6)
ggplot(min_diamonds, aes(carat, price)) +
  geom_point()+
  geom_smooth(method = lm, col = "blue", formula = "y ~ x")+
  labs(x="weight of the diamond(Carat)", y="Price(USD)")+
  theme_minimal()
##`geom_smooth()` using formula = 'y ~ x'
```
<p>The graph displays a positive correlation between carat and price,<br>
indicating that as the weight of the diamonds increases, so does their price.<p>


**3. What is the correlation between cut and the price?**
```{r}
ggplot(diamonds, aes(cut, price))+
  geom_boxplot()+
  labs(x="Quality of the cut", y="Price(USD)")+
  theme_minimal()
```
<p> The graph indicates that the premium cut has highest distribution.<br>
The median price is highest for fair, premium, and good cuts, respectively. The diamonds with an ideal cut have the lowest median price.<br>

```{r}
diamonds%>%
  group_by(cut)%>%
  summarise(med_price = median(price))%>%
  arrange(desc(med_price))
```

**4.What is the correlation among carat, cut and price?**
```{r}
set.seed(72)
min_diamonds <- sample_n(diamonds, 7000)
ggplot(min_diamonds, aes(carat, price, col = cut)) +
  geom_point(size= 1)+
  geom_smooth(method = "lm", formula = "y ~ x")+
  theme_minimal()+
  scale_color_brewer(type ="qua", palette = 4)+
  labs(x = "Quality of the cut",
       y="Price(USD)",
       caption= "Source: R studio",
       title = "The relationship between carat, cut, and price")+
  facet_wrap(~cut)
```
<p> The graph illustrates a positive correlation between carat, cut and price.<br>
Then diamonds with higher carat and superior cut quality tend to higher prices.<p>

**5.Which the cut type that generates the highest revenue?**

```{r}
diamonds%>%
  group_by(cut)%>%
  summarise(sum_price = sum(price),
            sum_carat = sum(carat),
            amount = n(),
            avg_price_per_carat = sum_price/sum_carat)%>%
  arrange(desc(sum_price))

```
```{r 10, results = "hide"}
diamonds%>%
  group_by(cut)%>%
  summarise(sum_price = sum(price))%>%
  arrange(desc(sum_price))%>%
  ggplot(aes(cut, sum_price,fill = cut))+
  geom_col()+
  scale_fill_brewer(palette = "Set3")
  theme_minimal()+
  labs(x= "Quality of the cut",
       y = "Revenue (USD)")
```

```{r}
diamonds%>%
  group_by(cut)%>%
  summarise(sum_price = sum(price),
            sum_carat = sum(carat),
            avg = sum_price/sum_carat)%>%
  arrange(desc(sum_price))%>%
  ggplot(aes(cut, avg, fill = cut))+
  geom_col()+
  scale_fill_brewer(palette = "Set3")+
  theme_minimal()+
  labs(x= "Quality of the cut",
       y = "Average price per carat (USD)")
```
<p> **Summary**,

>- Revenue by cut quality <br>
>  If we focused on price by cut quality reveals that diamonds with an ideal cut generate the highest revenue among different quality grades.
  
>- Revenue per carat <br>
> If we considering revenue per carat, Premium-cut diamonds outperform Ideal-cut diamonds. 
> This suggests that focusing on producing more Premium-cut diamonds could potentially increase revenue for diamond suppliers. <p>
