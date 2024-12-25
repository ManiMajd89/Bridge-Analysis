# Bridge Analysis and Factor of Safety Calculation

## Overview
This MATLAB project was completed as part of the CIV102 Civil Engineering Bridge Project. It performs a detailed structural analysis of a bridge subjected to train loading. The project demonstrates fundamental principles of structural analysis and design, including shear force, bending moment calculations, and factor of safety (FOS) evaluations for multiple failure modes.

The analysis outputs critical diagrams and calculations to assess the bridge's structural performance and safety under varying load conditions.

---

## Features
1. **Load Distribution**:
   - Models train loads across a discretized bridge length.
   - Calculates reaction forces at supports.

2. **Structural Analysis**:
   - Computes **Shear Force Diagram (SFD)** and **Bending Moment Diagram (BMD)** for multiple train load positions.
   - Derives shear force and bending moment envelopes to identify critical load cases.

3. **Structural Properties**:
   - Calculates key parameters such as centroid, area moment of inertia, and stress distribution in the bridge's cross-section.

4. **Factor of Safety (FOS)**:
   - Evaluates FOS for tension, compression, shear, glue strength, and buckling.

5. **Visualization**:
   - Plots the SFD and BMD for clear understanding of internal forces.
   - Visualizes scaled forces based on FOS to illustrate critical failure points.

---

## Technical Details

### Input Parameters
- **Bridge Length**: 1200 mm, divided into 1 mm segments.
- **Train Weight**: 400 N, distributed evenly across load points.
- **Train Positions**: Simulates train loading at 345 discrete positions.

### Outputs
1. **Shear Force Diagram (SFD)**: Visual representation of shear forces across the bridge length.
2. **Bending Moment Diagram (BMD)**: Visual representation of bending moments along the bridge.
3. **Factors of Safety (FOS)**:
   - Tension
   - Compression
   - Shear
   - Glue strength
   - Buckling

---

## How to Use
1. Clone this repository:
   ```bash
   git clone https://github.com/<your-username>/bridge-analysis.git
   ```
2. Open the MATLAB file in MATLAB.
3. Run the script to perform the analysis:
   ```matlab
   >> run('bridge_analysis.m')
   ```
4. View the output diagrams and FOS results in the generated plots.

---

## Visualizations
- **Shear Force Diagram (SFD)**:
  Displays the variation of shear forces along the bridge length under critical loading.

- **Bending Moment Diagram (BMD)**:
  Shows bending moments across the bridge span, highlighting peak values for design considerations.

- **Scaled Force Diagrams**:
  Illustrates how internal forces relate to FOS values for each failure mode.

---

## Authors
- **[Mani Majd, Charlie Martinez, Shreyaj Pal Choundry ]**

This project was completed as part of the CIV102 Civil Engineering course at the University of Toronto.

