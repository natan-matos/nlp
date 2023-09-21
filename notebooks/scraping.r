# load packages
library(tidyverse)
library(vrest)
library(data.table)
library(rlist)

# reviews list
df_final <- list()

# find the number of pages
pageNumns <- page %>%
    html_elements(xpath = "//div[@aria-label='Pagination navigation']") %>%
    html_text() %>%
    str_extract('of \\d+') %>%
    str_remove('of ') %>%
    as.numeric()

# sequence with number of pages
pageSequence <- seq(from = 0, to = (pageNumns * 10)-10, by=10)

# function to extract data
extra_info_extract <- function(ei, txt) {
    str_extract(ei, paste0(txt, ".*")) %>%
    .[!is.na(.)] %>%
    str_extract("\\d+") %>%
    str_replace_na("0") %>%
    as.numeric()
}

# loop
for (i in pageSequence) {

    # url object
    url <- sprintf("https://www.yelp.com/biz/fogo-de-ch%C3%A3o-brazilian-steakhouse-san-diego-3?sort_by=date_asc", i)

    # read the url as an html object
    page <- read_html(url)

    # collect username
    usernames <- page %>%
        html_elements(xpath= "//div[starts-with(@class, ' user-passport')]") %>%
        html_elements(xpaht= ".//span[@class=' css-qgunke']") %>%
        html_text() %>%
        .[.!="Location"]
    
    # collect comments
    comments <- page %>%
        html_elements(xpath= "//div[starts-with(@class, ' review')]") %>%
        html_elements(xpaht= "(.//p[starts-with(@class, 'comment')])[1]") %>%
        html_text()
    
    # collect rating
    ratings <- page %>%
        html_elements(xpaht= "//div[starts-with(@class, ' review')]") %>%
        html_elements(xpaht= "(.//div[contains(@aria-label, 'star rating')])[1]") %>%
        html_attr("aria-label") %>%
        str_remove(" star rating") %>%
        as.numeric()
    
    # collect dates
    the_dates <- page %>%
        html_elements(xpaht= "//div[starts-with(@class, ' review')]") %>%
        html_elements(xpath= ".//button[@type='submit']") %>%

    # assign the extra information 
    useful <- extra_info_extract(extra_info, "Useful")
    funny <- extra_info_extract(extra_info, "Funny")
    cool <- extra_info_extract(extra_info, "Cool")

    # combine objects into a list
    df_new <- list(username = usernames, 
                    dates = the_dates,
                    rating = ratings, 
                    comment = comments,
                    userful = useful, 
                    funny = funny,
                    cool = cool )

    # convert the list into DF
    df_new_table <- as.data.frame(df_new)

    # append the data frame to df_final
    df_final <- rbindlist(list(df_final, df_new_table))

    # random sleep time 
    Sys.sleep(sample(c(15,25), 1))

}

# write the data to a csv file
write_csv(df_final, 'yelp_review_fogo.csv', na = "")