#chatbot for pizza shop
menu_id <- c(1,2,3,4,5)
menu_name <- c("Veggie Pizza", "Hawaiian Pizza", "Seafood Pizza", 
          "Cheeze pizza", "Parmaham Pizza")
price <- c(230, 250, 350, 330, 275)
list <- data.frame(menu_id,
                   menu_name,
                   price)

chatbot <- function(){
  print("Welcome to Pizza homemade")
  print("Here is our menu")
  print(list)
  total_price <- 0 
  orders <- data.frame(menu = character(),
                      quantity = numeric(),
                      price =numeric())

  while(TRUE){
    print("What pizza id would you like to order? Or n to end")
    userinput <- readLines("stdin", n=1)

    if(userinput %in% menu_id){
      print("Please enter pizza quantity.")
      numb <-as.numeric(readLines("stdin", n=1))

      if (!is.na(numb) && numb >=1){
                id <- userinput
        pizza_price <-price[menu_id==id]* numb
        sum_price <- sum(pizza_price)
        total_price <-total_price + sum_price

        order_sum <- data.frame(menu = menu_name[menu_id==id],
                      quantity = numb,
                      price =sum_price)
        orders <-rbind(orders, order_sum)

        print("Anything else? Y/N")
        more <- readLines("stdin", n=1)

        if(tolower(more)=="n"){
          break
          }        
        }else {
        print("Invalid amount. Please choose pizza quantity.")
        }
      }else if(tolower(userinput)=="n"){
      break
      } else {
      print("We apologize, the request menu is unavailable. Or n to end.")
      }
      
  }#while
     
print("Thank you for your order")
if (nrow(orders)>0){
  print("Order summary")
  print(orders)
  print(paste("Total", total_price,"Bath"))
} else {
  print ("No order were placed.")
}

}
chatbot()

