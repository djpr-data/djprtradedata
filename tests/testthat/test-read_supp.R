test_that("read_supp() produce expected output", {
  all_fy <- read_supp()

  expect_type(all_fy, "list")
  expect_s3_class(all_fy, "tbl_df")
  expect_length(all_fy, 5)
  expect_gte(nrow(all_fy), 100000)
  expect_type(all_fy$value, "double")
})
