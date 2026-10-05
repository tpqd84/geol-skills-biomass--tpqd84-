# Week 1: Meet the Data
# Research Methods — Your first R script
#
# Instructions:
# 1. Work through the exercises on the course website first.
# 2. Copy your code into this file as you go.
# 3. When you're done, save this file, then commit and push
#    using GitHub Desktop.
#
# The data files are in the data/ folder of this repo — the same
# ones you used in the WebR exercises on the course site.


# --- Load the data -----------------------------------------------------------

elec <- read.csv("data/uk_electricity.csv")

# Check what we've got
head(elec)
names(elec)
nrow(elec)


# --- Exercise 1: Explore the data --------------------------------------------

# How many years of data? What fuel types are included?
# Try: str(elec) and summary(elec)



# --- Exercise 2: Plot biomass over time --------------------------------------

# Plot bioenergy generation (TWh) against year.
# What's the trend?



# --- Exercise 3: Add coal for comparison --------------------------------------

# Biomass went up — but is that a big change? Plot coal on the same axes.
# What story do the two trends tell together?



# --- Exercise 4: Summary statistics -------------------------------------------

# Calculate the mean and standard deviation of biomass generation
# for the last 5 years (2020–2024).



# --- Exercise 5: Is biomass a big deal? ---------------------------------------

# What percentage of total UK electricity came from bioenergy in 2024?
# Is that a big number? Compared to what?



# --- Your notes ---------------------------------------------------------------

# Write a few sentences about what you found today. What surprised you?
# What questions do you still have about biomass electricity?
#
#
#
