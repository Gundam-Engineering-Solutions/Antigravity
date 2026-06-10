import time

class AirlockController:
    def __init__(self, crew_lock_volume_l=4000.0):
        self.volume_l = crew_lock_volume_l
        self.pressure_psi = 14.7  # Standard Earth sea-level cabin pressure
        self.external_tanks_psi = 6000.0  # COPV exterior storage pressure

    def depressurize_for_eva(self, target_reclamation_pct=0.85):
        """Executes the active vacuum pumping and residual venting sequence."""
        print("\n[+] INITIATING DEPRESSURIZATION SEQUENCE")
        print(f"    Initial Crew Lock Pressure: {self.pressure_psi} psi")
        
        # Stage 1: Active Vacuum Pumping
        print("\n    [Stage 1] Sealing inner hatch. Activating high-powered depressurization pump...")
        time.sleep(1)
        reclaimed_pressure = self.pressure_psi * target_reclamation_pct
        self.pressure_psi -= reclaimed_pressure
        print(f"    [Stage 1] Pump reclaims {target_reclamation_pct*100}% of ambient air.")
        print(f"    [Stage 1] Air routed to main station ECLSS for CO2 scrubbing and moisture extraction.")
        print(f"    Current Chamber Pressure: {self.pressure_psi:.2f} psi")

        # Stage 2: Residual Venting
        print("\n    [Stage 2] Mechanical pump efficiency limit reached. Opening exterior vent valve...")
        time.sleep(1)
        print(f"    [Stage 2] Venting residual {self.pressure_psi:.2f} psi through acoustic muffler to space.")
        self.pressure_psi = 0.0
        print(f"    Current Chamber Pressure: {self.pressure_psi:.2f} psi")
        print("\n[!] Vacuum state achieved. Outer hatch is safe to open for EVA.")

    def repressurize_for_ingress(self):
        """Executes the rapid gas flood sequence from exterior COPV tanks."""
        print("\n[+] INITIATING REPRESSURIZATION SEQUENCE")
        print("    Outer hatch sealed and locked.")
        time.sleep(1)
        
        # Opening 6,000 psi exterior lines
        print(f"    Opening high-pressure line valves from external COPV tanks ({self.external_tanks_psi} psi).")
        print("    Flooding Crew Lock with Nitrogen/Oxygen blend...")
        time.sleep(1.5)
        
        self.pressure_psi = 14.7
        print(f"    Equalization valves stepped pressure down to baseline: {self.pressure_psi} psi.")
        print("\n[!] Repressurization complete. Inner hatch is safe to open.")

if __name__ == "__main__":
    airlock = AirlockController()
    
    # Simulate an astronaut exiting the ship
    airlock.depressurize_for_eva()
    
    # Simulate the astronaut returning
    time.sleep(2)
    airlock.repressurize_for_ingress()
