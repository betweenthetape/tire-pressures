pkgload::load_all()
library(dplyr)
library(ggplot2)
library(ggridges)
library(gt)
library(gtExtras)
options(pillar.sigfig = 4)

# ---- Image 1: Spark table ----
high_pressure_spark_list <- results |>
  filter(air_pressure_psi == "25/28") |>
  pull(time_seconds)

low_pressure_spark_list <- results |>
  filter(air_pressure_psi == "18/20") |>
  pull(time_seconds)

image_1 <- results |>
  group_by(air_pressure_psi) |>
  summarise(average_time = mean(time_seconds)) |>
  arrange(desc(average_time)) |>
  add_column(
    `Distribution of times` = list(high_pressure_spark_list, low_pressure_spark_list)
  ) |>
  mutate(
    air_pressure_psi = if_else(
      air_pressure_psi == "25/28",
      "High pressure: 25/58 (front/rear)",
      "Low pressure: 18/20 (front/rear)",
    )
  ) |>
  rename(`Air Pressure (PSI)` = air_pressure_psi, `Average Time (s)` = average_time) |>
  gt() |>
  gt_plt_dist(`Distribution of times`, type = "density") |>
  data_color(columns = 1, palette = c("#fca636", "#9024a4"), alpha = .5) |>
  tab_header(title = md("There was no difference in averages times between high & low pressures")) |>
  fmt_number() |>
  opt_stylize(style = 1, color = "gray")

gtsave_extra(image_1, "inst/scripts/image_1.png", zoom = 10)

# ---- Image 2 ----
image_2 <- results |>
  ggplot(aes(x = time_seconds, y = air_pressure_psi, fill = air_pressure_psi)) +
  geom_density_ridges(scale = 4, alpha = .5) +
  scale_y_discrete(expand = c(0, 0)) +
  scale_x_continuous(expand = c(0, 0)) +
  coord_cartesian(clip = "off") +
  theme_ridges() +
  scale_fill_viridis_d(option = "C", begin = .3, end = .8, guide = "none") +
  labs(
    title = "Higher pressures (yellow) showed greater variance. \nLower pressures (purple) were more consistent.",
    y = "Air pressure front/rear (PSI)",
    x = "Time (s)"
  )

ggsave(
  "inst/scripts/image_2.png",
  plot = image_2,
  width = 2200,
  height = 1250,
  units = "px",
  bg = "white",
  limitsize = FALSE,
  dpi = 330
)

# ---- Image 3 ----
top_5 <- results |>
  arrange(time_seconds) |>
  slice_head(n = 5) |>
  select(air_pressure_psi, time_seconds) |>
  mutate(`Fastest or slowest five runs` = "Fastest")

bottom_5 <- results |>
  arrange(desc(time_seconds)) |>
  slice_head(n = 5) |>
  select(air_pressure_psi, time_seconds) |>
  mutate(`Fastest or slowest five runs` = "Slowest")

image_3 <- bind_rows(top_5, bottom_5) |>
  rename(`Air pressure front/rear (PSI)` = air_pressure_psi, `Time (s)` = time_seconds) |>
  gt() |>
  data_color(columns = 1, palette = c("#9024a4", "#fca636"), alpha = .5) |>
  tab_header(title = md("Higher pressures produced the fastest and slowest runs")) |>
  fmt_number() |>
  opt_stylize(style = 1, color = "gray")

gtsave_extra(image_3, "inst/scripts/image_3.png", zoom = 10)

# ---- Image 4 ----
image_4 <- results |>
  rename(`Time` = time_seconds, `Pressure (PSI)` = air_pressure_psi) |>
  ggplot(aes(x = run, y = `Time`)) +
  geom_point(aes(fill = `Pressure (PSI)`), size = 4, alpha = .8, pch = 21) +
  geom_smooth(colour = "black", se = FALSE, linetype = "dashed", linewidth = .7) +
  theme_minimal() +
  scale_fill_viridis_d(option = "C", begin = .3, end = .8) +
  labs(
    title = "Times improved and then began to plateau",
    x = "Run number",
    y = "Time (s)"
  ) +
  theme_ridges()

ggsave(
  "inst/scripts/image_4.png",
  plot = image_4,
  width = 2200,
  height = 1250,
  units = "px",
  bg = "white",
  limitsize = FALSE,
  dpi = 330
)

# ---- Image 5 ----
image_5 <- results |>
  filter(between(run, 10, 30)) |>
  ggplot(aes(x = time_seconds, y = air_pressure_psi, fill = air_pressure_psi)) +
  geom_density_ridges(scale = 4, alpha = .5) +
  scale_y_discrete(expand = c(0, 0)) +
  scale_x_continuous(expand = c(0, 0)) +
  coord_cartesian(clip = "off") +
  theme_ridges() +
  scale_fill_viridis_d(option = "C", begin = .3, end = .8, guide = "none") +
  labs(
    title = "Higher pressures appear more favourable than \nlower pressures after controlling for a learning period",
    y = "Air pressure front/rear (psi)",
    x = "Time (s)"
  )

ggsave(
  "inst/scripts/image_5.png",
  plot = image_5,
  width = 2200,
  height = 1250,
  units = "px",
  bg = "white",
  limitsize = FALSE,
  dpi = 330
)
