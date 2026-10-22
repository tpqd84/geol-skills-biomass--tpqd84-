# Week 3: Changing the Assumptions
# Exported from https://geol-skills.github.io/exercises/week3-app.html on 2026-10-22.
#
# Each line ending in [label] ---- marks one code box on that page.
# Keep those lines if you want to use 'Import code' on this file later;
# you can change the words before [label].
# Unfinished blanks (______) stop this file from running until you fill them in.

# Introduction [introduction] ----
library("ggplot2")
source("data/fraction_reabsorbed.R")

elec <- read.csv("data/uk_electricity.csv")
imports <- read.csv("data/pellet_imports.csv")
factors <- read.csv("data/emission_factors.csv")
drax <- read.csv("data/drax_generation.csv")

# Constants for scenario calculations (see data/README.md)
# Source: IMO Fourth GHG Study 2020
shipping_co2_per_tkm <- 0.005  # kgCO2 per tonne-km (bulk carrier)

pellet_gj_per_tonne <- 17  #heating value at ~8% moisture
plant_efficiency <- 0.36   #fuel energy that leaves as electricity

#1 MWh = 3.6 GJ, so a tonne of pellets gives 4.7 MWh of *heat* --
#but only 36% of that is electricity
mwh_per_tonne <- pellet_gj_per_tonne / 3.6 * plant_efficiency

# Exercise 1: The CO₂ cost of transport [w3_1] ----
imports_2024 <- imports[imports$year == 2024, ]

imports_2024$transport_co2_kg <-
  imports_2024$import_kt * 1000 *
  imports_2024$transport_km *
  shipping_co2_per_tkm

sum(imports_2024$transport_co2_kg) / 1e9

# Quick check [w3_q1] ----
# Print the shipping CO2 per tonne of pellets delivered, in kg/ton
sum(imports_2024$transport_co2_kg) / sum(imports_2024$import_kt * 1000)

# Extension: would New Zealand be different? [w3_nz] ----
# Setup: these downloads take a few seconds.
webr::install("geosphere")
webr::install("maps")

# Step 1. A representative coordinate for each origin country and for
#         each destination. `maps::world.cities` has a `capital`
#         column; `?world.cities` explains the rest.


# Step 2. Great-circle distance from each origin to each destination.
#         `?geosphere::distHaversine` — note what units it returns.


# Step 3. Redo Exercise 1's shipping CO2 for both destinations and
#         compare. Which origins dominate in each case?

# Exercise 2: What’s counted where [w3_2] ----
stack_factor <- factors$co2_kg_per_mwh[
  factors$fuel == "biomass" &
  factors$scenario == "combustion_only"
]

bio_mwh <- elec$bioenergy_twh[elec$year == 2025] * 1e6

bio_mwh * stack_factor / 1e9

# Exercise 3: The range of defensible answers [exercise-3-the-range-of-defensible-answers] ----
cat(readLines("data/fraction_reabsorbed.R"), sep = "\n")

# 3a. Net CO₂ after 20, 40 and 90 years [w3_3] ----
reabsorbed <- fraction_reabsorbed(c(20, 40, 90), "loblolly_plantation", 25)
reabsorbed

net <- 1060 - 1000 * reabsorbed
net

# Quick check [w3_q2] ----
answer <- 0

# 3b. The picture [w3_4] ----
net <- 1060 - 1000 *
  fraction_reabsorbed(c(20, 40, 90), "loblolly_plantation", 25)

answers <- data.frame(
  label = c("Official", "Chimney only", "Full supply chain",
            "Regrown 20 yr", "Regrown 40 yr", "Regrown 90 yr"),
  co2_kg_per_mwh = c(0, 1000, 1060, net)
)

answers$label <- factor(
  answers$label,
  levels = answers$label[order(answers$co2_kg_per_mwh)]
)

ggplot(answers, aes(x = label, y = co2_kg_per_mwh)) +
  geom_col() +
  geom_hline(yintercept = 410, linetype = "dashed") +
  labs(x = NULL,
       y = expression(CO[2] ~ "(kg per MWh)"),
       title = expression("Biomass" ~ CO[2] * ": the answer depends on the question")) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

