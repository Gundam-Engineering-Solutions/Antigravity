import os
import math
import numpy as np
from sklearn.linear_model import LinearRegression

class ECLSS_Scaler:
    def __init__(self):
        # High Exertion Parameters (Collins Aerospace OXYMOSS constraints)
        self.TANK_PRESSURE_BAR = 207         # ~3,000 PSI 
        self.TANK_VOLUME_L = 6.8             # Standard carbon composite cylinder
        self.SAFETY_FACTOR = 1.3             # 30% emergency cushion
        
        # Scikit-Learn Model for dynamic VO2 prediction
        self.consumption_model = self._train_scikit_model()

    def _train_scikit_model(self):
        """
        Trains a scikit-learn Linear Regression model on mission telemetry.
        Features: [Crew Count, Mission Hours, Average Stress Level (1-10)]
        Target: Total O2 consumed in liters (Uncompressed)
        """
        # Simulated historical training data [Crew, Hours, Stress]
        X_train = np.array([
            [6, 48, 5], [12, 72, 8], [40, 168, 3], 
            [6, 24, 9], [24, 120, 6], [18, 96, 7]
        ])
        # Y_train: Calculated Liters of O2 based on baseline equations
        Y_train = np.array([
            6*48*60*1.8, 12*72*60*2.5, 40*168*60*1.5, 
            6*24*60*3.0, 24*120*60*2.0, 18*96*60*2.2
        ])
        
        model = LinearRegression()
        model.fit(X_train, Y_train)
        return model

    def generate_cad_layout(self, grid_rings: int, mission_hours: int, stress_level: int):
        print(f"--- ANALYZING SHIP SCALE: {grid_rings} RINGS ---")
        
        # 1. Geometry & Crew Capacity
        # Total hex cells = 1 + 3*R*(R+1). Center is empty (maintenance).
        outer_water_cells = 6 * grid_rings
        inner_o2_slots_per_layer = (3 * grid_rings * (grid_rings + 1)) - outer_water_cells
        
        # Crew capacity scales exponentially with the grid footprint
        crew_capacity = int(1.5 * (grid_rings ** 2))
        if crew_capacity < 1: crew_capacity = 1
        
        # 2. Predict Oxygen Demand using scikit-learn
        features = np.array([[crew_capacity, mission_hours, stress_level]])
        predicted_o2_liters = self.consumption_model.predict(features)[0]
        total_o2_needed = predicted_o2_liters * self.SAFETY_FACTOR
        
        # 3. Hardware Requirements
        gas_per_tank = self.TANK_VOLUME_L * self.TANK_PRESSURE_BAR
        tanks_needed = math.ceil(total_o2_needed / gas_per_tank)
        
        # Calculate Vertical Stacking (z_layers)
        z_layers = math.ceil(tanks_needed / inner_o2_slots_per_layer) if inner_o2_slots_per_layer > 0 else 1
        actual_tanks_rendered = z_layers * inner_o2_slots_per_layer
        
        print(f"Calculated Max Crew: {crew_capacity} personnel")
        print(f"Predicted O2 Demand: {predicted_o2_liters:,.2f} Liters")
        print(f"OXYMOSS Tanks Required: {tanks_needed} (Rendered: {actual_tanks_rendered})")
        print(f"Water Substation Modules (Perimeter): {outer_water_cells * z_layers}")
        print(f"Vertical Matrix Tiers Generated: {z_layers}")
        
        # 4. Write Configuration to OpenSCAD Include File
        scad_config = f"""// AUTO-GENERATED ECLSS CONFIGURATION
grid_rings = {grid_rings};
z_layers = {z_layers};
crew_capacity = {crew_capacity};
module_spacing = 160;
wall_thickness = 12;
"""
        with open("eclss_config.scad", "w") as f:
            f.write(scad_config)
        print("Generated 'eclss_config.scad' successfully.")

if __name__ == "__main__":
    scaler = ECLSS_Scaler()
    # Change grid_rings for testing: 2 (Recon), 3 (Frigate), 5 (Capital)
    scaler.generate_cad_layout(grid_rings=3, mission_hours=72, stress_level=8)
