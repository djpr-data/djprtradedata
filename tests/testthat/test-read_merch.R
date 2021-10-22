test_that("read_merch() works", {
  m <- read_merch(min_date = Sys.Date() - 90)
  expect_s3_class(m, "tbl_df")
  expect_length(m, 10)
  expect_gte(nrow(m), 150000)
})
