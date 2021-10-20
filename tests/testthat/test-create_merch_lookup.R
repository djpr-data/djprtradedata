test_that("lookup table is as expected", {
  new_lookup <- create_merch_lookup()
  expect_identical(new_lookup, lookup)
  expect_type(new_lookup, "list")
  purrr::map(new_lookup,
    expect_s3_class,
    class = "tbl_df"
  )
})
