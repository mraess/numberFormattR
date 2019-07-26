
#' Number formatter function
#'
#' This function allows you to add number suffixes, such as k for thousands,
#' or M for millions to ggplots. It does NOT return anything when called by itself. Example scale_y_continuous(labels = suffix_formatter_0)
#'
#' Based on this stackoverflow post https://stackoverflow.com/questions/28159936/formatting-large-currency-or-dollar-values-to-millions-billions
#'
#' @param x A vector of numbers representing an axis in your ggplot.
#' @param digits Defaults to NULL. Here it set to zero for use in plots.
#' @export


suffix_formatter_0 <- function(x, digits = NULL)
              {
                intl <- c(1e3, 1e6, 1e9, 1e12);
                suffixes <- c('k', 'M', 'B', 'T');

                i <- findInterval(x, intl);

                result <- character(length(x));

                # Note: for ggplot2 the last label element of x is NA, so we need to handle it
                ind_format <- !is.na(x) & i > 0;

                # Format only the elements that need to be formatted
                # with suffixes and possible rounding
                result[ind_format] <- paste0(
                  formatC(x[ind_format]/intl[i[ind_format]], format = "f", digits = 0)
                  ,suffixes[i[ind_format]]
                );
                # And leave the rest with no changes
                result[!ind_format] <- as.character(x[!ind_format]);

                return(invisible(result));
              }
