# 🔥 Heat Transfer Through Rod — Conduction & Natural Convection

> **Experimental and numerical study of steady-state and transient heat transfer in a hollow copper rod under horizontal and vertical orientations, including natural convection and radiation effects.**

---

## 📋 Table of Contents

- [Overview](#overview)
- [Experimental Setup](#experimental-setup)
- [Project Structure](#project-structure)
- [Key Parameters](#key-parameters)
- [MATLAB Scripts](#matlab-scripts)
- [How to Run](#how-to-run)
- [Results & Observations](#results--observations)
- [References](#references)
- [Authors](#authors)

---

## Overview

This project investigates **heat transfer through a hollow copper rod** via:

- **Conduction** along the rod (modeled as an extended surface / fin)
- **Natural convection** from the rod surface to ambient air
- **Radiation** losses from the heated surface

The study compares **experimental measurements** with **theoretical correlations** (Churchill–Chu) for both **horizontal** and **vertical** rod orientations. A transient lumped-parameter analysis is also performed to determine effective heat transfer coefficients from cooling curves.

### Key Highlights

| Feature | Description |
|---|---|
| **Material** | Hollow copper rod (OD = 15 mm, ID = 14 mm) |
| **Orientations** | Horizontal & Vertical |
| **Analysis Types** | Steady-state fin analysis, Transient lumped analysis |
| **Correlations** | Churchill–Chu (natural convection), Stefan–Boltzmann (radiation) |
| **Insulation Study** | Thermal conductivity estimation of insulation material |

---

## Experimental Setup

The experiment uses **5 thermocouples** mounted along a **14 cm hollow copper rod** heated at one end. Temperature data is recorded for:

1. **Steady-state heating** — temperature profile along the rod
2. **Transient cooling** — time-series data for lumped analysis

Two orientations are tested:

| Orientation | Setup Image |
|---|---|
| **Horizontal** | ![Horizontal Setup](horizontal%20setup.jpeg) |
| **Vertical** | ![Vertical Setup](vertical%20setup.jpeg) |

---

## Project Structure

```
📁 Heat-Transfer-Through-Rod/
│
├── 📄 README.md                          # This file
├── 📄 .gitignore                         # Git ignore rules
│
├── 🔬 SIMULATION SCRIPTS (MATLAB)
│   ├── horizontal_simulation.m           # Steady-state fin analysis (horizontal)
│   ├── vertical_simulation.m             # Steady-state fin analysis (vertical)
│   ├── horizontal_lumped.m               # Transient lumped analysis (horizontal)
│   ├── vertical_lumped.m                 # Transient lumped analysis (vertical)
│   ├── steadybothcases.m                 # Comparison plot: horizontal vs vertical
│   ├── Tempposition.m                    # Temperature vs position (basic plot)
│   ├── new code.m                        # Additional analysis code
│   │
│   ├── heff_convectivetip.m.txt          # Effective h with convective tip BC
│   └── k_inscalc.m.txt                   # Insulation thermal conductivity calc
│
├── 📊 TRANSIENT TEMPERATURE DATA
│   ├── Transient_cool_horizontal.m       # Transient cooling (horizontal)
│   ├── Transient_cool_vertical.m         # Transient cooling (vertical)
│   ├── Transient_heat_horizontal.m       # Transient heating (horizontal)
│   └── Transient_heat_vertical.m         # Transient heating (vertical)
│
├── 📁 RAW DATA FILES
│   ├── nat cool horizontal (2).txt       # Thermocouple data — horizontal cooling
│   ├── nat cool vertical.txt             # Thermocouple data — vertical cooling
│   ├── nat heat vertical new (1) (1).txt # Thermocouple data — vertical heating
│   └── nat horizontal (2).txt            # Thermocouple data — horizontal heating
│
├── 🖼️ IMAGES
│   ├── horizontal setup.jpeg             # Photo of horizontal experimental setup
│   └── vertical setup.jpeg               # Photo of vertical experimental setup
│
├── 📑 REFERENCES
│   ├── 1-s2.0-S0017931007006400-main.pdf # Reference paper
│   └── 2D_Heat_Conduction.pdf            # 2D heat conduction reference
│
└── 📊 PRESENTATION
    └── Group 18 final revised ppt (1).pptx  # Final project presentation
```

---

## Key Parameters

| Parameter | Symbol | Value | Unit |
|---|---|---|---|
| Rod outer diameter | D_o | 15 | mm |
| Rod inner diameter | D_i | 14 | mm |
| Rod length | L | 140 | mm |
| Rod thermal conductivity (Cu) | k | 385 | W/m·K |
| Ambient temperature | T∞ | 31.3 | °C |
| Emissivity (oxidized Cu) | ε | 0.60–0.65 | — |
| Stefan–Boltzmann constant | σ | 5.67 × 10⁻⁸ | W/m²·K⁴ |

---

## MATLAB Scripts

### 1. Steady-State Fin Analysis

**`horizontal_simulation.m`** / **`vertical_simulation.m`**

These scripts perform:
- Curve fitting of experimental data to the **fin equation** (insulated tip model)
- Extraction of experimental heat transfer coefficient **h_exp** using `lsqcurvefit`
- Calculation of theoretical **h_theo** using:
  - **Churchill–Chu** correlation for natural convection
  - **Linearized radiation** coefficient
- Comparison plots of experimental data vs fitted and theoretical profiles

### 2. Transient Lumped Analysis

**`horizontal_lumped.m`** / **`vertical_lumped.m`**

These scripts:
- Read transient cooling data from `.txt` files
- Calculate **ln(T − T∞)** vs time for each thermocouple
- Perform linear regression to extract **time constants** (τ)
- Compute effective heat transfer coefficient from lumped analysis

### 3. Insulation & Convective Tip Studies

**`heff_convectivetip.m.txt`** — Fits the **convective tip fin model** and decomposes the effective h into convection and radiation components.

**`k_inscalc.m.txt`** — Estimates the **thermal conductivity of insulation** by energy balance between conduction through insulation and convection + radiation from the outer surface.

---

## How to Run

### Prerequisites

- **MATLAB** R2020a or later (requires Optimization Toolbox for `lsqcurvefit`)
- Alternatively, **GNU Octave** with the `optim` package

### Steps

1. **Clone the repository**
   ```bash
   git clone https://github.com/anubhavjha084-web/Heat-tranfer-through-rod-Conduction-and-natural-convection-.git
   cd Heat-tranfer-through-rod-Conduction-and-natural-convection-
   ```

2. **Open MATLAB** and navigate to the project directory

3. **Run a simulation script**
   ```matlab
   >> horizontal_simulation   % For horizontal fin analysis
   >> vertical_simulation     % For vertical fin analysis
   >> steadybothcases         % For comparison plot
   >> horizontal_lumped       % For transient analysis (horizontal)
   ```

4. **View outputs** — Plots will open automatically, and numerical results are printed to the Command Window.

---

## Results & Observations

- **Horizontal orientation** shows **higher heat transfer coefficients** compared to vertical, consistent with enhanced buoyancy-driven flow around horizontal cylinders.
- **Radiation contributes significantly** (~15–25%) to the total heat loss at the operating temperatures (50–100 °C).
- The **corrected fin length** model (accounting for tip heat loss via `L_corr = L + Ac/P`) provides better agreement with experimental data than the idealized insulated tip assumption.
- **Transient lumped analysis** yields effective h values consistent with the steady-state fin fitting approach.

---

## References

1. Churchill, S.W. and Chu, H.H.S., *"Correlating equations for laminar and turbulent free convection from a horizontal cylinder"*, Int. J. Heat Mass Transfer, 1975.
2. Incropera, F.P. and DeWitt, D.P., *"Fundamentals of Heat and Mass Transfer"*, 7th Edition, John Wiley & Sons.
3. Included reference papers in the repository (see `/references` folder).

---

## Authors

**Group 18** — Heat Transfer Innovation Project

---

## License

This project is for **academic and educational purposes**. Feel free to use and modify with proper attribution.