# Step 1: Gas [w3_5] ----
# Step 1. `years`: a vector from 0 to 50.  Try `?seq()` or `?":"`


# Step 2. `gas`: extra CO2 in the atmosphere, in Mt, in each of those
#         years. After it's added in year 0, none is removed.


# Step 3. A data frame, `scenarios`, with columns `year` and `gas`;
#         then a ggplot line of gas against year.
years <- 0:50
pulse_mwh <- 41 * 1e6

gas_factor <- factors$co2_kg_per_mwh[
  factors$fuel == "gas" & factors$scenario == "with_supply_chain"
]
gas <- rep(pulse_mwh * gas_factor / 1e9, length(years))

scenarios <- data.frame(year = years, gas = gas)
ggplot(scenarios, aes(x = year)) +
  geom_line(aes(y = gas, colour = "Gas")) +
  labs(x = "Years after generation",
       y = expression("Extra" ~ CO[2] ~ "in the atmosphere (Mt)"),
       colour = NULL)

# Step 2: Biomass, no regrowth [w3_6] ----
# Step 1. `biomass`: extra CO2 in Mt, years 0 to 50, supply chain
#         included.


# Step 2. Add it to `scenarios` as a new column, and redraw the chart
#         with a second geom_line().
bio_factor <- factors$co2_kg_per_mwh[
  factors$fuel == "biomass" & factors$scenario == "with_supply_chain"
]
biomass <- rep(pulse_mwh * bio_factor / 1e9, length(years))
scenarios$biomass <- biomass

ggplot(scenarios, aes(x = year)) +
  geom_line(aes(y = gas, colour = "Gas")) +
  geom_line(aes(y = biomass, colour = "Biomass, no regrowth")) +
  labs(x = "Years after generation",
       y = expression("Extra" ~ CO[2] ~ "in the atmosphere (Mt)"),
       colour = NULL)

# Step 3: Replant [w3_7] ----
# Step 1. The chimney's share of the biomass CO2, in Mt: the part that
#         trees can take back.


# Step 2. `replanted`: `biomass`, less the share of the chimney's CO2
#         that the new trees have taken back by each year.


# Step 3. Add it to `scenarios` and to the chart.
chimney <- pulse_mwh * 1000 / 1e9

replanted <- biomass - chimney *
  fraction_reabsorbed(years, "loblolly_plantation", 25)
scenarios$replanted <- replanted

ggplot(scenarios, aes(x = year)) +
  geom_hline(yintercept = 0, colour = "grey50") +
  geom_line(aes(y = gas, colour = "Gas")) +
  geom_line(aes(y = biomass, colour = "Biomass, no regrowth")) +
  geom_line(aes(y = replanted, colour = "Biomass, replanted")) +
  labs(x = "Years after generation",
       y = expression("Extra" ~ CO[2] ~ "in the atmosphere (Mt)"),
       colour = NULL)

# Quick check [w3_q3] ----
# You can read it off the chart, or ask R: which years have
# `replanted` below zero?
answer <- 0

# Step 4: What would the trees have done anyway? [w3_8] ----
# Step 1. Extra carbon taken up by the standing plantation, in Mt CO2,
#         after each year.


# Step 2. `gas_standing`: `gas`, less that extra uptake.


# Step 3. Add it to `scenarios` and to the chart.
extra_growth <- chimney *
  (fraction_reabsorbed(25 + years, "loblolly_plantation", 25) - 1)
gas_standing <- gas - extra_growth
scenarios$gas_standing <- gas_standing

ggplot(scenarios, aes(x = year)) +
  geom_hline(yintercept = 0, colour = "grey50") +
  geom_line(aes(y = gas, colour = "Gas")) +
  geom_line(aes(y = gas_standing, colour = "Gas, pines left standing")) +
  geom_line(aes(y = biomass, colour = "Biomass, no regrowth")) +
  geom_line(aes(y = replanted, colour = "Biomass, replanted")) +
  labs(x = "Years after generation",
       y = expression("Extra" ~ CO[2] ~ "in the atmosphere (Mt)"),
       colour = NULL)

# Quick check [w3_q4] ----
answer <- -1
