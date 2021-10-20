
<!-- README.md is generated from README.Rmd. Please edit that file -->

# djprtradedata

<!-- badges: start -->

[![R-CMD-check](https://github.com/djpr-data/djprtradedata/workflows/R-CMD-check/badge.svg)](https://github.com/djpr-data/djprtradedata/actions)
[![Codecov test
coverage](https://codecov.io/gh/djpr-data/djprtradedata/branch/main/graph/badge.svg)](https://codecov.io/gh/djpr-data/djprtradedata?branch=main)
<!-- badges: end -->

The goal of djprtradedata is to download, tidy and store public data
used in the DJPR Trade Dashboard.

## Install djprtradedata

If you do not have the `devtools` package installed, install it from
CRAN with:

``` r
install.packages("devtools")
```

Install `djprtradedata`:

``` r
devtools::install_github("djpr-data/djprtradedata")
```

## Using djprtradedata

Import ABS balance of payments data by State/Territory with
`read_bop()`:

``` r
djprtradedata::read_bop()
#> # A tibble: 13,728 × 7
#>    exports_imports indicator     goods_services state date       value series_id
#>    <chr>           <chr>         <chr>          <chr> <date>     <dbl> <chr>    
#>  1 Exports         Current Price Goods          New … 2011-09-01 11717 A8509271…
#>  2 Exports         Current Price Goods          Vict… 2011-09-01  5797 A8509273…
#>  3 Exports         Current Price Goods          Quee… 2011-09-01 15150 A8509268…
#>  4 Exports         Current Price Goods          Sout… 2011-09-01  2964 A8509268…
#>  5 Exports         Current Price Goods          West… 2011-09-01 32257 A8509272…
#>  6 Exports         Current Price Goods          Aust… 2011-09-01     3 A8509273…
#>  7 Exports         Current Price Services       New … 2011-09-01  5529 A8509268…
#>  8 Exports         Current Price Services       Vict… 2011-09-01  3093 A8509273…
#>  9 Exports         Current Price Services       Quee… 2011-09-01  2468 A8509272…
#> 10 Exports         Current Price Services       Sout… 2011-09-01   513 A8509273…
#> # … with 13,718 more rows
```

Import ABS merchandise exports data with `read_merch()`:

``` r
djprtradedata::read_merch(min_date = as.Date("2021-01-01"),
                          max_date = as.Date("2021-02-01"))
#> # A tibble: 143,955 × 10
#>    country industry sitc_rev3 time    region value   country_desc  industry_desc
#>    <chr>   <chr>    <chr>     <chr>   <chr>  <chr>   <chr>         <chr>        
#>  1 ANTC    C        011       2021-01 -      85.284  Antarctica    Manufacturing
#>  2 BHRN    C        011       2021-01 -      233.659 Bahrain       Manufacturing
#>  3 BHRN    C        011       2021-02 -      392.542 Bahrain       Manufacturing
#>  4 BADE    C        011       2021-02 -      30.284  Bangladesh    Manufacturing
#>  5 BRAZ    C        011       2021-01 -      594.109 Brazil        Manufacturing
#>  6 BRAZ    C        011       2021-02 -      578.389 Brazil        Manufacturing
#>  7 BRUN    C        011       2021-02 -      0.65    Brunei Darus… Manufacturing
#>  8 CMBD    C        011       2021-01 -      481.318 Cambodia      Manufacturing
#>  9 CMBD    C        011       2021-02 -      142.497 Cambodia      Manufacturing
#> 10 CAN     C        011       2021-01 -      2553.65 Canada        Manufacturing
#> # … with 143,945 more rows, and 2 more variables: region_desc <chr>,
#> #   sitc_rev3_desc <chr>
```
