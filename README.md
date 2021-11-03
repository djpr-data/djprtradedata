
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
#> # A tibble: 4,992 x 8
#>    exports_imports indicator     goods_services state                        date       value series_id  unit      
#>    <chr>           <chr>         <chr>          <chr>                        <date>     <dbl> <chr>      <chr>     
#>  1 Exports         Current Price Goods          New South Wales              2011-09-01 11350 A85092741C $ Millions
#>  2 Exports         Current Price Goods          Victoria                     2011-09-01  5756 A85092752K $ Millions
#>  3 Exports         Current Price Goods          Queensland                   2011-09-01 14302 A85092700J $ Millions
#>  4 Exports         Current Price Goods          South Australia              2011-09-01  2959 A85092678X $ Millions
#>  5 Exports         Current Price Goods          Western Australia            2011-09-01 31871 A85092753L $ Millions
#>  6 Exports         Current Price Goods          Australian Capital Territory 2011-09-01     3 A85092743J $ Millions
#>  7 Exports         Current Price Services       New South Wales              2011-09-01  5804 A85092746R $ Millions
#>  8 Exports         Current Price Services       Victoria                     2011-09-01  3256 A85092714W $ Millions
#>  9 Exports         Current Price Services       Queensland                   2011-09-01  2424 A85092681L $ Millions
#> 10 Exports         Current Price Services       South Australia              2011-09-01   565 A85092701K $ Millions
#> # ... with 4,982 more rows
```

Import ABS merchandise exports data with `read_merch()`:

``` r
djprtradedata::read_merch(min_date = as.Date("2021-01-01"),
                          max_date = as.Date("2021-02-01"))
#> Downloading merchandise trade data from 2021-01 to 2021-02
#> # A tibble: 40,757 x 7
#>    date       country_dest           sitc_rev3                                              sitc_rev3_code origin   unit   value
#>    <date>     <chr>                  <chr>                                                  <chr>          <chr>    <chr>  <dbl>
#>  1 2021-01-01 Austria                Agricultural machinery (excl. tractors) and parts the~ 721            Austral~ 000s    3.15
#>  2 2021-01-01 Bangladesh             Agricultural machinery (excl. tractors) and parts the~ 721            Austral~ 000s   24.0 
#>  3 2021-01-01 Belgium                Agricultural machinery (excl. tractors) and parts the~ 721            Austral~ 000s   36.3 
#>  4 2021-01-01 Brazil                 Agricultural machinery (excl. tractors) and parts the~ 721            Austral~ 000s    4.45
#>  5 2021-02-01 Brazil                 Agricultural machinery (excl. tractors) and parts the~ 721            Austral~ 000s    8.54
#>  6 2021-01-01 Canada                 Agricultural machinery (excl. tractors) and parts the~ 721            Austral~ 000s  179.  
#>  7 2021-01-01 China                  Agricultural machinery (excl. tractors) and parts the~ 721            Austral~ 000s  166.  
#>  8 2021-02-01 China                  Agricultural machinery (excl. tractors) and parts the~ 721            Austral~ 000s   85.6 
#>  9 2021-02-01 Christmas Island       Agricultural machinery (excl. tractors) and parts the~ 721            Austral~ 000s   17.0 
#> 10 2021-02-01 Cocos (Keeling) Island Agricultural machinery (excl. tractors) and parts the~ 721            Austral~ 000s    5.37
#> # ... with 40,747 more rows
```

Import ABS International Trade Supplementary Information by calendar
year with `read_supp_cy()`:

``` r
djprtradedata::read_supp_cy(3)
#> # A tibble: 9,702 x 5
#>    item                                                      year  trade subset abs_series                                      
#>    <chr>                                                     <chr> <chr> <chr>  <chr>                                           
#>  1 Manufacturing services on physical inputs owned by others 1999  -     NSW    Table 3.1 International Trade in Services, Cred~
#>  2 Maintenance and repair services n.i.e                     1999  29    NSW    Table 3.1 International Trade in Services, Cred~
#>  3 Transport                                                 1999  2724  NSW    Table 3.1 International Trade in Services, Cred~
#>  4 Passenger (b)                                             1999  1563  NSW    Table 3.1 International Trade in Services, Cred~
#>  5 Freight                                                   1999  235   NSW    Table 3.1 International Trade in Services, Cred~
#>  6 Other                                                     1999  728   NSW    Table 3.1 International Trade in Services, Cred~
#>  7 Postal and courier services (c)                           1999  198   NSW    Table 3.1 International Trade in Services, Cred~
#>  8 Travel                                                    1999  5132  NSW    Table 3.1 International Trade in Services, Cred~
#>  9 Business                                                  1999  623   NSW    Table 3.1 International Trade in Services, Cred~
#> 10 Personal                                                  1999  4509  NSW    Table 3.1 International Trade in Services, Cred~
#> # ... with 9,692 more rows
```

Import ABS International Trade Supplementary Information by financial
year with `read_supp_fy()`:

``` r
djprtradedata::read_supp_fy(3)
#> # A tibble: 9,702 x 5
#>    item                                                      year    trade subset abs_series                                    
#>    <chr>                                                     <chr>   <chr> <chr>  <chr>                                         
#>  1 Manufacturing services on physical inputs owned by others 1998-99 -     NSW    Table 3.1 International Trade in Services, Cr~
#>  2 Maintenance and repair services n.i.e                     1998-99 32    NSW    Table 3.1 International Trade in Services, Cr~
#>  3 Transport                                                 1998-99 2722  NSW    Table 3.1 International Trade in Services, Cr~
#>  4 Passenger (b)                                             1998-99 1544  NSW    Table 3.1 International Trade in Services, Cr~
#>  5 Freight                                                   1998-99 272   NSW    Table 3.1 International Trade in Services, Cr~
#>  6 Other                                                     1998-99 701   NSW    Table 3.1 International Trade in Services, Cr~
#>  7 Postal and courier services (c)                           1998-99 205   NSW    Table 3.1 International Trade in Services, Cr~
#>  8 Travel                                                    1998-99 4841  NSW    Table 3.1 International Trade in Services, Cr~
#>  9 Business                                                  1998-99 589   NSW    Table 3.1 International Trade in Services, Cr~
#> 10 Personal                                                  1998-99 4252  NSW    Table 3.1 International Trade in Services, Cr~
#> # ... with 9,692 more rows
```
