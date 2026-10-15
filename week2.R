# Week 2: Making the Biomass Case
# Exported from https://geol-skills.github.io/exercises/week2-app.html on 2026-10-15.
#
# Each line ending in [label] ---- marks one code box on that page.
# Keep those lines if you want to use 'Import code' on this file later;
# you can change the words before [label].
# Unfinished blanks (______) stop this file from running until you fill them in.

# Introduction [introduction] ----
library("ggplot2")
library("tidyr")
elec <- read.csv("data/uk_electricity.csv")
imports <- read.csv("data/pellet_imports.csv")
factors <- read.csv("data/emission_factors.csv")ggplot(elec, aes(x=year, y =bioenergy_twh))
+geom_line()+
labs(x= "Year", y= "Bioenergy generation /Twh",
       + caption = "Beionergy per Year in Twh")
    +geom_point(

# Exercise 1: One layer, not six [w2_1] ----
# Step 1. Reshape `elec` to long form, keeping `year` as it is and
#         stacking the four fuel columns into a name column and a
#         value column. `?pivot_longer` — and mind the units, the
#         values are all TWh.
elec_long <- pivot_longer(
  elec,
  cols = c(coal_twh, gas_twh, wind_twh, bioenergy_twh),
  names_to = "fuel",
  values_to = "twh"
)

ggplot(elec_long, aes(x = year, y = twh, colour = fuel)) +
  geom_line() +
  labs(x = "Year",
       y = "Generation (TWh)",
       colour = "Fuel",
       title = "UK electricity generation by fuel type",
       caption = "Source: DUKES 2026")

elec_long
# Step 2. Draw all four fuels with a single geom_line(), mapping the
#         fuel column to colour. Label the axes and cite the source.
head(factors)
head()

# Step 3. Print the reshaped data frame (not the plot) as the last
#         line of the block.

# Extension: the labels are still wrong [w2_x1] ----
# Tidier labels.


# Exercise 2: The chart that makes the case [w2_2] ----
# Step 1. Keep just the headline row for each fuel: the `official`
#         scenario, plus `lifecycle` for wind and solar. One row per
#         fuel, five rows in all.
official <- factors[factors$scenario %in% c("official","lifecycle")]
official


# Step 2. A bar chart of CO2 per MWh by fuel, with labelled axes, a
#         title and a source caption.


# Step 3. Print the filtered data frame as the last line.

# Extension: the same data, arguing the other way [w2_x2] ----
# The other chart.

# Exercise 3: Where do the pellets come from? [w2_3] ----
# Step 1. The 2024 rows of `imports`.


# Step 2. A bar chart of import volume by origin, with the bars in
#         size order and the axes labelled.


# Step 3. Print the USA's percentage share of the 2024 total.

# Extension: the map you cannot draw [w2_x3] ----
# Imports, other ways.

# Exercise 4: Bioenergy’s growing share [w2_4] ----
# Step 1. Add a percentage-share column to `elec`.


# Step 2. Plot the share against year, as a line with the individual
#         years marked, labelled and captioned.


# Step 3. Print the year in which the share rose most from the year
#         before. `diff()` gives year-on-year changes, and returns one
#         value fewer than it was given.

# Extension: decompose the rise [w2_x4] ----
# Numerator, denominator.

# Quick check [w2_q1] ----
# Print 2025 wind generation divided by 2025 bioenergy generation.

# Exercise 5: Make your own misleading figure [w2_5] ----
# Step 1. A chart that gives an unrepresentative picture of biomass,
#  using only numbers that are genuinely in the data.


# Step 2. A comment saying what the trick is, and what a reader would
#         have to notice to catch it.

# Extension: brief the opposition [w2_x5] ----
# The other direction.
