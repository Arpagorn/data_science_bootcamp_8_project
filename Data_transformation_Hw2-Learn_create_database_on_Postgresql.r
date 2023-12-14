##HW2: create database on Postgresql
##- create a few tables about pizza restaurants

res <- dbConnect(PostgreSQL(),
                host = "floppy.db.elephantsql.com",
                port = 5432,
                user = "lcpltvkc",
                password = "5Urv7Vc-XvSIkJ3QsJ9PsCX620qAfOLj",
                dbname = "lcpltvkc")
dbListTables(res)

pizza_menu <- data.frame(id = 1:9,
                        menu = c("Veggie Pizza", "Hawaiian Pizza", "Seafood Pizza","Cheeze pizza", "Parmaham Pizza",
                                 "Beef Burger", "Greek salad", "Corn soup", "Cheese ball"),
                        price =c(230, 250, 350, 330, 275,120, 90, 60,70))

weekend_sales <- data.frame(id = 1:9,
                            amount = c(8, 30, 20, 18, 16, 50, 35, 40, 15))

##sales_weekday <- data.frame(id = 1:9,
                            ##amount = c(15, 35, 50, 25, 22, 400, 75, 80, 215))

dbWriteTable(res, "pizza_menu", pizza_menu)
dbWriteTable(res, "weekend_sales", weekend_sales)

dbGetQuery(res, "select * from pizza_menu")

weekend_sales_table <- dbGetQuery(res, "select menu, price*amount AS total
                                        from pizza_menu 
                                        left join weekend_sales 
                                        on pizza_menu.id = weekend_sales.id")
dbWriteTable(res, "weekend_sales_table", weekend_sales_table)

top_sales <- dbGetQuery(res, "select menu, total from weekend_sales_table order by total desc limit 3")

dbWriteTable(res, "top_sales", top_sales)     
##dbRemoveTable(res, "weekend_sales_table")

dbDisconnect(res)
