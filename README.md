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

Example for `suffix_formatter_0`

```r

ggplot(data.frame(x = c("A", "B"), y = c(246090, 1e6)), aes(x, y, fill = x)) + geom_bar(stat = "identity") + scale_y_continuous(labels = suffix_formatter_0) + scale_fill_manual(values = c("tomato", "steelblue"))

```

<img src="https://github.com/mraess/numberFormattR/blob/master/example.png" alt="Step 1" width="100%" />
