library(ojodb)
library(boomer)

# remotes::install_github("moodymudskipper/boomer")


# Add `boom()` at the end of a pipe to see the result of each consecutive step!
ojo_tbl("case") |>
  filter(case_type == "CF") |>
  boom()


# You can also use `rig()` to see each step of a function call
# Wrap the function name, no quotes or parentheses, in `rig()`, followed by the arguments to the function, wrapped in `()`
rig(ojo_crim_cases)(case_types = "CF", districts = "TULSA")


# More complicated examples:
ojo_tbl("case") |>
  filter(
    case_type == "CF",
    district == "ADAIR"
  ) |>
  left_join(
    ojo_tbl("count"),
    by = c("id" = "case_id"),
    suffix = c("", ".count")
  ) |>
  select(
    id,
    id.count
  ) |>
  group_by(
    id
  ) |>
  mutate(
    n_charges = n()
  ) |>
  ungroup() |>
  summarise(
    avg_n_charges = mean(n_charges)
  ) |>
  boom()
