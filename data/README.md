# Biomass Mini-Project Data

These datasets support the Weeks 1–4 biomass mini-project: "Is UK
biomass electricity carbon-neutral?"

## Files

### `uk_electricity.csv`

UK electricity generation by fuel type, 2000–2024 (TWh). 25 rows,
wide format (one row per year, one column per fuel).

| Column | Description |
|--------|-------------|
| `year` | Calendar year |
| `coal_twh` | Coal generation (TWh) |
| `gas_twh` | Gas (CCGT + other) generation (TWh) |
| `nuclear_twh` | Nuclear generation (TWh) |
| `wind_twh` | Wind generation, onshore + offshore (TWh) |
| `solar_twh` | Solar PV generation (TWh) |
| `bioenergy_twh` | Thermal renewables generation (TWh) |
| `total_twh` | Total UK electricity generation (TWh) |

**Source:** DUKES 2025 Table 5.6B, converted from GWh to TWh.

**Note:** `bioenergy_twh` uses the DUKES "Thermal renewables"
category, which includes plant biomass (mainly Drax), energy-from-
waste, landfill gas, and other bioenergy. Plant biomass accounts for
roughly two-thirds of the total.


### `pellet_imports.csv`

UK wood pellet imports by country of origin, 2015–2024 (kilotonnes).
57 rows, long format (one row per year × origin).

| Column | Description |
|--------|-------------|
| `year` | Calendar year |
| `origin` | Country/region of origin |
| `import_kt` | Import volume (thousands of tonnes) |
| `transport_km` | Approximate one-way shipping distance (km) |

**Sources:** Forest Research / HMRC (totals and 2024 shares); USDA
FAS (earlier year estimates).

**Caveat:** Country-of-origin shares for 2015–2023 are estimates. The
2024 shares are from official HMRC data.


### `emission_factors.csv`

CO₂ emission factors by fuel and carbon accounting scenario. 12 rows.

| Column | Description |
|--------|-------------|
| `fuel` | Fuel type: biomass, coal, gas, wind, solar |
| `scenario` | Carbon accounting scenario |
| `co2_kg_per_mwh` | kg CO₂ per MWh of electricity generated |
| `notes` | What is included in this estimate |

The biomass rows show how the answer changes depending on what you
include: from 0 (official accounting) to 390 (full supply chain) to
somewhere in between (depending on forest regrowth time). This is the
"assumptions knob" for Week 3 scenario analysis.

For full source details, see the course site data documentation.
