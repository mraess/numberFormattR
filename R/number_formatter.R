
#' Number formatter function
#'
#' This function allows you to add a negative "(-)" prefix as well as number suffixes, such as k for thousands, or M for millions.
#'
#' Based on the f2si function from the sitools package and this stackoverflow post with minor changes, such as the currency.
#' https://stackoverflow.com/questions/11340444/is-there-an-r-function-to-format-number-using-unit-prefix/29932218
#'
#' @param number A number you want to format - if it is a vector you'll have to map the function to the vector, e.g.
#' map(vector, number_formatter, rounding = TRUE, digits = 2, currency = TRUE).
#' @param rounding determines if number gets rounded. Defaults to FALSE.
#' @param digits determines the number of decimals for rounding.
#' @param currency determines if the $ sign is prefixed. Defaults to FALSE.
#' @export


number_formatter <- function(number, rounding=FALSE, digits=ifelse(rounding, NA, 6), currency=FALSE)
                            {
                              prefix <- ""
                              if (number<0) {
                                prefix <- "-"
                              }

                              number <- abs(number)
                              lut <- c(1e-24, 1e-21, 1e-18, 1e-15, 1e-12, 1e-09, 1e-06,
                                       0.001, 1, 1000, 1e+06, 1e+09, 1e+12, 1e+15, 1e+18, 1e+21,
                                       1e+24, 1e+27)
                              pre <- c("y", "z", "a", "f", "p", "n", "u", "m", "", "k",
                                       "M", "B", "T", "P", "E", "Z", "Y", NA)

                              ix <- findInterval(number, lut)
                              if (ix>0 && ix<length(lut) && lut[ix]!=1) {
                                if (rounding==TRUE && !is.numeric(digits)) {
                                  sistring <- paste(prefix,round(number/lut[ix]), pre[ix], sep = "")
                                }
                                else if (rounding == TRUE || is.numeric(digits)) {
                                  sistring <- paste(prefix,signif(number/lut[ix], digits), pre[ix],sep="")
                                }

                                else {
                                  sistring <- paste(prefix,number/lut[ix], pre[ix],sep="")
                                }
                              } else {
                                sistring <- paste(prefix,as.character(round(number, digits = digits)),sep="") # the rounding function here ensures that numbers > 0 and < 1000 get rounded as well
                              }

                              if(currency == TRUE && str_detect(sistring, pattern = "[a-zA-Z]")){

                                sistring <- str_replace_all(string = sistring, pattern = "(-?)([0-9]*\\.?[0-9]*[a-zA-Z])", replacement = "\\1$\\2")
                              }

                              else if(currency == TRUE && !str_detect(sistring, pattern = "[a-zA-Z]")){ ## the nesting is the problem here

                                sistring <-     str_replace_all(string = sistring, pattern = "(-?)([0-9]*\\.?[0-9]*)", replacement = "\\1$\\2") %>%
                                  str_replace(pattern = "(\\$)([0-9]*\\.?[0-9]*)(\\$)", replacement = "\\1\\2")


                              }

                              else {

                                sistring <- sistring
                              }

                              return(sistring)
                            }
