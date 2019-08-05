# numberFormattR

This is a tiny package that lets you add suffixes, such as k, M, B to numbers and ggplot axes.

Install with 

``` r 
if (!requireNamespace("devtools", quietly = TRUE))
  install.packages("devtools")
devtools::install_github('mraess/numberFormattR')

```
Example for `number_formatter()` 

``` r

map(c(1243,8798383), number_formatter, currency = TRUE, digits = 2) %>% unlist()

```
Output: `[1] "$1.2k" "$8.8M"`



<img src="https://github.com/mraess/numberFormatteR/blob/master/example.png" alt="Step 1" width="50%" />
