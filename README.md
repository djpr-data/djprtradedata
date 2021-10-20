
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
