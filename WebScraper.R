install.packages('selectr')
install.packages("xml2")
install.packages('rvest')
install.packages('stringr')
install.packages('jsonlite')

#loading the package:> 
library(xml2)
library(rvest)
library(stringr)

#Specifying the url for desired website to be scrapped and reading html
url <- 'https://www.amazon.in/dp/B09CGJK2HG/ref=sspa_dk_hqp_detail_aax_0?spLa=ZW5jcnlwdGVkUXVhbGlmaWVyPUFJQ1hUMENaOUNVSU0mZW5jcnlwdGVkSWQ9QTA5MTUxOTcxSDIyTU5INVIxSk1XJmVuY3J5cHRlZEFkSWQ9QTAxODE4MDAzMDhRMkZRUzNaMkdMJndpZGdldE5hbWU9c3BfaHFwX3NoYXJlZCZhY3Rpb249Y2xpY2tSZWRpcmVjdCZkb05vdExvZ0NsaWNrPXRydWU&th=1'
webpage<-read_html(url)


#scrape title of the product> 
title_html <- html_nodes(webpage, 'h1#title')
title <- html_text(title_html)
head(title)

# remove all space and new lines
str_replace_all(title, "[\r\n]" , "")

# scrape the price of the product
price_html <- html_nodes(webpage, "span#priceblock_dealprice")
price <- html_text(price_html)
# print price value
head(price)
# remove spaces and new line 
str_replace_all(price, "[\r\n]" , "")

# scrape product description>
desc_html <- html_nodes(webpage, 'table.a-spacing-micro')
desc <- html_text(desc_html)

# replace new lines and spaces 
desc <- str_replace_all(desc, "[\r\n\t]" , "")
desc <- str_trim(desc)
head(desc)

# scrape product rating 
rate_html <- html_nodes(webpage, 'span#acrPopover')
rate <- html_text(rate_html)

# remove spaces and newlines and tabs 
rate <- str_replace_all(rate, "[\r\n]" , "")
rate <- str_trim(rate)

# print rating of the product
head(rate)

# Scrape size of the product
#size_html <- html_nodes(webpage, 'td.a-span9')
size_html <- html_nodes(webpage, 'span#inline-twister-expanded-dimension-text-size_name')
size <- html_text(size_html)

# remove tab from text
size <- str_trim(size)

# Print product size
head(size)

# Scrape product color
color_html <- html_nodes(webpage, 'span#inline-twister-expanded-dimension-text-color_name')
color <- html_text(color_html)

# remove tabs from text
color <- str_trim(color)

# print product color
head(color)

#Combining all the lists to form a data frame 
product_data <- data.frame(Title = title, Price = price,Description = desc, Rating = rate, Size = size, Color = color)

#Structure of the data frame 
str(product_data)

# Include ‘jsonlite’ library to convert in JSON form
library(jsonlite)

# convert dataframe into JSON format
json_data <- toJSON(product_data)

# print output
cat(json_data)

